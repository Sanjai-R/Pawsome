import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pawsome_client/widgets/custom_form_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key, required this.formKey});
  final GlobalKey formKey ;
  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {

  List inputs = [
    {
      'label': 'Email',
      'hintText': 'test@gmail.com',
      'type': 'email',

    },
    {
      'label': 'Password',
      'hintText': "*****",
      'type': 'password',
    }
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
