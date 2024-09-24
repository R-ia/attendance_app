import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance_app/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:attendance_app/screens/registration_screen.dart';
import 'new_menu.dart';
import 'package:attendance_app/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    // User? user = await _authService.signIn(
    //     _emailController.text, _passwordController.text);
    bool user = true;
    if (user != null) {
      Get.offAll(MenuScreen());
    } else {
      Get.snackbar(
        "Login Failed",
        "Invalid user ID or password",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
      print("Login failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Login Superviser',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.containerBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(color: AppColors.hintTextColor),
                        labelStyle: TextStyle(color: AppColors.textColor),
                      ),
                      style: TextStyle(color: AppColors.textColor),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(color: AppColors.hintTextColor),
                        labelStyle: TextStyle(color: AppColors.textColor),
                      ),
                      obscureText: true,
                      style: TextStyle(color: AppColors.textColor),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _login,
                      child:
                          Text('Login', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.purple,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => RegistrationScreen());
                      },
                      child: Text(
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
    );
  }
}
