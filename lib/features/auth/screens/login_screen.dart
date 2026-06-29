import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/providers/app_providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true, _loading = false;
  String? _error;

  Future<void> _login() async {
    if (_emailCtrl.text.trim().isEmpty || _passCtrl.text.isEmpty) {
      setState(() => _error = 'Please enter your email and password.');
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await ref
          .read(authServiceProvider)
          .signIn(email: _emailCtrl.text.trim(), password: _passCtrl.text);
    } catch (e) {
      setState(() {
        _error = _friendlyError(e.toString());
        _loading = false;
      });
    }
  }

  String _friendlyError(String raw) {
    if (raw.contains('user-not-found') ||
        raw.contains('wrong-password') ||
        raw.contains('invalid-credential'))
      return 'Incorrect email or password.';
    if (raw.contains('network-request-failed'))
      return 'No internet connection.';
    return 'Sign in failed. Please try again.';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.clay,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Dark green header
                  Container(
                    padding: const EdgeInsets.fromLTRB(28, 40, 28, 48),
                    decoration:
                        const BoxDecoration(gradient: AppColors.heroGradient),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                    child: Text('🌿',
                                        style: TextStyle(fontSize: 18)))),
                            const SizedBox(width: 10),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'green',
                                  style: AppTextStyles.serif(20,
                                      color: Colors.white60)),
                              TextSpan(
                                  text: 'track',
                                  style: AppTextStyles.serif(20,
                                      color: Colors.white)),
                              TextSpan(
                                  text: '.',
                                  style: AppTextStyles.serif(20,
                                      color: AppColors.harvest)),
                            ])),
                          ]),
                          const SizedBox(height: 40),
                          Text('Welcome back.',
                              style:
                                  AppTextStyles.serif(32, color: Colors.white)),
                          const SizedBox(height: 6),
                          Text('Sign in to your account',
                              style: AppTextStyles.sans(14,
                                  color: Colors.white60)),
                        ]),
                  ),

                  // Form
                  Container(
                    transform: Matrix4.translationValues(0, -24, 0),
                    decoration: const BoxDecoration(
                        color: AppColors.clay,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24))),
                    padding: const EdgeInsets.fromLTRB(28, 28, 28, 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (_error != null) ...[
                            Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: AppColors.alert.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color:
                                            AppColors.alert.withOpacity(0.3))),
                                child: Text(_error!,
                                    style: AppTextStyles.sans(13,
                                        color: AppColors.alert))),
                            const SizedBox(height: 16),
                          ],
                          Text('Email',
                              style: Theme.of(context).textTheme.labelMedium),
                          const SizedBox(height: 6),
                          TextField(
                              controller: _emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                  hintText: 'your@email.com',
                                  prefixIcon:
                                      Icon(Icons.email_outlined, size: 20))),
                          const SizedBox(height: 16),
                          Text('Password',
                              style: Theme.of(context).textTheme.labelMedium),
                          const SizedBox(height: 6),
                          TextField(
                              controller: _passCtrl,
                              obscureText: _obscure,
                              onSubmitted: (_) => _login(),
                              decoration: InputDecoration(
                                  hintText: 'Enter password',
                                  prefixIcon:
                                      const Icon(Icons.lock_outline, size: 20),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                          _obscure
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          size: 20,
                                          color: AppColors.slateLight),
                                      onPressed: () => setState(
                                          () => _obscure = !_obscure)))),
                          Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {},
                                  child: const Text('Forgot password?'))),
                          const SizedBox(height: 8),
                          ElevatedButton(
                              onPressed: _loading ? null : _login,
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 50)),
                              child: _loading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                          color: Colors.white, strokeWidth: 2))
                                  : const Text('Sign In')),
                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 20),
                          OutlinedButton(
                              onPressed: () => context.go('/onboarding'),
                              style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 48)),
                              child: const Text('Create New Account')),
                          const SizedBox(height: 16),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account? ",
                                    style: AppTextStyles.sans(13,
                                        color: AppColors.slate)),
                                TextButton(
                                    onPressed: () => context.go('/onboarding'),
                                    child: const Text('Sign Up')),
                              ]),
                        ]),
                  ),
                ]),
          ),
        ),
      );
}
