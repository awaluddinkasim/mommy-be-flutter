import 'package:flutter/material.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({
    super.key,
    required String status,
    required String message,
    required void Function() onOkPressed,
    List<TextButton> actions = const [],
  })  : _status = status,
        _message = message,
        _onOkPressed = onOkPressed,
        _actions = actions;

  final String _status;
  final String _message;
  final void Function() _onOkPressed;
  final List<TextButton> _actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_status),
      content: Text(_message),
      actions: [
        ..._actions,
        TextButton(
          onPressed: _onOkPressed,
          child: const Text('OK'),
        ),
      ],
    );
  }
}
