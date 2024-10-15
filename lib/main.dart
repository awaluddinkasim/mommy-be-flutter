import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mommy_be/cubit/auth_cubit.dart';
import 'package:mommy_be/cubit/bayi_cubit.dart';
import 'package:mommy_be/cubit/laktasi_cubit.dart';
import 'package:mommy_be/cubit/makanan_cubit.dart';
import 'package:mommy_be/cubit/nutrisi_harian_cubit.dart';
import 'package:mommy_be/loading.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => BayiCubit()),
        BlocProvider(create: (context) => LaktasiCubit()),
        BlocProvider(create: (context) => MakananCubit()),
        BlocProvider(create: (context) => NutrisiHarianCubit()),
      ],
      child: MaterialApp(
        title: 'Mommy Be',
        theme: ThemeData(
          colorScheme: ColorScheme.light(primary: Colors.pink.shade300),
          scaffoldBackgroundColor: Colors.pink.shade50,
          useMaterial3: true,
        ),
        home: const LoadingScreen(),
      ),
    );
  }
}
