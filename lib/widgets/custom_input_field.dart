import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final bool? enabled;

  final String formProperty;
  final Map<String, String> formValues;

  const CustomInputField({
    Key? key,
    this.hintText,
    this.labelText,
    this.helperText,
    this.icon,
    this.keyboardType,
    this.obscureText,
    this.enabled,
    required this.formProperty,
    required this.formValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      initialValue: '',
      enabled: enabled,
      textCapitalization: TextCapitalization.words,
      keyboardType: keyboardType == null ? null : TextInputType.emailAddress,
      obscureText: obscureText == null ? false : true,
      onChanged: (value) => formValues[formProperty] = value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        icon: icon == null ? null : Icon(icon),
      ),
    );
  }
}
