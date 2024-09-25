import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance_app/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:attendance_app/screens/registration_screen.dart';
import 'menu_screen.dart';
import 'package:attendance_app/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      User? user = await _authService.signIn(
          _emailController.text, _passwordController.text);
      setState(() {
        _isLoading = false;
      });
      if (user != null) {
        Get.offAll(() => MenuScreen());
      } else {
        Get.snackbar(
          "Login Failed",
          "Invalid user ID or password",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.errorColor,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Login Superviser',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.containerBackground,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Welcome Back!',
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                hintStyle:
                                    TextStyle(color: AppColors.hintTextColor),
                                labelStyle:
                                    TextStyle(color: AppColors.textColor),
                              ),
                              style:
                                  const TextStyle(color: AppColors.textColor),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email cannot be empty';
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                                    .hasMatch(value)) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                hintStyle:
                                    TextStyle(color: AppColors.hintTextColor),
                                labelStyle:
                                    TextStyle(color: AppColors.textColor),
                              ),
                              obscureText: true,
                              style:
                                  const TextStyle(color: AppColors.textColor),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password cannot be empty';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            _isLoading
                                ? const CircularProgressIndicator(
                                    color: AppColors.purple,
                                  )
                                : ElevatedButton(
                                    onPressed: _login,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.purple,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 40,
                                        vertical: 15,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Login',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        if (_isLoading)
                                          const Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () {
                                Get.to(() => const RegistrationScreen());
                              },
                              child: const Text(
                                'Don\'t have an account? Register here!',
                                style: TextStyle(color: AppColors.textColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
