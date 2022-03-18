import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final GlobalKey<FormFieldState> _fieldKey;
  final TextInputType keyboardType;
  final String? Function(String? value) validator;
  final String labelText;
  final List<TextInputFormatter>? _textInputFormatters;

  const MyTextField({
    Key? key,
    required GlobalKey<FormFieldState> fieldKey,
    this.keyboardType = TextInputType.text,
    required this.validator,
    required this.labelText,
    List<TextInputFormatter>? textInputFormatters,
  })  : _fieldKey = fieldKey,
        _textInputFormatters = textInputFormatters,
        super(key: key);

  void validate(GlobalKey<FormFieldState> key) {
    key.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: Focus(
        child: TextFormField(
          key: _fieldKey,
          decoration: InputDecoration(labelText: labelText),
          keyboardType: keyboardType,
          validator: validator,
          inputFormatters: _textInputFormatters,
        ),
        onFocusChange: (hasFocus) {
          if (!hasFocus) {
            validate(_fieldKey);
          }
        },
      ),
    );
  }
}
