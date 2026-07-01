import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/session/session_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/models.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.xl),
              Text('🌿 GreenTrack', style: AppTextStyles.display),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Cultivating Conscious Consumption',
                style: AppTextStyles.bodyMuted,
              ),
              const SizedBox(height: AppSpacing.xl),
              Text('Continue as', style: AppTextStyles.h2),
              const SizedBox(height: AppSpacing.md),
              _RoleCard(
                role: UserRole.farmer,
                title: 'Farmer',
                subtitle: 'Plan, plant, nurture, track & harvest your crops',
                icon: Icons.agriculture,
                color: AppColors.farmerAccent,
                onTap: () => _enter(context, ref, UserRole.farmer),
              ),
              const SizedBox(height: AppSpacing.md),
              _RoleCard(
                role: UserRole.chef,
                title: 'Chef',
                subtitle: 'Verify suppliers, build meals, confirm allergens',
                icon: Icons.restaurant_menu,
                color: AppColors.chefAccent,
                onTap: () => _enter(context, ref, UserRole.chef),
              ),
              const SizedBox(height: AppSpacing.md),
              _RoleCard(
                role: UserRole.consumer,
                title: 'Consumer / Buyer',
                subtitle: 'Scan a product or meal to see where it came from',
                icon: Icons.qr_code_scanner,
                color: AppColors.consumerAccent,
                onTap: () => _enter(context, ref, UserRole.consumer),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _enter(BuildContext context, WidgetRef ref, UserRole role) {
    ref.read(sessionProvider.notifier).signInAs(role);
    switch (role) {
      case UserRole.farmer:
        context.go('/farmer');
        break;
      case UserRole.chef:
        context.go('/chef');
        break;
      case UserRole.consumer:
        context.go('/consumer');
        break;
    }
  }
}

class _RoleCard extends StatelessWidget {
  final UserRole role;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _RoleCard({
    required this.role,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
          boxShadow: AppShadows.card,
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.h2),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTextStyles.bodyMuted),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
