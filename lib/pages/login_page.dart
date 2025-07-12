import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _employeeIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4A90E2),
              Color(0xFFF5F5F5),
            ],
            stops: [0.4, 0.4],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with decorative circles
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    // Decorative circles
                    Positioned(
                      top: -50,
                      right: -50,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Color(0xFFFFD700), width: 3),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 50,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Color(0xFFFFD700), width: 3),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      left: -30,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Color(0xFFFFD700), width: 3),
                        ),
                      ),
                    ),
                    
                    // Admin Login text
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Text(
                        'Admin Login',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    
                    // LOGIN text
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Form Container
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20),
                      
                      // Employee ID Field
                      Text(
                        'Employee Id',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: _employeeIdController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF5F5F5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 20),
                      
                      // Password Field
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF5F5F5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Enter password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 30),
                      
                      // Login Button
                      ElevatedButton(
                        onPressed: () {
  Navigator.pushNamed(context, '/admin');
},

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2E3A59),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 20),
                      
                      // Forgot Password
                      Center(
                        child: TextButton(
                          onPressed: () {
                            // Add forgot password logic
                          },
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 10),
                      
                      // Sign Up Link
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                  color: Color(0xFF2E3A59),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 30),
                      
                      // Social Login Icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialIcon(Icons.g_mobiledata, () {}),
                          SizedBox(width: 20),
                          _buildSocialIcon(Icons.facebook, () {}),
                          SizedBox(width: 20),
                          _buildSocialIcon(Icons.fingerprint, () {}),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xFFB8A9C9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 30),
        onPressed: onPressed,
      ),
    );
  }
}