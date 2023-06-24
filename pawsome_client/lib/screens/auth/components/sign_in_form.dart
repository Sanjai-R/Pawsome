import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/widgets/custom_form_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key, required this.formKey, required this.inputs});

  final GlobalKey formKey;
  final List inputs;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
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
              onSaved: (value) {},

            ),
        ],
      ),
    );
  }
}
