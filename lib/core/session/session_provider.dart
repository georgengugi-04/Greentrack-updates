import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/models.dart';

/// Holds the currently signed-in user. Null = signed out.
/// Swap this for a Firebase Auth StreamProvider when wiring real auth —
/// the rest of the app only depends on AppUser, not on how it's produced.
class SessionController extends StateNotifier<AppUser?> {
  SessionController() : super(null);

  void signInAs(UserRole role) {
    state = MockData.users.firstWhere((u) => u.role == role);
  }

  void signOut() => state = null;
}

final sessionProvider =
    StateNotifierProvider<SessionController, AppUser?>(
  (ref) => SessionController(),
);
