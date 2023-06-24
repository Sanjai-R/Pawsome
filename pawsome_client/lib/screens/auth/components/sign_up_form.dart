import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pawsome_client/widgets/custom_form_field.dart';

import '../../../core/constant/constant.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key, required this.formKey});

  final GlobalKey formKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late String _userName, _email, _password, _phoneNumber;

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
      'hintText': "1234567890",
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
              onSaved: (value) {
                switch (input['label']) {
                  case 'Email':
                    _email = value!;
                    break;
                  case 'Username':
                    _userName = value!;
                    break;
                  case 'Password':
                    _password = value!;
                    break;
                  case 'Mobile':
                    _phoneNumber = value!;
                    break;
                }
              },
            ),
        ],
      ),
    );
  }
}
