import 'package:flutter/material.dart';

class Select extends StatelessWidget {
  const Select({
    super.key,
    this.label,
    required this.icon,
    required this.items,
    required this.onChanged,
    this.value,
    this.hint,
    this.validator,
  });

  final dynamic value;
  final String? label;
  final String? hint;
  final Icon icon;
  final List<DropdownMenuItem> items;
  final Function(dynamic) onChanged;
  final String? Function(dynamic)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null)
          Text(
            label!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        DropdownButtonFormField(
          value: value,
          items: items,
          isExpanded: true,
          hint: hint == null ? null : Text(hint!),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            prefixIcon: icon,
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
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
