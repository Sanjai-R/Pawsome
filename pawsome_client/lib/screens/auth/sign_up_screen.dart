import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/provider/auth_provider.dart';
import 'package:pawsome_client/screens/auth/components/sign_up_form.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  // It's time to validate the text field
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _mobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // But still same problem, let's fixed it
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Center(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Create an account",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    SignUpForm(formKey: _formKey, inputs: [
                      {
                        'label': 'Email',
                        'hintText': 'test@gmail.com',
                        'type': 'email',
                        'controller': _email
                      },
                      {
                        'label': 'Username',
                        'hintText': 'test_user',
                        'type': 'text',
                        'controller': _username
                      },
                      {
                        'label': 'Password',
                        'hintText': "*****",
                        'type': 'password',
                        'controller': _password
                      },
                      {
                        'label': 'Mobile',
                        'hintText': "1234567890",
                        'type': 'number',
                        'controller': _mobile
                      },
                    ]),
                    const SizedBox(height: defaultPadding * 1.5),
                    Text(
                      "By creating an account, you agree to our Terms of Service and Privacy Policy",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: defaultPadding * 1.5),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding * 0.75),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Go to home screen
                            Provider.of<AuthProvider>(context, listen: false)
                                .signUp(
                              userName: _username.text,
                              email: _email.text,
                              password: _password.text,
                              phoneNumber: _mobile.text,
                            );

                            _formKey.currentState!.save();
                          }
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            context.go("/login");
                            // Go to sign in screen
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    // const Align(
                    //   alignment: Alignment.center,
                    //   child: Text(
                    //     "OR",
                    //   ),
                    // ),
                    // const SizedBox(height: defaultPadding ),
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: FilledButton.tonal(
                    //     style: FilledButton.styleFrom(
                    //       backgroundColor: secondary,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       padding: const EdgeInsets.all(15),
                    //     ),
                    //     onPressed: () {},
                    //     child: const Text(
                    //       "Continue with Google",
                    //       style: TextStyle(fontSize: 16),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
