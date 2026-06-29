import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/models.dart';

// ── AUTH SERVICE ──────────────────────────────────────

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<AppUser> signUp({
    required String name,
    required String email,
    required String password,
    required UserRole role,
    String? farmName,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await cred.user!.updateDisplayName(name);

    final user = AppUser(
        uid: cred.user!.uid,
        name: name,
        email: email,
        role: role,
        createdAt: DateTime.now());
    await _db.collection('users').doc(cred.user!.uid).set(user.toFirestore());

    // If farmer, create farmer profile doc too
    if (role == UserRole.farmer && farmName != null) {
      final profile = FarmerProfile(
          uid: cred.user!.uid,
          name: name,
          email: email,
          farmName: farmName,
          location: '',
          createdAt: DateTime.now());
      await _db
          .collection('farmers')
          .doc(cred.user!.uid)
          .set(profile.toFirestore());
    }
    return user;
  }

  Future<void> signIn({required String email, required String password}) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  Future<void> signOut() => _auth.signOut();

  Future<void> sendPasswordReset(String email) =>
      _auth.sendPasswordResetEmail(email: email);

  Future<AppUser?> getAppUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return AppUser.fromFirestore(doc);
  }

  Future<FarmerProfile?> getFarmerProfile(String uid) async {
    final doc = await _db.collection('farmers').doc(uid).get();
    if (!doc.exists) return null;
    return FarmerProfile.fromFirestore(doc);
  }

  Future<void> updateFarmerProfile(FarmerProfile profile) =>
      _db.collection('farmers').doc(profile.uid).update(profile.toFirestore());
}

// ── BATCH SERVICE ─────────────────────────────────────

