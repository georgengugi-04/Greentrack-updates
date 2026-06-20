import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController(text: 'maria@greentrack.app');
  final _passCtrl  = TextEditingController(text: '••••••••');
  bool _obscure = true;
  bool _loading = false;

  void _login() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1400));
    if (mounted) context.go('/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Top gradient header
          Container(
            height: MediaQuery.of(context).size.height * 0.38,
            decoration: const BoxDecoration(gradient: AppColors.heroGradient),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28, 32, 28, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(child: Text('🌿', style: TextStyle(fontSize: 20))),
                        ),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'green',
                              style: AppTextStyles.display(22, color: Colors.white),
                            ),
                            TextSpan(
                              text: 'track.',
                              style: AppTextStyles.display(22, color: AppColors.mint),
                            ),
                          ]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Welcome Back! 👋',
                      style: AppTextStyles.display(30, color: Colors.white),
                    ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2),
                    const SizedBox(height: 6),
                    Text(
                      'Sign in to continue growing.',
                      style: AppTextStyles.body(
                        15, color: Colors.white.withOpacity(0.75),
                      ),
                    ).animate(delay: 200.ms).fadeIn(),
                  ],
                ),
              ),
            ),
          ),

          // Card form
          Positioned(
            top: MediaQuery.of(context).size.height * 0.30,
            left: 0, right: 0, bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.parchment,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      'Sign In',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Enter your credentials to access your garden',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 28),

                    // Email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email Address',
                          style: Theme.of(context).textTheme.labelMedium),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'your@email.com',
                            prefixIcon: Icon(Icons.email_outlined, size: 20),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Password
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Password',
                          style: Theme.of(context).textTheme.labelMedium),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _passCtrl,
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            hintText: 'Enter password',
                            prefixIcon: const Icon(Icons.lock_outline, size: 20),
                            suffixIcon: IconButton(
                              icon: Icon(_obscure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                                size: 20, color: AppColors.slateLight,
                              ),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Sign in button
                    ElevatedButton(
                      onPressed: _loading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: _loading
                        ? const SizedBox(
                            width: 20, height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2,
                            ),
                          )
                        : const Text('Sign In 🌿'),
                    ),
                    const SizedBox(height: 20),

                    // Divider
                    Row(children: [
                      Expanded(child: Divider(color: AppColors.border)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('or', style: Theme.of(context).textTheme.bodySmall),
                      ),
                      Expanded(child: Divider(color: AppColors.border)),
                    ]),
                    const SizedBox(height: 20),

                    // Google sign in
                    OutlinedButton.icon(
                      onPressed: _login,
                      icon: const Text('🔑', style: TextStyle(fontSize: 18)),
                      label: const Text('Continue with Google'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                    const SizedBox(height: 32),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ",
                          style: Theme.of(context).textTheme.bodyMedium),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Sign Up Free'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ).animate(delay: 200.ms).slideY(begin: 0.1).fadeIn(),
          ),
        ],
      ),
    );
  }
}
