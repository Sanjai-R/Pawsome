import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pawsome_client/widgets/custom_form_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key, required this.formKey, required this.inputs});

  final GlobalKey formKey;
  final List inputs;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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
