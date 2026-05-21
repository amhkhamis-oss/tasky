import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final Function(bool? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (bool? value) => onChanged(value),
      activeColor: Color(0xFF15B86C),
      checkColor: Colors.white, // The checkmark itself stays white

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: BorderSide(color: Color(0xFF6E6E6E), width: 2),
    );
  }
}
