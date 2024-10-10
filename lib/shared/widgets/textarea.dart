import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextArea extends StatelessWidget {
  const TextArea({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.inputFormatters,
    this.helperText,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 5,
  });

  final String label;
  final String hintText;
  final Icon icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Text? helperText;
  final Function()? onTap;
  final bool readOnly;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          readOnly: readOnly,
          onTap: onTap,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: textCapitalization,
          keyboardType: keyboardType,
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            filled: true,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.lightBlue,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.lightBlue,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.lightBlue.shade100.withOpacity(0.5),
                width: 1,
              ),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Align(
                alignment: Alignment.topLeft,
                widthFactor: 1,
                heightFactor: maxLines.toDouble(),
                child: icon,
              ),
            ),
          ),
          maxLines: maxLines,
        ),
        if (helperText != null) helperText!,
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
