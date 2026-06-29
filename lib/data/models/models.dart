import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ── ENUMS ──────────────────────────────────────────────

enum UserRole { farmer, shopper, chef, diner }

enum CropBatchStatus {
  planted,
  growing,
  pestTreatment,
  phiCountdown,
  readyToHarvest,
  harvested,
  delivered;

  String get label {
    switch (this) {
      case CropBatchStatus.planted:
        return 'Planted';
      case CropBatchStatus.growing:
        return 'Growing';
      case CropBatchStatus.pestTreatment:
        return 'Pest Treatment Active';
      case CropBatchStatus.phiCountdown:
        return 'PHI Countdown';
      case CropBatchStatus.readyToHarvest:
        return 'Ready to Harvest';
      case CropBatchStatus.harvested:
        return 'Harvested';
      case CropBatchStatus.delivered:
        return 'Delivered';
    }
  }

  Color get color {
    switch (this) {
      case CropBatchStatus.planted:
        return const Color(0xFF2B6CB0);
      case CropBatchStatus.growing:
        return const Color(0xFF2E7D32);
      case CropBatchStatus.pestTreatment:
        return const Color(0xFFE65100);
      case CropBatchStatus.phiCountdown:
        return const Color(0xFFB83232);
      case CropBatchStatus.readyToHarvest:
        return const Color(0xFFD4880A);
      case CropBatchStatus.harvested:
        return const Color(0xFF1A2E1A);
      case CropBatchStatus.delivered:
        return const Color(0xFF6B3FA0);
    }
  }

  String get emoji {
    switch (this) {
      case CropBatchStatus.planted:
        return '🌱';
      case CropBatchStatus.growing:
        return '🌿';
      case CropBatchStatus.pestTreatment:
        return '🐛';
      case CropBatchStatus.phiCountdown:
        return '⏱️';
      case CropBatchStatus.readyToHarvest:
        return '🌾';
      case CropBatchStatus.harvested:
        return '✅';
      case CropBatchStatus.delivered:
        return '🚚';
    }
  }

  Color get bgColor => color.withOpacity(0.1);

  static CropBatchStatus fromString(String s) => CropBatchStatus.values
      .firstWhere((e) => e.name == s, orElse: () => CropBatchStatus.planted);
}

enum FarmingMethod {
  organic,
  conventional,
  hydroponics,
  permaculture,
  biodynamic;

  String get label {
    switch (this) {
      case FarmingMethod.organic:
        return 'Certified Organic';
      case FarmingMethod.conventional:
        return 'Conventional';
      case FarmingMethod.hydroponics:
        return 'Hydroponics';
      case FarmingMethod.permaculture:
        return 'Permaculture';
      case FarmingMethod.biodynamic:
        return 'Biodynamic';
    }
  }

  static FarmingMethod fromString(String s) => FarmingMethod.values
      .firstWhere((e) => e.name == s, orElse: () => FarmingMethod.conventional);
}

enum WaterSource {
  borehole,
  rainwater,
  municipal,
  river,
  drip;

  String get label {
    switch (this) {
      case WaterSource.borehole:
        return 'Borehole';
      case WaterSource.rainwater:
        return 'Rainwater Harvesting';
      case WaterSource.municipal:
        return 'Municipal Supply';
      case WaterSource.river:
        return 'River / Stream';
      case WaterSource.drip:
        return 'Drip Irrigation';
    }
  }

  static WaterSource fromString(String s) => WaterSource.values
      .firstWhere((e) => e.name == s, orElse: () => WaterSource.municipal);
}

// ── FARMER PROFILE ────────────────────────────────────

class FarmerProfile {
  final String uid, name, email, farmName, location;
  final double latitude, longitude;
  final String? certificationNumber, photoUrl;
  final List<FarmingMethod> methods;
  final DateTime createdAt;