class BatchService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _uuid = const Uuid();

  // Stream all batches for a farmer
  Stream<List<CropBatch>> watchBatches(String farmerId) => _db
      .collection('batches')
      .where('farmerId', isEqualTo: farmerId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((s) => s.docs.map(CropBatch.fromFirestore).toList());

  // Create new crop batch
  Future<CropBatch> createBatch({
    required String farmerId,
    required String cropName,
    required String variety,
    required String plotLocation,
    required double latitude,
    required double longitude,
    required FarmingMethod farmingMethod,
    required DateTime plantedDate,
    required DateTime expectedHarvestDate,
    required double estimatedYieldKg,
    required int quantityPlanted,
    String? notes,
  }) async {
    final now = DateTime.now();
    final id = _uuid.v4();
    final qrData = 'greentrack://batch/$id';
    final batch = CropBatch(
        id: id,
        farmerId: farmerId,
        cropName: cropName,
        variety: variety,
        plotLocation: plotLocation,
        latitude: latitude,
        longitude: longitude,
        farmingMethod: farmingMethod,
        status: CropBatchStatus.planted,
        plantedDate: plantedDate,
        expectedHarvestDate: expectedHarvestDate,
        estimatedYieldKg: estimatedYieldKg,
        quantityPlanted: quantityPlanted,
        notes: notes,
        qrCodeData: qrData,
        createdAt: now,
        updatedAt: now);

    await _db.collection('batches').doc(id).set(batch.toFirestore());
    return batch;
  }

  // Log irrigation
  Future<void> logIrrigation({
    required String batchId,
    required WaterSource source,
    required double volumeLiters,
    required int durationMinutes,
    required String method,
    required DateTime nextScheduled,
  }) async {
    final log = IrrigationLog(
        id: _uuid.v4(),
        irrigatedAt: DateTime.now(),
        source: source,
        volumeLiters: volumeLiters,
        durationMinutes: durationMinutes,
        method: method,
        nextScheduled: nextScheduled);

    await _db.collection('batches').doc(batchId).update({
      'irrigationLogs': FieldValue.arrayUnion([log.toMap()]),
      'updatedAt': Timestamp.fromDate(DateTime.now()),
    });
  }

  // Log pest treatment + start PHI countdown
  Future<void> logPestTreatment({
    required String batchId,
    required String pestName,
    required String diagnosis,
    required String pesticide,
    required String applicationMethod,
    required int phiDays,
  }) async {
    final now = DateTime.now();
    final treatment = PestTreatment(
        pesticide: pesticide,
        applicationMethod: applicationMethod,
        appliedAt: now,
        phiDays: phiDays);

    final pestLog = PestLog(
        id: _uuid.v4(),
        pestName: pestName,
        diagnosis: diagnosis,
        pesticide: pesticide,
        applicationMethod: applicationMethod,
        diagnosedAt: now);

    await _db.collection('batches').doc(batchId).update({
      'status': CropBatchStatus.phiCountdown.name,
      'activeTreatment': treatment.toMap(),
      'pestLogs': FieldValue.arrayUnion([pestLog.toMap()]),
      'updatedAt': Timestamp.fromDate(now),
    });
  }

  // Mark ready to harvest + alert buyers
  Future<void> markReadyToHarvest({
    required String batchId,
    required double estimatedKg,
  }) async {
    final now = DateTime.now();
    await _db.collection('batches').doc(batchId).update({
      'status': CropBatchStatus.readyToHarvest.name,
      'estimatedYieldKg': estimatedKg,
      'buyerAlertSent': now.toIso8601String(),
      'updatedAt': Timestamp.fromDate(now),
    });
  }

  // Log harvest — generates/locks in the QR batch code
  Future<void> logHarvest({
    required String batchId,
    required double actualYieldKg,
    NutritionInfo? nutrition,
  }) async {
    final now = DateTime.now();
    await _db.collection('batches').doc(batchId).update({
      'status': CropBatchStatus.harvested.name,
      'actualHarvestDate': Timestamp.fromDate(now),
      'actualYieldKg': actualYieldKg,
      if (nutrition != null) 'nutrition': nutrition.toMap(),
      'updatedAt': Timestamp.fromDate(now),
    });
  }

  // Mark delivered
  Future<void> markDelivered(String batchId) async {
    final now = DateTime.now();
    await _db.collection('batches').doc(batchId).update({
      'status': CropBatchStatus.delivered.name,
      'deliveredDate': Timestamp.fromDate(now),
      'updatedAt': Timestamp.fromDate(now),
    });
  }

  // Update batch status
  Future<void> updateStatus(String batchId, CropBatchStatus status) =>
      _db.collection('batches').doc(batchId).update({
        'status': status.name,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

  // QR scan trace (consumer-side) — reads batch + farmer profile
  Future<BatchTraceResult?> traceByQr(String batchId) async {
    final batchDoc = await _db.collection('batches').doc(batchId).get();
    if (!batchDoc.exists) return null;
    final batch = CropBatch.fromFirestore(batchDoc);

    final farmerDoc = await _db.collection('farmers').doc(batch.farmerId).get();
    final farmer =
        farmerDoc.exists ? FarmerProfile.fromFirestore(farmerDoc) : null;

    // Build transit chain from batch status history
    final transit = <TransitEvent>[];
    transit.add(TransitEvent(
        location: batch.plotLocation,
        description: 'Planted at ${batch.plotLocation}',
        timestamp: batch.plantedDate,
        emoji: '🌱'));
    if (batch.actualHarvestDate != null) {
      transit.add(TransitEvent(
          location: batch.plotLocation,
          description: 'Harvested and QR-coded',
          timestamp: batch.actualHarvestDate!,
          emoji: '✅'));
    }
    if (batch.deliveredDate != null) {
      transit.add(TransitEvent(
          location: 'Delivery destination',
          description: 'Delivered to buyer',
          timestamp: batch.deliveredDate!,
          emoji: '🚚'));
    }

    return BatchTraceResult(
      batchId: batch.id,
      cropName: batch.cropName,
      variety: batch.variety,
      farmName: farmer?.farmName ?? 'Unknown Farm',
      farmerName: farmer?.name ?? 'Unknown Farmer',
      farmLocation: batch.plotLocation,
      latitude: batch.latitude,
      longitude: batch.longitude,
      farmingMethod: batch.farmingMethod,
      harvestedAt: batch.actualHarvestDate ?? batch.expectedHarvestDate,
      actualYieldKg: batch.actualYieldKg,
      isOrganicCertified: batch.farmingMethod == FarmingMethod.organic,
      phiCompliant: batch.activeTreatment?.isClear ?? true,
      certificationNumber: farmer?.certificationNumber,
      nutrition: batch.nutrition,
      transitEvents: transit,
    );
  }

  // Upload photo to batch
  Future<String> uploadBatchPhoto({
    required String batchId,
    required List<int> imageBytes,
    required String fileName,
  }) async {
    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child('batches/$batchId/$fileName');
    final task = await ref.putData(Uint8List.fromList(imageBytes),
        SettableMetadata(contentType: 'image/jpeg'));
    final url = await task.ref.getDownloadURL();
    await _db.collection('batches').doc(batchId).update({
      'photoUrls': FieldValue.arrayUnion([url]),
    });
    return url;
  }
}
