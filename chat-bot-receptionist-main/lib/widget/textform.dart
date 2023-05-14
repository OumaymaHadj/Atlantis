import 'package:flutter/material.dart';


class TextForm extends StatelessWidget {
  const TextForm({super.key, required this.text, required this.textInputType, required this.obscured, this.onSave, this.validator});

  final String text;
  final TextInputType textInputType;
  final bool obscured;
  final Function(String?)? onSave;
  final Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 3, left: 10),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 7,
          )
        ],
      ),
      child: TextFormField(
        onSaved: onSave,
        keyboardType: textInputType,
        obscureText: obscured,
        decoration: InputDecoration(
          hintText: text,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(0),
          hintStyle: const TextStyle(
            height: 1,
          )
        ),
      ),
    );
  }
}