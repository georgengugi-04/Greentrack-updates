import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../session/session_provider.dart';
import '../../data/models/models.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/farmer/screens/farmer_dashboard_screen.dart';
import '../../features/farmer/screens/farmer_plan_screen.dart';
import '../../features/farmer/screens/farmer_batch_detail_screen.dart';
import '../../features/farmer/screens/farmer_pest_diagnosis_screen.dart';
import '../../features/farmer/screens/farmer_harvest_screen.dart';
import '../../features/chef/screens/chef_dashboard_screen.dart';
import '../../features/chef/screens/chef_verify_batch_screen.dart';
import '../../features/chef/screens/chef_meal_builder_screen.dart';
import '../../features/chef/screens/chef_meal_detail_screen.dart';
import '../../features/consumer/screens/consumer_dashboard_screen.dart';
import '../../features/consumer/screens/consumer_scan_result_screen.dart';
import '../../features/shared/screens/qr_scan_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final session = ref.watch(sessionProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final loggedIn = session != null;
      final atLogin = state.matchedLocation == '/login';
      if (!loggedIn && !atLogin) return '/login';
      if (loggedIn && atLogin) {
        switch (session.role) {
          case UserRole.farmer:
            return '/farmer';
          case UserRole.chef:
            return '/chef';
          case UserRole.consumer:
            return '/consumer';
        }
      }
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),

      // ── Farmer shell ──────────────────────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) =>
            FarmerShell(child: child),
        routes: [
          GoRoute(
            path: '/farmer',
            builder: (_, __) => const FarmerDashboardScreen(),
          ),
          GoRoute(
            path: '/farmer/plan',
            builder: (_, __) => const FarmerPlanScreen(),
          ),
          GoRoute(
            path: '/farmer/batch/:id',
            builder: (_, state) =>
                FarmerBatchDetailScreen(batchId: state.pathParameters['id']!),
          ),
          GoRoute(
            path: '/farmer/pest/:batchId',
            builder: (_, state) =>
                FarmerPestDiagnosisScreen(batchId: state.pathParameters['batchId']!),
          ),
          GoRoute(
            path: '/farmer/harvest/:batchId',
            builder: (_, state) =>
                FarmerHarvestScreen(batchId: state.pathParameters['batchId']!),
          ),
          GoRoute(
            path: '/farmer/scan',
            builder: (_, __) => const QRScanScreen(),
          ),
        ],
      ),

      // ── Chef shell ────────────────────────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) => ChefShell(child: child),
        routes: [
          GoRoute(
            path: '/chef',
            builder: (_, __) => const ChefDashboardScreen(),
          ),
          GoRoute(
            path: '/chef/verify',
            builder: (_, __) => const ChefVerifyBatchScreen(),
          ),
          GoRoute(
            path: '/chef/meal/new',
            builder: (_, __) => const ChefMealBuilderScreen(),
          ),
          GoRoute(
            path: '/chef/meal/:id',
            builder: (_, state) =>
                ChefMealDetailScreen(mealId: state.pathParameters['id']!),
          ),
          GoRoute(
            path: '/chef/scan',
            builder: (_, __) => const QRScanScreen(),
          ),
        ],
      ),

      // ── Consumer shell ────────────────────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) => ConsumerShell(child: child),
        routes: [
          GoRoute(
            path: '/consumer',
            builder: (_, __) => const ConsumerDashboardScreen(),
          ),
          GoRoute(
            path: '/consumer/scan',
            builder: (_, __) => const QRScanScreen(),
          ),
          GoRoute(
            path: '/consumer/result/:type/:id',
            builder: (_, state) => ConsumerScanResultScreen(
              targetType: state.pathParameters['type']!,
              targetId: state.pathParameters['id']!,
            ),
          ),
        ],
      ),
    ],
  );
});

// ---------------------------------------------------------------------------
// Navigation shells with bottom nav bars
// ---------------------------------------------------------------------------

class FarmerShell extends StatelessWidget {
  final Widget child;
  const FarmerShell({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index(GoRouterState.of(context).matchedLocation),
        selectedItemColor: AppColors.farmerAccent,
        unselectedItemColor: AppColors.textSecondary,
        onTap: (i) {
          switch (i) {
            case 0:
              context.go('/farmer');
              break;
            case 1:
              context.go('/farmer/plan');
              break;
            case 2:
              context.go('/farmer/scan');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.eco), label: 'Batches'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'QR'),
        ],
      ),
    );
  }

  int _index(String loc) {
    if (loc.startsWith('/farmer/plan') || loc.startsWith('/farmer/batch')) return 1;
    if (loc.startsWith('/farmer/scan')) return 2;
    return 0;
  }
}

class ChefShell extends StatelessWidget {
  final Widget child;
  const ChefShell({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index(GoRouterState.of(context).matchedLocation),
        selectedItemColor: AppColors.chefAccent,
        unselectedItemColor: AppColors.textSecondary,
        onTap: (i) {
          switch (i) {
            case 0:
              context.go('/chef');
              break;
            case 1:
              context.go('/chef/verify');
              break;
            case 2:
              context.go('/chef/meal/new');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Kitchen'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Verify'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Meals'),
        ],
      ),
    );
  }

  int _index(String loc) {
    if (loc.startsWith('/chef/verify')) return 1;
    if (loc.startsWith('/chef/meal')) return 2;
    return 0;
  }
}

class ConsumerShell extends StatelessWidget {
  final Widget child;
  const ConsumerShell({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index(GoRouterState.of(context).matchedLocation),
        selectedItemColor: AppColors.consumerAccent,
        unselectedItemColor: AppColors.textSecondary,
        onTap: (i) {
          switch (i) {
            case 0:
              context.go('/consumer');
              break;
            case 1:
              context.go('/consumer/scan');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
        ],
      ),
    );
  }

  int _index(String loc) {
    if (loc.startsWith('/consumer/scan') || loc.startsWith('/consumer/result')) return 1;
    return 0;
  }
}

// Bring AppColors into scope without another import
class AppColors {
  static const farmerAccent = Color(0xFF40916C);
  static const chefAccent = Color(0xFFB7791F);
  static const consumerAccent = Color(0xFF2D6CDF);
  static const textSecondary = Color(0xFF5C6B62);
}
