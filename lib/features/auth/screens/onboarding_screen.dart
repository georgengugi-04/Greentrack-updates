import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  final _pages = const [
    _OnboardPage(
      emoji: '🌱',
      title: 'Track Every Seed',
      subtitle: 'From Planting to Table',
      description:
          'Log every crop you plant, monitor its growth stages, and never lose track of what\'s growing in your garden.',
      gradient: AppColors.heroGradient,
      features: ['📍 Plot Management', '🌡️ Growth Tracking', '📸 Photo Diary'],
    ),
    _OnboardPage(
      emoji: '📊',
      title: 'Data-Driven Garden',
      subtitle: 'Analytics That Grow With You',
      description:
          'Understand your garden with beautiful charts showing yield trends, water usage, and crop performance over time.',
      gradient: LinearGradient(
        colors: [Color(0xFF1A3A5C), Color(0xFF2B6CB0), Color(0xFF63B3ED)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      features: [
        '📈 Yield Analytics',
        '💧 Water Tracking',
        '🏆 Top Performers'
      ],
    ),
    _OnboardPage(
      emoji: '🌾',
      title: 'Harvest With Purpose',
      subtitle: 'Know Your Impact',
      description:
          'Record every harvest, track where your produce goes, and see how your garden contributes to your family and community.',
      gradient: LinearGradient(
        colors: [Color(0xFF5C3317), Color(0xFFD4A017), Color(0xFFF6D860)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      features: ['🍽️ Consumed', '🛒 Sold at Market', '❤️ Donated'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: _pages.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (_, i) => _pages[i],
          ),
          Positioned(
            top: 52,
            right: 20,
            child: TextButton(
              onPressed: () => context.go('/login'),
              child: Text(
                'Skip',
                style: AppTextStyles.body(
                  14,
                  weight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 32, 48),
      child: Column(
        children: [
          SmoothPageIndicator(
            controller: _controller,
            count: _pages.length,
            effect: ExpandingDotsEffect(
              activeDotColor: Colors.white,
              dotColor: Colors.white.withOpacity(0.3),
              dotHeight: 6,
              dotWidth: 6,
              expansionFactor: 4,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              if (_currentPage > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _controller.previousPage(
                      duration: 300.ms,
                      curve: Curves.easeInOut,
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white.withOpacity(0.4)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Back'),
                  ),
                ),
              if (_currentPage > 0) const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage < _pages.length - 1) {
                      _controller.nextPage(
                        duration: 300.ms,
                        curve: Curves.easeInOut,
                      );
                    } else {
                      context.go('/login');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.forest,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentPage < _pages.length - 1
                        ? 'Next →'
                        : 'Get Started 🌿',
                    style: AppTextStyles.body(
                      14,
                      weight: FontWeight.w700,
                      color: AppColors.forest,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OnboardPage extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final String description;
  final Gradient gradient;
  final List<String> features;

  const _OnboardPage({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.gradient,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),

              // Big emoji illustration
              Center(
                child: Container(
                  width: size.width * 0.55,
                  height: size.width * 0.55,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(emoji,
                        style: TextStyle(fontSize: size.width * 0.22)),
                  ),
                ),
              )
                  .animate()
                  .scale(
                      begin: const Offset(0.7, 0.7),
                      duration: 600.ms,
                      curve: Curves.elasticOut)
                  .fadeIn(duration: 400.ms),

              const SizedBox(height: 48),

              Text(
                subtitle.toUpperCase(),
                style: AppTextStyles.label(
                  color: Colors.white.withOpacity(0.7),
                  letterSpacing: 2,
                ),
              ).animate(delay: 200.ms).fadeIn().slideX(begin: -0.2),

              const SizedBox(height: 8),

              Text(
                title,
                style: AppTextStyles.display(36, color: Colors.white),
              ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.2),

              const SizedBox(height: 16),

              Text(
                description,
                style: AppTextStyles.body(
                  16,
                  color: Colors.white.withOpacity(0.85),
                ),
              ).animate(delay: 400.ms).fadeIn(),

              const SizedBox(height: 32),

              ...features.map((f) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Text(f.split(' ')[0])),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          f.substring(f.indexOf(' ') + 1),
                          style: AppTextStyles.body(
                            14,
                            weight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ).animate(delay: 500.ms).fadeIn().slideX(begin: -0.1)),
            ],
          ),
        ),
      ),
    );
  }
}