  const FarmerProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.farmName,
    required this.location,
    this.latitude = 0,
    this.longitude = 0,
    this.certificationNumber,
    this.photoUrl,
    this.methods = const [FarmingMethod.conventional],
    required this.createdAt,
  });

  factory FarmerProfile.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return FarmerProfile(
      uid: doc.id,
      name: d['name'] ?? '',
      email: d['email'] ?? '',
      farmName: d['farmName'] ?? '',
      location: d['location'] ?? '',
      latitude: (d['latitude'] ?? 0).toDouble(),
      longitude: (d['longitude'] ?? 0).toDouble(),
      certificationNumber: d['certificationNumber'],
      photoUrl: d['photoUrl'],
      methods: (d['methods'] as List<dynamic>? ?? [])
          .map((m) => FarmingMethod.fromString(m.toString()))
          .toList(),
      createdAt: (d['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'email': email,
        'farmName': farmName,
        'location': location,
        'latitude': latitude,
        'longitude': longitude,
        'certificationNumber': certificationNumber,
        'photoUrl': photoUrl,
        'methods': methods.map((m) => m.name).toList(),
        'createdAt': Timestamp.fromDate(createdAt),
        'role': 'farmer',
      };
}

// ── CROP BATCH ────────────────────────────────────────

class CropBatch {
  final String id, farmerId, cropName, variety, plotLocation;
  final double latitude, longitude;
  final FarmingMethod farmingMethod;
  final CropBatchStatus status;
  final DateTime plantedDate, expectedHarvestDate;
  final DateTime? actualHarvestDate, deliveredDate;
  final double estimatedYieldKg, actualYieldKg;
  final int quantityPlanted;
  final String? notes, qrCodeData;
  final List<String> photoUrls;
  final List<IrrigationLog> irrigationLogs;
  final List<PestLog> pestLogs;
  final PestTreatment? activeTreatment;
  final DateTime createdAt, updatedAt;
  final String? buyerAlertSent;
  final NutritionInfo? nutrition;

  const CropBatch({
    required this.id,
    required this.farmerId,
    required this.cropName,
    required this.variety,
    required this.plotLocation,
    this.latitude = 0,
    this.longitude = 0,
    required this.farmingMethod,
    required this.status,
    required this.plantedDate,
    required this.expectedHarvestDate,
    this.actualHarvestDate,
    this.deliveredDate,
    required this.estimatedYieldKg,
    this.actualYieldKg = 0,
    required this.quantityPlanted,
    this.notes,
    this.qrCodeData,
    this.photoUrls = const [],
    this.irrigationLogs = const [],
    this.pestLogs = const [],
    this.activeTreatment,
    required this.createdAt,
    required this.updatedAt,
    this.buyerAlertSent,
    this.nutrition,
  });

  factory CropBatch.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return CropBatch(
      id: doc.id,
      farmerId: d['farmerId'] ?? '',
      cropName: d['cropName'] ?? '',
      variety: d['variety'] ?? '',
      plotLocation: d['plotLocation'] ?? '',
      latitude: (d['latitude'] ?? 0).toDouble(),
      longitude: (d['longitude'] ?? 0).toDouble(),
      farmingMethod:
          FarmingMethod.fromString(d['farmingMethod'] ?? 'conventional'),
      status: CropBatchStatus.fromString(d['status'] ?? 'planted'),
      plantedDate: (d['plantedDate'] as Timestamp).toDate(),
      expectedHarvestDate: (d['expectedHarvestDate'] as Timestamp).toDate(),
      actualHarvestDate: (d['actualHarvestDate'] as Timestamp?)?.toDate(),
      deliveredDate: (d['deliveredDate'] as Timestamp?)?.toDate(),
      estimatedYieldKg: (d['estimatedYieldKg'] ?? 1.0).toDouble(),
      actualYieldKg: (d['actualYieldKg'] ?? 0.0).toDouble(),
      quantityPlanted: d['quantityPlanted'] ?? 1,
      notes: d['notes'],
      qrCodeData: d['qrCodeData'],
      photoUrls: List<String>.from(d['photoUrls'] ?? []),
      activeTreatment: d['activeTreatment'] != null
          ? PestTreatment.fromMap(d['activeTreatment'])
          : null,
      nutrition:
          d['nutrition'] != null ? NutritionInfo.fromMap(d['nutrition']) : null,
      createdAt: (d['createdAt'] as Timestamp).toDate(),
      updatedAt: (d['updatedAt'] as Timestamp).toDate(),
      buyerAlertSent: d['buyerAlertSent'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        'farmerId': farmerId,
        'cropName': cropName,
        'variety': variety,
        'plotLocation': plotLocation,
        'latitude': latitude,
        'longitude': longitude,
        'farmingMethod': farmingMethod.name,
        'status': status.name,
        'plantedDate': Timestamp.fromDate(plantedDate),
        'expectedHarvestDate': Timestamp.fromDate(expectedHarvestDate),
        'actualHarvestDate': actualHarvestDate != null
            ? Timestamp.fromDate(actualHarvestDate!)
            : null,
        'deliveredDate':
            deliveredDate != null ? Timestamp.fromDate(deliveredDate!) : null,
        'estimatedYieldKg': estimatedYieldKg,
        'actualYieldKg': actualYieldKg,
        'quantityPlanted': quantityPlanted,
        'notes': notes,
        'qrCodeData': qrCodeData,
        'photoUrls': photoUrls,
        'activeTreatment': activeTreatment?.toMap(),
        'nutrition': nutrition?.toMap(),
        'createdAt': Timestamp.fromDate(createdAt),
        'updatedAt': Timestamp.fromDate(updatedAt),
        'buyerAlertSent': buyerAlertSent,
      };

  int get daysInGround => DateTime.now().difference(plantedDate).inDays;
  int get daysToHarvest =>
      expectedHarvestDate.difference(DateTime.now()).inDays;
  bool get isOverdue =>
      daysToHarvest < 0 && status != CropBatchStatus.harvested;
  bool get phiActive =>
      activeTreatment != null && status == CropBatchStatus.phiCountdown;
  int get phiDaysRemaining {
    if (activeTreatment == null) return 0;
    final end = activeTreatment!.appliedAt
        .add(Duration(days: activeTreatment!.phiDays));
    return end.difference(DateTime.now()).inDays.clamp(0, 999);
  }

  bool get canHarvest =>
      !phiActive &&
      phiDaysRemaining == 0 &&
      (status == CropBatchStatus.readyToHarvest ||
          status == CropBatchStatus.growing);
}

// ── IRRIGATION LOG ────────────────────────────────────

class IrrigationLog {
  final String id;
  final DateTime irrigatedAt;
  final WaterSource source;
  final double volumeLiters;
  final int durationMinutes;
  final String method;
  final DateTime nextScheduled;

  const IrrigationLog({
    required this.id,
    required this.irrigatedAt,
    required this.source,
    required this.volumeLiters,
    required this.durationMinutes,
    required this.method,
    required this.nextScheduled,
  });

  factory IrrigationLog.fromMap(Map<String, dynamic> d) => IrrigationLog(
        id: d['id'] ?? '',
        irrigatedAt: (d['irrigatedAt'] as Timestamp).toDate(),
        source: WaterSource.fromString(d['source'] ?? 'municipal'),
        volumeLiters: (d['volumeLiters'] ?? 0).toDouble(),
        durationMinutes: d['durationMinutes'] ?? 0,
        method: d['method'] ?? '',
        nextScheduled: (d['nextScheduled'] as Timestamp).toDate(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'irrigatedAt': Timestamp.fromDate(irrigatedAt),
        'source': source.name,
        'volumeLiters': volumeLiters,
        'durationMinutes': durationMinutes,
        'method': method,
        'nextScheduled': Timestamp.fromDate(nextScheduled),
      };
}

// ── PEST LOG ──────────────────────────────────────────

class PestLog {
  final String id, pestName, diagnosis, pesticide, applicationMethod;
  final DateTime diagnosedAt;
  final List<String> photoUrls;

  const PestLog({
    required this.id,
    required this.pestName,
    required this.diagnosis,
    required this.pesticide,
    required this.applicationMethod,
    required this.diagnosedAt,
    this.photoUrls = const [],
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'pestName': pestName,
        'diagnosis': diagnosis,
        'pesticide': pesticide,
        'applicationMethod': applicationMethod,
        'diagnosedAt': Timestamp.fromDate(diagnosedAt),
        'photoUrls': photoUrls,
      };
}

// ── PEST TREATMENT (PHI enforcer) ─────────────────────

class PestTreatment {
  final String pesticide, applicationMethod;
  final DateTime appliedAt;
  final int phiDays; // Pre-harvest interval in days

  const PestTreatment({
    required this.pesticide,
    required this.applicationMethod,
    required this.appliedAt,
    required this.phiDays,
  });

  factory PestTreatment.fromMap(Map<String, dynamic> d) => PestTreatment(
        pesticide: d['pesticide'] ?? '',
        applicationMethod: d['applicationMethod'] ?? '',
        appliedAt: (d['appliedAt'] as Timestamp).toDate(),
        phiDays: d['phiDays'] ?? 7,
      );

  Map<String, dynamic> toMap() => {
        'pesticide': pesticide,
        'applicationMethod': applicationMethod,
        'appliedAt': Timestamp.fromDate(appliedAt),
        'phiDays': phiDays,
      };

  DateTime get clearDate => appliedAt.add(Duration(days: phiDays));
  bool get isClear => DateTime.now().isAfter(clearDate);
}

// ── NUTRITION INFO ────────────────────────────────────

class NutritionInfo {
  final double caloriesPer100g, proteinG, carbsG, fibreG, fatG;
  final Map<String, double> vitamins;

  const NutritionInfo({
    required this.caloriesPer100g,
    required this.proteinG,
    required this.carbsG,
    required this.fibreG,
    required this.fatG,
    this.vitamins = const {},
  });

  factory NutritionInfo.fromMap(Map<String, dynamic> d) => NutritionInfo(
        caloriesPer100g: (d['caloriesPer100g'] ?? 0).toDouble(),
        proteinG: (d['proteinG'] ?? 0).toDouble(),
        carbsG: (d['carbsG'] ?? 0).toDouble(),
        fibreG: (d['fibreG'] ?? 0).toDouble(),
        fatG: (d['fatG'] ?? 0).toDouble(),
        vitamins: Map<String, double>.from(d['vitamins'] ?? {}),
      );

  Map<String, dynamic> toMap() => {
        'caloriesPer100g': caloriesPer100g,
        'proteinG': proteinG,
        'carbsG': carbsG,
        'fibreG': fibreG,
        'fatG': fatG,
        'vitamins': vitamins,
      };
}

// ── BATCH QR SCAN RESULT ─────────────────────────────

class BatchTraceResult {
  final String batchId, cropName, variety, farmName, farmerName, farmLocation;
  final double latitude, longitude;
  final FarmingMethod farmingMethod;
  final DateTime harvestedAt;
  final double actualYieldKg;
  final bool isOrganicCertified, phiCompliant;
  final String? certificationNumber;
  final NutritionInfo? nutrition;
  final List<TransitEvent> transitEvents;

  const BatchTraceResult({
    required this.batchId,
    required this.cropName,
    required this.variety,
    required this.farmName,
    required this.farmerName,
    required this.farmLocation,
    this.latitude = 0,
    this.longitude = 0,
    required this.farmingMethod,
    required this.harvestedAt,
    required this.actualYieldKg,
    this.isOrganicCertified = false,
    this.phiCompliant = true,
    this.certificationNumber,
    this.nutrition,
    this.transitEvents = const [],
  });
}

class TransitEvent {
  final String location, description;
  final DateTime timestamp;
  final String emoji;

  const TransitEvent({
    required this.location,
    required this.description,
    required this.timestamp,
    required this.emoji,
  });
}

// ── USER ACCOUNT ──────────────────────────────────────

class AppUser {
  final String uid, name, email;
  final UserRole role;
  final String? photoUrl;
  final DateTime createdAt;

  const AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.photoUrl,
    required this.createdAt,
  });

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return AppUser(
      uid: doc.id,
      name: d['name'] ?? '',
      email: d['email'] ?? '',
      role: UserRole.values.firstWhere(
          (r) => r.name == (d['role'] ?? 'shopper'),
          orElse: () => UserRole.shopper),
      photoUrl: d['photoUrl'],
      createdAt: (d['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'email': email,
        'role': role.name,
        'photoUrl': photoUrl,
        'createdAt': Timestamp.fromDate(createdAt),
      };
}
