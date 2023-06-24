import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pawsome_client/widgets/custom_form_field.dart';

import '../../../core/constant/constant.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key, required this.formKey, required this.inputs});

  final GlobalKey formKey;
  final List inputs;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late String _userName, _email, _password, _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          for (var input in widget.inputs)
            MyCustomInput(
              label: input['label'],
              hintText: input['hintText'],
              type: input['type'],
              controller: input['controller'],
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
