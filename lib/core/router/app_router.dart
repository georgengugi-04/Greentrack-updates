import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/app_providers.dart';
import '../../data/models/models.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/onboarding/screens/role_select_screen.dart';
import '../../features/farmer/screens/farmer_dashboard.dart';
import '../../features/farmer/screens/new_batch_screen.dart';
import '../../features/farmer/screens/irrigation_screen.dart';
import '../../features/farmer/screens/pest_screen.dart';
import '../../features/farmer/screens/harvest_screen.dart';
import '../../features/scanner/screens/scanner_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      if (authState.isLoading) return null;
      final isLoggedIn = authState.valueOrNull != null;
      final authRoutes = ['/login', '/onboarding'];
      final isAuthRoute =
          authRoutes.any((r) => state.matchedLocation.startsWith(r));
      if (!isLoggedIn && !isAuthRoute) return '/login';
      if (isLoggedIn && isAuthRoute) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(
          path: '/onboarding', builder: (_, __) => const RoleSelectScreen()),
      GoRoute(
        path: '/signup',
        builder: (_, state) {
          final roleStr = state.uri.queryParameters['role'] ?? 'shopper';
          final role = UserRole.values.firstWhere((r) => r.name == roleStr,
              orElse: () => UserRole.shopper);
          return SignupScreen(role: role);
        },
      ),

      // Role-aware home
      GoRoute(
        path: '/home',
        builder: (_, __) => const _RoleRouter(),
      ),

      // Farmer routes
      GoRoute(
          path: '/farmer/batch/new',
          builder: (_, __) => const NewBatchScreen()),
      GoRoute(
          path: '/farmer/irrigate',
          builder: (_, __) => const IrrigationScreen()),
      GoRoute(path: '/farmer/pest', builder: (_, __) => const PestScreen()),
      GoRoute(
          path: '/farmer/harvest',
          builder: (_, __) => const HarvestLogScreen()),

      // Consumer QR scanner — all non-farmer roles
      GoRoute(path: '/scan', builder: (_, __) => const ScannerScreen()),
      GoRoute(
        path: '/trace/:batchId',
        builder: (_, state) => TraceResultScreen(
            batchId: state.pathParameters['batchId']!, onReset: () {}),
      ),
    ],
    errorBuilder: (ctx, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.error}'))),
  );
});

// Routes to farmer dashboard or consumer scanner based on role
class _RoleRouter extends ConsumerWidget {
  const _RoleRouter();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(appUserProvider);
    return userAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (_, __) => const LoginScreen(),
      data: (user) {
        if (user?.role == UserRole.farmer) return const FarmerDashboard();
        return const ScannerScreen(); // shopper, chef, diner all go to scanner
      },
    );
  }
}
