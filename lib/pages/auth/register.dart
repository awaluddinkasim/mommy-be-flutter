import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mommy_be/data/register.dart';
import 'package:mommy_be/shared/constants.dart';
import 'package:mommy_be/shared/dio.dart';
import 'package:mommy_be/shared/widgets/dialog/loading.dart';
import 'package:mommy_be/shared/widgets/input.dart';
import 'package:mommy_be/shared/widgets/page_title.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nama = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _konfirmasiPassword = TextEditingController();
  final _tanggalLahir = TextEditingController();
  final _nomorHp = TextEditingController();

  bool _showPassword = false;
  bool _showPasswordConfirmation = false;

  bool _privacyPolicy = false;

  late DateTime _dob;

  Future<void> _submit() async {
    final navigator = Navigator.of(context);
    final messanger = ScaffoldMessenger.of(context);
    final token = await Constants.storage.read(key: 'token');

    try {
      await Request.post(
        '/register',
        data: DataRegister(
          nama: _nama.text,
          email: _email.text,
          password: _password.text,
          tanggalLahir: _dob,
          nomorHp: _nomorHp.text,
        ).toJson(),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      navigator.pop();
      navigator.pop();
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
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const PageTitle(
                  title: "Daftar Akun",
                ),
                const SizedBox(height: 24),
                Input(
                  controller: _nama,
                  label: "Nama",
                  icon: const Icon(Icons.person),
                  hintText: "Masukkan nama lengkap",
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nama tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                Input(
                  controller: _email,
                  label: "Email",
                  icon: const Icon(Icons.mail),
                  hintText: "Masukkan email",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                Input(
                  controller: _password,
                  label: "Password",
                  icon: const Icon(Icons.lock),
                  hintText: "Masukkan password",
                  obscureText: !_showPassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password tidak boleh kosong";
                    }
                    if (value.length < 8) {
                      return "Password minimal 8 karakter";
                    }
                    return null;
                  },
                ),
                Input(
                  controller: _konfirmasiPassword,
                  label: "Konfirmasi Password",
                  icon: const Icon(Icons.lock),
                  hintText: "Masukkan ulang password",
                  obscureText: !_showPasswordConfirmation,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _showPasswordConfirmation = !_showPasswordConfirmation;
                      });
                    },
                    icon: Icon(_showPasswordConfirmation ? Icons.visibility_off : Icons.visibility),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Konfirmasi password tidak boleh kosong";
                    }
                    if (value != _password.text) {
                      return "Konfirmasi password tidak sama";
                    }
                    return null;
                  },
                ),
                Input(
                  controller: _tanggalLahir,
                  label: "Tanggal Lahir",
                  readOnly: true,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime(DateTime.now().year - 15),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(DateTime.now().year - 15),
                    );
                    if (date != null) {
                      setState(() {
                        _dob = date;
                        _tanggalLahir.text = DateFormat(
                          'dd MMMM yyyy',
                          'ID',
                        ).format(date);
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  hintText: "Pilih tanggal lahir",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Tanggal lahir tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                Input(
                  controller: _nomorHp,
                  label: "Nomor HP",
                  icon: const Icon(Icons.smartphone),
                  hintText: "Masukkan nomor HP",
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nomor HP tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: const EdgeInsets.all(0),
                  title: Row(
                    children: [
                      const Text("Saya menyetujui "),
                      GestureDetector(
                        onTap: () async {
                          await launchUrl(Uri.parse("${Constants.baseUrl}/privacy-policy"), mode: LaunchMode.externalApplication);
                        },
                        child: const Text(
                          "Kebijakan Privasi",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  value: _privacyPolicy,
                  onChanged: (value) {
                    setState(() {
                      _privacyPolicy = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _privacyPolicy
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) => const LoadingDialog(),
                            );
                            _submit();
                          }
                        }
                      : null,
                  child: const Text("Daftar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
