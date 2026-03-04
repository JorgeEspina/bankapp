import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  static const name = 'signup-screen';

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignInScreen> {
  bool _obscurePassword = true; // controla visibilidad de la contraseña

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 34,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Email
            TextField(
              decoration: InputDecoration(
                labelText: 'Email Address',
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: Color(0xFFA2A2A7),
                ),
                filled: true,
                fillColor: Colors.transparent, // fondo transparente
                labelStyle: const TextStyle(color: Color(0xFFA2A2A7)),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFA2A2A7),
                  ), // línea inferior gris
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF232533),
                    width: 2,
                  ), // línea azul al enfocar
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 0,
                ),
              ),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 30),
            // Password
            TextField(
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: Color(0xFFA2A2A7),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility
                        : Icons.visibility_off_outlined,
                    color: Color(0xFFA2A2A7),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                filled: true,
                fillColor: Colors.transparent,
                labelStyle: const TextStyle(color: Color(0xFFA2A2A7)),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFA2A2A7)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF232533), width: 2),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                context.go('/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0066FF),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              //textAlign: TextAlign.center,
              text: TextSpan(
                text: "I'm a new user. ",
                style: const TextStyle(color: Colors.white, fontSize: 14),
                children: [
                  TextSpan(
                    text: 'Sign In',
                    style: const TextStyle(
                      color: Color(0xFF0066FF),
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => context.push('/home')
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
