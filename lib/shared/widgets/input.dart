import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  const Input({
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
    this.onChanged,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.readOnly = false,
    this.suffixIcon,
  });

  final String label;
  final String hintText;
  final Icon icon;
  final AutovalidateMode? autovalidateMode;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String? helperText;
  final Function()? onTap;
  final Function(String)? onChanged;
  final bool readOnly;
  final Widget? suffixIcon;

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
          onChanged: onChanged,
          autovalidateMode: autovalidateMode,
          textCapitalization: textCapitalization,
          keyboardType: keyboardType,
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            filled: true,
            prefixIcon: icon,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.lightBlue,
              ),
            ),
            suffixIcon: suffixIcon,
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
          ),
        ),
        if (helperText != null)
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "* ",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
                TextSpan(
                  text: helperText,
                ),
              ],
            ),
          ),
        const SizedBox(height: 20),
      ],
    );
  }
}
