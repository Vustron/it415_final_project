// utils
import 'package:babysitterapp/widgets/shared/text_input.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTxt = TextEditingController();
  TextEditingController passTxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomInputWidget(
                textEditingController: emailTxt,
                hintText: '',
                txtType: TextInputType.text,
                labelTxt: 'Email',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomInputWidget(
                textEditingController: passTxt,
                hintText: '',
                txtType: TextInputType.text,
                labelTxt: 'Password',
                isPass: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
