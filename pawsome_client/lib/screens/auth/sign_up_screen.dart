import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/provider/auth_provider.dart';
import 'package:pawsome_client/screens/auth/components/sign_up_form.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // It's time to validate the text field
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _username = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _mobile = TextEditingController();

  var _isLoading = false;

  void _onSubmit() async {

    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      _formKey.currentState!.save();
      final res = await Provider.of<AuthProvider>(context, listen: false).signUp(userName: _username.text, email: _email.text, password: _password.text, phoneNumber: _mobile.text);

      if (!context.mounted) return;
      if (res['status']) {
        setState(() => _isLoading = false);
        context.go('/');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res['message']),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  void checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      context.go('/home');
    }
  }
  @override
  void initState() {
    checkAuth();

    super.initState();
  }
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
                      child: FilledButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding * 0.75),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        onPressed: _isLoading ? null : _onSubmit,
                        icon: _isLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                            : const SizedBox(),
                        label:const Text(
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
