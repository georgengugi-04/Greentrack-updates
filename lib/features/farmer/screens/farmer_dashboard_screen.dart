import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/session/session_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/models.dart';

class FarmerDashboardScreen extends ConsumerWidget {
  const FarmerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(sessionProvider);
    final batches = [MockData.sampleBatch];

    return Scaffold(
      appBar: AppBar(
        title: Text(user?.farmName ?? 'Farmer Dashboard'),
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
        backgroundColor: AppColors.farmerAccent,
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('New Crop Batch'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text('Plan → Plant → Nurture → Track → Harvest',
              style: AppTextStyles.label),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(child: _StatTile(label: 'Active Batches', value: '${batches.length}')),
              const SizedBox(width: AppSpacing.sm),
              const Expanded(child: _StatTile(label: 'PHI Locked', value: '0')),
              const SizedBox(width: AppSpacing.sm),
              const Expanded(child: _StatTile(label: 'Ready Soon', value: '1')),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Crop Batches', style: AppTextStyles.h2),
          const SizedBox(height: AppSpacing.sm),
          ...batches.map((b) => _BatchCard(batch: b)),
          const SizedBox(height: AppSpacing.lg),
          Text('Quick Actions', style: AppTextStyles.h2),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: const [
              _QuickAction(icon: Icons.water_drop, label: 'Log Irrigation'),
              _QuickAction(icon: Icons.bug_report, label: 'Pest Diagnosis'),
              _QuickAction(icon: Icons.scale, label: 'Log Harvest'),
              _QuickAction(icon: Icons.qr_code, label: 'Generate QR'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  const _StatTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: AppTextStyles.h1),
          Text(label, style: AppTextStyles.bodyMuted),
        ],
      ),
    );
  }
}

class _BatchCard extends StatelessWidget {
  final CropBatch batch;
  const _BatchCard({required this.batch});

  @override
  Widget build(BuildContext context) {
    final locked = batch.harvestLockedByPHI;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(batch.cropName, style: AppTextStyles.h2),
                const SizedBox(height: 2),
                Text(batch.plotName ?? 'Unnamed plot', style: AppTextStyles.bodyMuted),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  batch.stage.name,
                  style: AppTextStyles.label.copyWith(color: AppColors.farmerAccent),
                ),
              ],
            ),
          ),
          if (locked)
            const Chip(
              label: Text('PHI locked'),
              backgroundColor: Color(0xFFFCE8E6),
              labelStyle: TextStyle(color: AppColors.error, fontSize: 12),
            )
          else
            Icon(Icons.check_circle, color: AppColors.leaf),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  const _QuickAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.farmerAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.farmerAccent),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyles.body),
        ],
      ),
    );
  }
}
