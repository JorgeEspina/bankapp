import 'package:fluter_test_luis1/features/login/presentation/widgets/social.widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluter_test_luis1/core/assets.dart';
import 'package:flutter/rendering.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        // scrollDirection: Axis.vertical,
        children: [
          Image.asset(
            Assets.loginBackground,
            // height: 500,
            // width: 100,
            // fit: BoxFit.cover,
            // alignment: Aligment.topRight,
          ),
          BodyWidget()
        ],
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )
          ),
          padding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth > 600 
              ? (constraints.maxWidth - 600) /2 + 24
              : 24,
            vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24), // Esapcio entre Welcome y input
              TextField(
                decoration: InputDecoration(
                  hintText: "Ingrese E-mail",
                  border: OutlineInputBorder()
                ),
              ),

              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: "Ingrese Password",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                obscureText: true,
              ),

              const SizedBox(height: 16),
              Text(
                'Forgot password?',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF006FFD),
                ),
              ),

              const SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFF006FFD))),
                onPressed: (){}, 
                child: Text('Login', style: TextStyle(color: Colors.white),)
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member? '),
                  GestureDetector(
                    onTap: () {
                      print('Hola LUIS');
                    },
                    child:  Text(
                      'Register now',
                      style: TextStyle(
                        color: Color(0xFF006FFD),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ]
              ),

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Not a member? ',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Register now',
                      recognizer: TapGestureRecognizer()..onTap = () {
                        print('Hola a todo el mundo');
                      },
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                      )
                    )
                  ],   
                )
              ),

              const SizedBox(height: 16),
              SocialRow(),
            ],
          ),
        );
      }
    );
  }
}

class SocialRow extends StatelessWidget {
  const SocialRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SocialWidget(color: Colors.red, imageAsset: Assets.googleIcon),
      SocialWidget(color: Colors.black, imageAsset:  Assets.appleIcon),
      SocialWidget(color: Colors.blue, imageAsset:  Assets.facebookIcon),
    ],);
  }
}