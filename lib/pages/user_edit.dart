import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mommy_be/cubit/auth_cubit.dart';
import 'package:mommy_be/data/user.dart';
import 'package:mommy_be/models/user.dart';
import 'package:mommy_be/shared/constants.dart';
import 'package:mommy_be/shared/dio.dart';
import 'package:mommy_be/shared/widgets/dialog/loading.dart';
import 'package:mommy_be/shared/widgets/input.dart';
import 'package:mommy_be/shared/widgets/page_title.dart';

class UserEditScreen extends StatefulWidget {
  final User user;

  const UserEditScreen({super.key, required this.user});

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nama = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _tanggalLahir = TextEditingController();
  final _nomorHp = TextEditingController();

  late DateTime _dob;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _nama.text = widget.user.nama;
      _email.text = widget.user.email;
      _tanggalLahir.text = DateFormat('dd MMM yyyy', 'ID').format(widget.user.tanggalLahir);
      _nomorHp.text = widget.user.nomorHp;
      _dob = widget.user.tanggalLahir;
    });
  }

  Future<void> _submit() async {
    final navigator = Navigator.of(context);
    final messanger = ScaffoldMessenger.of(context);

    final authCubit = context.read<AuthCubit>();
    final token = await Constants.storage.read(key: 'token');

    try {
      final response = await Request.put(
        '/user',
        data: DataUser(
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

      authCubit.updateUser(User.fromJson(response['data']['user']));

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
                  title: "Edit Akun",
                ),
                const SizedBox(height: 24),
                Input(
                  controller: _nama,
                  label: "Nama",
                  icon: const Icon(Icons.person),
                  hintText: "Masukkan nama lengkap",
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
                  label: "Ganti Password",
                  icon: const Icon(Icons.lock),
                  hintText: "Masukkan password baru",
                  obscureText: true,
                  validator: (value) {
                    if (value != null && value.length < 8 && value.isNotEmpty) {
                      return "Password minimal 8 karakter";
                    }
                    return null;
                  },
                  helperText: "Kosongkan jika tidak ingin mengganti password",
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
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) => const LoadingDialog(),
                      );
                      _submit();
                    }
                  },
                  child: const Text("Simpan"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
