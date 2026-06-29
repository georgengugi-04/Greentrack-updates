import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class RoleSelectScreen extends StatelessWidget {
  const RoleSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.clay,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Logo
              Row(children: [
                Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.canopy,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Center(
                        child: Text('🌿', style: TextStyle(fontSize: 22)))),
                const SizedBox(width: 10),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'green',
                      style: AppTextStyles.serif(22, color: AppColors.canopy)),
                  TextSpan(
                      text: 'track',
                      style: AppTextStyles.serif(22, color: AppColors.soil)),
                  TextSpan(
                      text: '.',
                      style: AppTextStyles.serif(22, color: AppColors.harvest)),
                ])),
              ]),
              const SizedBox(height: 48),
              Text('From soil to\nyour plate.',
                  style: AppTextStyles.serif(34, color: AppColors.soil)),
              const SizedBox(height: 12),
              Text('Full farm-to-table traceability for everyone in the chain.',
                  style: AppTextStyles.sans(15, color: AppColors.slate)),
              const SizedBox(height: 40),
              Text('I am a...',
                  style: AppTextStyles.sans(13,
                      color: AppColors.slateLight, weight: FontWeight.w600)),
              const SizedBox(height: 16),

              // Role cards
              Expanded(
                  child: Column(children: [
                _RoleCard(
                  emoji: '🌾',
                  role: 'Farmer',
                  description:
                      'Track batches, log irrigation, manage pest control & generate QR codes',
                  color: AppColors.canopy,
                  onTap: () => context.go('/signup?role=farmer'),
                ),
                const SizedBox(height: 12),
                _RoleCard(
                  emoji: '🛒',
                  role: 'Grocery Shopper',
                  description:
                      'Scan QR codes to verify origin, freshness & journey of your produce',
                  color: const Color(0xFF6B3FA0),
                  onTap: () => context.go('/signup?role=shopper'),
                ),
                const SizedBox(height: 12),
                _RoleCard(
                  emoji: '👨‍🍳',
                  role: 'Chef',
                  description:
                      'Confirm suppliers deliver what they promise — freshness verified',
                  color: const Color(0xFF922B21),
                  onTap: () => context.go('/signup?role=chef'),
                ),
                const SizedBox(height: 12),
                _RoleCard(
                  emoji: '🥗',
                  role: 'Diner',
                  description:
                      'Know exactly what\'s in your meal — nutrients, origin, freshness',
                  color: const Color(0xFF1A7A6E),
                  onTap: () => context.go('/signup?role=diner'),
                ),
              ])),

              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Already have an account? ',
                    style: AppTextStyles.sans(14, color: AppColors.slate)),
                TextButton(
                    onPressed: () => context.go('/login'),
                    child: const Text('Sign In')),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String emoji, role, description;
  final Color color;
  final VoidCallback onTap;

  const _RoleCard(
      {required this.emoji,
      required this.role,
      required this.description,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border)),
            child: Row(children: [
              Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child:
                          Text(emoji, style: const TextStyle(fontSize: 24)))),
              const SizedBox(width: 14),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(role,
                        style: AppTextStyles.sans(15,
                            weight: FontWeight.w700, color: AppColors.soil)),
                    const SizedBox(height: 2),
                    Text(description,
                        style: AppTextStyles.sans(12, color: AppColors.slate),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                  ])),
              Icon(Icons.chevron_right, color: color, size: 20),
            ]),
          ),
        ),
      );
}
