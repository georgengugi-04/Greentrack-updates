import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/firebase_service.dart';
import '../../data/models/models.dart';

// ── AUTH ──────────────────────────────────────────────

final authServiceProvider = Provider<AuthService>((_) => AuthService());
final batchServiceProvider = Provider<BatchService>((_) => BatchService());

final authStateProvider = StreamProvider<User?>(
    (ref) => ref.read(authServiceProvider).authStateChanges);

final currentUserIdProvider =
    Provider<String?>((ref) => ref.watch(authStateProvider).valueOrNull?.uid);

final appUserProvider = FutureProvider.autoDispose<AppUser?>((ref) async {
  final uid = ref.watch(currentUserIdProvider);
  if (uid == null) return null;
  return ref.read(authServiceProvider).getAppUser(uid);
});

// ── FARMER DATA ───────────────────────────────────────

final farmerBatchesProvider =
    StreamProvider.autoDispose<List<CropBatch>>((ref) {
  final uid = ref.watch(currentUserIdProvider);
  if (uid == null) return const Stream.empty();
  return ref.read(batchServiceProvider).watchBatches(uid);
});

final activeBatchesProvider = Provider.autoDispose<List<CropBatch>>((ref) {
  final batches = ref.watch(farmerBatchesProvider).valueOrNull ?? [];
  return batches.where((b) => b.status != CropBatchStatus.delivered).toList();
});

final phiLockedBatchesProvider = Provider.autoDispose<List<CropBatch>>((ref) {
  final batches = ref.watch(farmerBatchesProvider).valueOrNull ?? [];
  return batches.where((b) => b.phiActive).toList();
});

final readyToHarvestProvider = Provider.autoDispose<List<CropBatch>>((ref) {
  final batches = ref.watch(farmerBatchesProvider).valueOrNull ?? [];
  return batches
      .where((b) => b.status == CropBatchStatus.readyToHarvest && b.canHarvest)
      .toList();
});

final totalYieldProvider = Provider.autoDispose<double>((ref) {
  final batches = ref.watch(farmerBatchesProvider).valueOrNull ?? [];
  return batches.fold(0.0, (sum, b) => sum + b.actualYieldKg);
});

// ── QR TRACE (consumer-side) ─────────────────────────

final traceResultProvider =
    FutureProvider.autoDispose.family<BatchTraceResult?, String>(
  (ref, batchId) => ref.read(batchServiceProvider).traceByQr(batchId),
);
