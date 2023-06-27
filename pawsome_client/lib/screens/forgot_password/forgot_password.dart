import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/provider/auth_provider.dart';
import 'package:pawsome_client/widgets/custom_button.dart';
import 'package:pawsome_client/widgets/custom_form_field.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({
    super.key,
  });

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _isLoading = false;
  final TextEditingController controller = TextEditingController();

  void _onSubmit() async {
    setState(() {
      _isLoading = true;
    });

    Provider.of<AuthProvider>(context, listen: false).setEmail(controller.text);
    final res = await Provider.of<AuthProvider>(context, listen: false)
        .SendOtp(controller.text);

    setState(() {
      _isLoading = false;
    });

    if (res['status']) {
      controller.text = '';
      context.go('/forgot-password/verify-otp');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res['message']),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.go('/login');
        },
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: defaultPadding * 2, horizontal: defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Forgot Password?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
            const SizedBox(height: defaultPadding * 1.5),
            const Text(
              'Please enter the e-mail address associated with your account, and we\'ll send a link to reset your password.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: defaultPadding * 0.5),
            MyCustomInput(
              label: "Email Address",
              hintText: "test@gmail.com",
              type: "email",
              onSaved: (value) {},
              controller: controller,
            ),
            const SizedBox(height: defaultPadding * 0.5),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding * 0.75),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _onSubmit,
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Send Otp",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )),
            )
          ],
        ),
      ),
    );
  }
}
