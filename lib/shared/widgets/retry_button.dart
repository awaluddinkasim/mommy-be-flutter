import 'package:flutter/material.dart';

class RetryButton extends StatelessWidget {
  const RetryButton({
    super.key,
    required this.onPressed,
    required this.message,
  });

  final String message;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Error loading data"),
          FilledButton.icon(
            onPressed: onPressed,
            label: const Text("Retry"),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
