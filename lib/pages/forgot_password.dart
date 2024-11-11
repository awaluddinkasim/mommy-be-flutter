import 'package:flutter/material.dart';
import 'package:mommy_be/shared/dio.dart';
import 'package:mommy_be/shared/widgets/dialog/loading.dart';
import 'package:mommy_be/shared/widgets/input.dart';
import 'package:mommy_be/shared/widgets/page_title.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();

  Future _submit() async {
    final messanger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    try {
      final response = await Request.post('/forgot-password', data: {
        'email': _email.text,
      });

      navigator.pop();
      navigator.pop();

      messanger.showSnackBar(
        SnackBar(
          content: Text(response['message']),
        ),
      );
    } catch (e) {
      navigator.pop();
      messanger.showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const PageTitle(title: "Lupa Password"),
                const SizedBox(height: 32),
                Input(
                  controller: _email,
                  label: "Email",
                  icon: const Icon(Icons.mail_outline),
                  hintText: "Masukkan email Anda",
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const LoadingDialog(),
                    );
                    _submit();
                  },
                  child: const Text("Kirim"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
