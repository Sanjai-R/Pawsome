import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/provider/auth_provider.dart';
import 'package:pawsome_client/widgets/custom_form_field.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _onSubmit(String email) async {
    if (password.text != confirmPassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Password and Confirm Password does not match'),
        backgroundColor: Colors.red,
      ));
      
    } else {
      setState(() {
        _isLoading = true;
      });
      final res = await Provider.of<AuthProvider>(context, listen: false)
          .resetPassword(email, password.text);
      setState(() {
        _isLoading = false;
      });
      if (res['status']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res['message']),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/login');
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

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // title: Text('Reset Password'),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Reset Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            const SizedBox(height: defaultPadding * 0.5),
            const Text(
              'Create strong password - at least 8 characters with a mix of letters, numbers & symbols',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: defaultPadding * 0.5),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  MyCustomInput(
                    label: "New Password",
                    hintText: "******",
                    type: "password",
                    onSaved: (va) {},
                    controller: password,
                  ),
                  MyCustomInput(
                    label: "Confirm Password",
                    hintText: "******",
                    type: "password",
                    onSaved: (va) {},
                    controller: confirmPassword,
                  ),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding * 0.5),
            SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding * 0.75),
                  ),
                  onPressed: () {
                    _onSubmit(auth.email);
                  },
                  child: const Text('Reset Password',
                      style: TextStyle(fontSize: 18)),
                ))
          ],
        ),
      ),
    );
  }
}
