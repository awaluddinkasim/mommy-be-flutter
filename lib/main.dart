import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mommy_be/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await initializeDateFormatting('id', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mommy Be',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: Colors.pink.shade300),
        scaffoldBackgroundColor: Colors.pink.shade50,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
