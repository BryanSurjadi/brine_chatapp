import 'package:brine_chatapp/services/auth/auth_service.dart';
import 'package:brine_chatapp/components/bri_button.dart';
import 'package:brine_chatapp/components/bri_textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_gradient/animate_gradient.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  //ontap to regis
  final void Function()? ontap;

  LoginPage({super.key, required this.ontap});

  //login funciton
  login(BuildContext contexts) async {
    //panggil auth service
    final authService = AuthService();

    // login
    try {
      await authService.signInWithEmailPw(
          _emailController.text, _pwController.text);
    }

    //catch errors
    catch (e) {
      showDialog(
          context: contexts,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
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
          Color.fromARGB(255, 222, 222, 222),
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 16, 14, 14),
        ],
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
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

              //login btn
              const SizedBox(
                height: 25.0,
              ),
              BriButton(
                text: "Login",
                ontap: () => login(context),
              ),
              // redirect signup

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.white70.withOpacity(0.5)),
                  ),
                  TextButton(
                      onPressed: ontap,
                      child: const Text("Sign up here",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          )))
                ],
              )
            ],
          )),
        ));
  }
}
