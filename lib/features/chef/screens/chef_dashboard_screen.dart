import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/session/session_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/models.dart';

class ChefDashboardScreen extends ConsumerWidget {
  const ChefDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(sessionProvider);
    final meal = MockData.sampleMeal;

    return Scaffold(
      appBar: AppBar(
        title: Text(user?.restaurantName ?? 'Chef Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(sessionProvider.notifier).signOut();
              Navigator.of(context).popUntil((r) => r.isFirst);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.chefAccent,
        onPressed: () {},
        icon: const Icon(Icons.restaurant),
        label: const Text('Build Meal'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text('Verify suppliers · Build meals · Confirm allergens', style: AppTextStyles.label),
          const SizedBox(height: AppSpacing.md),
          Text('Scan Incoming Batch', style: AppTextStyles.h2),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.chefAccent.withOpacity(0.08),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Row(
              children: [
                const Icon(Icons.qr_code_scanner, color: AppColors.chefAccent, size: 32),
                const SizedBox(width: AppSpacing.md),
                Expanded(child: Text('Scan a crate QR code to verify farm origin, harvest time and certification.', style: AppTextStyles.body)),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Recent Verified Batches', style: AppTextStyles.h2),
          const SizedBox(height: AppSpacing.sm),
          _VerifiedBatchTile(batch: MockData.sampleBatch),
          const SizedBox(height: AppSpacing.lg),
          Text('Your Meals', style: AppTextStyles.h2),
          const SizedBox(height: AppSpacing.sm),
          _MealCard(meal: meal),
        ],
      ),
    );
  }
}

class _VerifiedBatchTile extends StatelessWidget {
  final CropBatch batch;
  const _VerifiedBatchTile({required this.batch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified, color: AppColors.leaf),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${batch.cropName} · ${batch.verifiedWeightKg ?? "—"} kg', style: AppTextStyles.body),
                Text(batch.organicCertified ? 'Organic certified' : 'Not certified', style: AppTextStyles.bodyMuted),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MealCard extends StatelessWidget {
  final Meal meal;
  const _MealCard({required this.meal});

  @override
  Widget build(BuildContext context) {
    final n = meal.nutrition;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(meal.name, style: AppTextStyles.h2),
          const SizedBox(height: AppSpacing.xs),
          Text('${n.calories.toStringAsFixed(0)} kcal · ${n.proteinG.toStringAsFixed(1)}g protein · ${n.carbsG.toStringAsFixed(1)}g carbs', style: AppTextStyles.bodyMuted),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: meal.allergens.map((a) => Chip(
              label: Text('${a.contains ? "Contains" : "May contain"}: ${a.allergenId.label}', style: const TextStyle(fontSize: 11)),
              backgroundColor: a.contains ? const Color(0xFFFCE8E6) : const Color(0xFFFFF3DA),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
