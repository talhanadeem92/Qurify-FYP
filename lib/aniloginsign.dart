import 'package:flutter/material.dart';
import 'dart:async';
void main() {
  runApp(QuranApp());
}
class QuranApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginSignupMainScreen(),
    );
  }
}
class LoginSignupMainScreen extends StatefulWidget {
  @override
  _LoginSignupMainScreenState createState() => _LoginSignupMainScreenState();
}

class _LoginSignupMainScreenState extends State<LoginSignupMainScreen>
    with SingleTickerProviderStateMixin {
  bool showLogin = false; // Determines whether to show Login or SignUp
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void toggleForm(bool isLoginSelected) {
    setState(() {
      showLogin = isLoginSelected;
      _controller.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade700, Colors.lightGreen.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // Main Screen with Buttons
            Visibility(
              visible: !showLogin,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Icon and Title
                    Icon(
                      Icons.menu_book,
                      size: 100,
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Welcome to Quran App',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),

                    // Login Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.green.shade800,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => toggleForm(true), // Show Login
                      child: Text('Login', style: TextStyle(fontSize: 18),),
                    ),
                    SizedBox(height: 20),

                    // SignUp Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.green.shade800,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.green.shade800),
                        ),
                      ),
                      onPressed: () => toggleForm(false), // Show SignUp
                      child: Text('Sign Up', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ),

            // Animated Form Screen
            SlideTransition(
              position: _slideAnimation,
              child: Visibility(
                visible: showLogin,
                child: LoginSignupForm(
                  isLogin: showLogin,
                  goBack: () => setState(() {
                    _controller.reverse();
                    Future.delayed(Duration(milliseconds: 500), () {
                      showLogin = false;
                    });
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginSignupForm extends StatelessWidget {
  final bool isLogin;
  final VoidCallback goBack;

  LoginSignupForm({required this.isLogin, required this.goBack});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Back Button
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: goBack,
            ),
          ),

          // Title
          Text(
            isLogin ? 'Login to Quran App' : 'Sign Up for Quran App',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),

          // Email Input
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: Icon(Icons.email, color: Colors.green),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 20),

          // Password Input
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: Icon(Icons.lock, color: Colors.green),
            ),
            obscureText: true,
          ),
          if (!isLogin) SizedBox(height: 20),

          // Confirm Password (Sign Up Only)
          if (!isLogin)
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Confirm Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.lock_outline, color: Colors.green),
              ),
              obscureText: true,
            ),
          SizedBox(height: 30),

          // Submit Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              backgroundColor: Colors.green.shade800,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              if (isLogin) {
                print('Login with: ${emailController.text}');
              } else {
                if (passwordController.text == confirmPasswordController.text) {
                  print('Sign up with: ${emailController.text}');
                } else {
                  print('Passwords do not match');
                }
              }
            },
            child: Text(isLogin ? 'Login' : 'Sign Up', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
