import 'package:form_field_validator/form_field_validator.dart';

String? Function(String?)? getValidator(type,label) {
  switch (type) {
    case 'email':
      return MultiValidator([
        RequiredValidator(errorText: 'Email is required'),
        EmailValidator(errorText: 'Enter a valid email address'),
      ]);
    case 'password':
      return MultiValidator([
        RequiredValidator(errorText: 'Password is required'),
        MinLengthValidator(3,
            errorText: 'Password must be at least 6 digits long'),
      ]);
    case 'number':
      return MultiValidator([
        RequiredValidator(errorText: 'Mobile number is required'),
        MinLengthValidator(10,
            errorText: 'Mobile number must be at least 10 digits long'),
        MaxLengthValidator(10,
            errorText: 'Mobile number must be at most 10 digits long'),
      ]);
    default:
      return RequiredValidator(errorText: '$label is required');
  }
}
