import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.maxlines,
    required this.controller,
    required this.hintText,
    this.validator,
    required this.text,
  });

  final int? maxlines;
  final TextEditingController controller;
  final String? hintText;
  final Function(String?)? validator;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text, style: Theme.of(context).textTheme.titleMedium),
        ),
        TextFormField(
          maxLines: maxlines,
          controller: controller,
          validator: validator != null
              ? (String? value) => validator!(value)
              : null,
          decoration: InputDecoration(hintText: hintText),
        ),
      ],
    );
  }
}
