import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends ConsumerStatefulWidget {
  static const name = 'signin-screen';

  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {

  bool _obscurePassword = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // final authState = ref.watch(authProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              'Sign In',
              style: TextStyle(
                fontSize: 34,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Color(0xFFA2A2A7),
                ),
                labelStyle: TextStyle(color: Color(0xFFA2A2A7)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFA2A2A7)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF232533), width: 2),
                ),
              ),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 30),

            TextField(
              controller: passwordController,
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
                    color: const Color(0xFFA2A2A7),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
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

                // ref.read(authProvider.notifier)
                //    .login(emailController.text, passwordController.text);

                context.go('/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0066FF),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            RichText(
              text: TextSpan(
                text: "I'm a new user. ",
                style: const TextStyle(color: Colors.white, fontSize: 14),
                children: [
                  TextSpan(
                    text: 'Register',
                    style: const TextStyle(
                      color: Color(0xFF0066FF),
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => context.push('/signup'),
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