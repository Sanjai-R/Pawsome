import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pawsome_client/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  List<String> otpDigits = List.generate(5, (index) => '');
  bool _isLoading = false;

  void _onSubmit(email) async {
    setState(() {
      _isLoading = true;
    });
    String otp = otpDigits.join();
    final res = await Provider.of<AuthProvider>(context, listen: false)
        .verifyOtp(email, otp);

    setState(() {
      _isLoading = false;
    });

    if (context.mounted) {
      if (res['status']) {
        context.go('/forgot-password/reset-password');
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
        leading: BackButton(
          onPressed: () {
            context.go('/forgot-password');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'OTP Verification',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 14),
            Text.rich(
              TextSpan(
                text: 'Enter the code sent to your ',
                style: const TextStyle(
                  fontSize: 16,
                ),
                children: [
                  TextSpan(
                    text: auth.email,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 60,
                  height: 60,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    onChanged: (value) {
                      if (value.length == 1) {
                        if (index < 4) {
                          FocusScope.of(context).nextFocus();
                        } else {
                          // All OTP digits entered, perform verification
                          // Replace this logic with your own verification process
                          String otp = otpDigits.join();

                          print('Entered OTP: $otp');
                          // TODO: Perform OTP verification here
                        }
                      }
                      setState(() {
                        otpDigits[index] = value;
                      });
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      counterText: '',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        borderSide: BorderSide(
                          color: Colors.black, // Set your desired border color
                          width: 2.0, // Set the desired border width
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: FilledButton.tonal(
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      print('Resending OTP...');
                      // TODO: Resend OTP logic here
                    },
                    child: const Text('Resend OTP'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      _onSubmit(auth.email);
                    },
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Verify OTP",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
