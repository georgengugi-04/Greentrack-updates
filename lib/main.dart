import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/screens/splash_screen.dart';
import 'features/auth/screens/onboarding_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/dashboard/screens/main_shell.dart';
import 'features/crops/screens/crop_detail_screen.dart';
import 'features/crops/screens/add_crop_screen.dart';
import 'features/harvest/screens/log_harvest_screen.dart';
import 'features/growth/screens/add_growth_screen.dart';
import 'features/garden/screens/plot_detail_screen.dart';
import 'features/garden/screens/garden_screen.dart';
import 'features/analytics/screens/analytics_screen.dart';
import 'features/notifications/screens/notifications_screen.dart';

// NOTE: MainShell internally manages its own bottom-nav driven pages
// (Dashboard, Crops, Harvest, Profile via IndexedStack) so the shell
// route below only needs a single entry point. Garden and Analytics
// are reached via in-app navigation (push), not bottom tabs, except
// Analytics which also has a direct route for deep-linking.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  runApp(const ProviderScope(child: GreenTrackApp()));
}

final _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash',       builder: (_, __) => const SplashScreen()),
    GoRoute(path: '/onboarding',   builder: (_, __) => const OnboardingScreen()),
    GoRoute(path: '/login',        builder: (_, __) => const LoginScreen()),

    // MainShell handles its own bottom-tab navigation internally
    GoRoute(path: '/dashboard',    builder: (_, __) => const MainShell()),
    GoRoute(path: '/crops',        builder: (_, __) => const MainShell()),
    GoRoute(path: '/harvest',      builder: (_, __) => const MainShell()),
    GoRoute(path: '/profile',      builder: (_, __) => const MainShell()),

    GoRoute(path: '/garden',       builder: (_, __) => const GardenScreen()),
    GoRoute(
      path: '/garden/:id',
      builder: (_, state) => PlotDetailScreen(plotId: state.pathParameters['id']!),
    ),

    GoRoute(
      path: '/crops/add',
      builder: (_, __) => const AddCropScreen(),
    ),
    GoRoute(
      path: '/crops/:id',
      builder: (_, state) => CropDetailScreen(cropId: state.pathParameters['id']!),
    ),

    GoRoute(path: '/harvest/log',  builder: (_, __) => const LogHarvestScreen()),
    GoRoute(path: '/growth/add',   builder: (_, __) => const AddGrowthScreen()),
    GoRoute(path: '/analytics',    builder: (_, __) => const AnalyticsScreen()),
    GoRoute(path: '/notifications',builder: (_, __) => const NotificationsScreen()),
  ],
);

class GreenTrackApp extends ConsumerWidget {
  const GreenTrackApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'GreenTrack',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      routerConfig: _router,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: child!,
        );
      },
    );
  }
}
