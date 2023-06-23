import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pawsome_client/widgets/custom_form_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key, required this.formKey});
  final GlobalKey formKey ;
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  List inputs = [
    {
      'label': 'Email',
      'hintText': 'test@gmail.com',
      'type': 'email',
    },
    {
      'label': 'Username',
      'hintText': 'test_user',
      'type': 'text',
    },
    {
      'label': 'Password',
      'hintText': "*****",
      'type': 'password',
    },
    {
      'label': 'Mobile',
      'hintText': "+91-1234567890",
      'type': 'number',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          for (var input in inputs)
            MyCustomInput(
              label: input['label'],
              hintText: input['hintText'],
              type: input['type'],
            ),
        ],
      ),
    );
  }
}
