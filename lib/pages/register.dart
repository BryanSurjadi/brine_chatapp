import 'dart:math';

import 'package:brine_chatapp/services/auth/auth_service.dart';
import 'package:brine_chatapp/components/bri_button.dart';
import 'package:brine_chatapp/components/bri_textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_gradient/animate_gradient.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  final Function()? ontap;

  RegisterPage({super.key, required this.ontap});

  //register function
  register(BuildContext context) {
    final authService = AuthService();
    if (_confirmPwController.text == _pwController.text) {
      try {
        authService.signUpWithEmailPw(
            _emailController.text, _pwController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text(
                  "Password does not match",
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimateGradient(
        primaryColors: const [
          Color.fromARGB(255, 146, 146, 146),
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 16, 14, 14),
        ],
        secondaryColors: const [
          Color.fromARGB(255, 146, 146, 146),
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 16, 14, 14),
        ],
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.comments,
                    size: 120,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  // welcome
                  const SizedBox(height: 5),
                  Text("Brine",
                      style: TextStyle(
                          fontSize: 40.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary)),

                  //email form
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  BriTextField(
                    hintText: "john@gmail.com",
                    obscureText: false,
                    controller: _emailController,
                  ),
                  //password form
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  BriTextField(
                      hintText: "********",
                      obscureText: true,
                      controller: _pwController),

                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Confirm Password",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  BriTextField(
                      hintText: "********",
                      obscureText: true,
                      controller: _confirmPwController),

                  //login btn
                  const SizedBox(
                    height: 25.0,
                  ),
                  BriButton(
                    text: "Register",
                    ontap: () => register(context),
                  ),
                  // redirect signup

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style:
                            TextStyle(color: Colors.white70.withOpacity(0.5)),
                      ),
                      TextButton(
                          onPressed: ontap,
                          child: const Text("Login here",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              )))
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
