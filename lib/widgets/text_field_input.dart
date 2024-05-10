import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textController;
  final bool obscureText;
  final String hintText;
  final TextInputType keyboardType;

  const TextFieldInput({
    Key? key,
    required this.textController,
    this.obscureText = false,
    required this.hintText,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context, width: 1),
    );

    return TextField(
      controller: textController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: EdgeInsets.all(8)
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}


