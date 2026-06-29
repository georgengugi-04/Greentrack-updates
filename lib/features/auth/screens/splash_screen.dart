import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _particleController;

  @override
  void initState() {
    super.initState();
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    Future.delayed(const Duration(milliseconds: 3200), () {
      if (mounted) context.go('/onboarding');
    });
  }

  @override
  void dispose() {
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.heroGradient),
        child: Stack(
          children: [
            // Animated background circles
            ..._buildParticles(size),

            // Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Icon
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: const Center(
                      child: Text('🌿', style: TextStyle(fontSize: 48)),
                    ),
                  )
                      .animate()
                      .scale(
                        begin: const Offset(0.5, 0.5),
                        end: const Offset(1, 1),
                        duration: 600.ms,
                        curve: Curves.elasticOut,
                      )
                      .fadeIn(duration: 400.ms),

                  const SizedBox(height: 24),

                  // Logo text
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'green',
                          style: AppTextStyles.display(38, color: Colors.white),
                        ),
                        TextSpan(
                          text: 'track',
                          style: AppTextStyles.display(
                            38,
                            color: AppColors.mint,
                          ),
                        ),
                        TextSpan(
                          text: '.',
                          style:
                              AppTextStyles.display(38, color: AppColors.amber),
                        ),
                      ],
                    ),
                  )
                      .animate(delay: 300.ms)
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 10),

                  Text(
                    'Cultivating Conscious Consumption',
                    style: AppTextStyles.label(
                      size: 12,
                      color: AppColors.mint.withOpacity(0.8),
                      letterSpacing: 1.5,
                    ),
                  ).animate(delay: 500.ms).fadeIn(duration: 600.ms),

                  const SizedBox(height: 60),

                  // Loading indicator
                  SizedBox(
                    width: 120,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.mint.withOpacity(0.8),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ).animate(delay: 800.ms).fadeIn(duration: 400.ms),
                ],
              ),
            ),

            // Version badge
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Text(
                'v1.0.0',
                textAlign: TextAlign.center,
                style: AppTextStyles.label(
                  color: Colors.white.withOpacity(0.4),
                  letterSpacing: 1,
                ),
              ).animate(delay: 1000.ms).fadeIn(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildParticles(Size size) {
    return List.generate(6, (i) {
      final positions = [
        Offset(0.1, 0.1),
        Offset(0.9, 0.15),
        Offset(0.05, 0.6),
        Offset(0.85, 0.7),
        Offset(0.5, 0.05),
        Offset(0.7, 0.9),
      ];
      final sizes = [80.0, 120.0, 60.0, 100.0, 70.0, 90.0];
      final p = positions[i];

      return Positioned(
        left: size.width * p.dx - sizes[i] / 2,
        top: size.height * p.dy - sizes[i] / 2,
        child: Container(
          width: sizes[i],
          height: sizes[i],
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.mint.withOpacity(0.06 + i * 0.01),
          ),
        ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
              begin: const Offset(0.8, 0.8),
              end: const Offset(1.2, 1.2),
              duration: Duration(seconds: 2 + i),
              curve: Curves.easeInOut,
            ),
      );
    });
  }
}
