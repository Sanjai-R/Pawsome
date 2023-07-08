import 'package:flutter/material.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/core/utils/validator.dart';

class MyCustomInput extends StatelessWidget {
  final String label;
  final String hintText;
  final String type;
  final void Function(String?)? onSaved;
  final TextEditingController controller;
  final String? Function(String?)? onChange;

  const MyCustomInput({
    Key? key,
    required this.label,
    required this.hintText,
    required this.type,
    required this.onSaved,
    required this.controller,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextInputType getKeyboardType() {
      switch (type) {
        case 'email':
          return TextInputType.emailAddress;
        case 'number':
          return TextInputType.number;
        default:
          return TextInputType.text;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldName(text: label),
          TextFormField(
            onSaved: onSaved,
            controller: controller,
            keyboardType: getKeyboardType(),
            obscureText: type == 'password',
            obscuringCharacter: '*',
            onChanged: onChange,
            decoration: InputDecoration(
              contentPadding: defaultInputPadding,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey[200],
              hintStyle: TextStyle(color: Colors.grey[600]),
              filled: true,
              hintText: hintText,
            ),
            validator: getValidator(type, label),
          ),
        ],
      ),
    );
  }
}

class TextFieldName extends StatelessWidget {
  const TextFieldName({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding / 3),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}
