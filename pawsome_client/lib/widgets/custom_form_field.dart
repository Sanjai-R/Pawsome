import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pawsome_client/core/constant/constant.dart';

class MyCustomInput extends StatelessWidget {
  final String label;
  final String hintText;
  final String type;

  const MyCustomInput(
      {super.key,
      required this.label,
      required this.hintText,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldName(text: label),
          TextFormField(
            // obscureText: true,
            keyboardType: type == 'email'
                ? TextInputType.emailAddress
                : type == 'number'
                    ? TextInputType.number
                    : TextInputType.text,
            obscureText: type == 'password' ? true : false,
            obscuringCharacter: '*',
            decoration: InputDecoration(
                contentPadding: defaultInputPadding,
                border: InputBorder.none,
                fillColor: Colors.grey[200],
                hintStyle: TextStyle(color: Colors.grey[600]),
                filled: true,
                hintText: hintText),
            validator: (pass) =>
                MatchValidator(errorText: "Password do not  match")
                    .validateMatch(pass!, ""),
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
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
      ),
    );
  }
}
