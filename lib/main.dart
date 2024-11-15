import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mommy_be/cubit/auth_cubit.dart';
import 'package:mommy_be/cubit/bayi_cubit.dart';
import 'package:mommy_be/cubit/laktasi_cubit.dart';
import 'package:mommy_be/cubit/laktasi_grafik_cubit.dart';
import 'package:mommy_be/cubit/makanan_cubit.dart';
import 'package:mommy_be/cubit/monitor_ekskresi_cubit.dart';
import 'package:mommy_be/cubit/monitor_tidur_cubit.dart';
import 'package:mommy_be/cubit/nutrisi_harian_cubit.dart';
import 'package:mommy_be/cubit/obstetri_cubit.dart';
import 'package:mommy_be/cubit/pertumbuhan_cubit.dart';
import 'package:mommy_be/cubit/screening_ppd_cubit.dart';
import 'package:mommy_be/cubit/status_gizi_cubit.dart';
import 'package:mommy_be/loading.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await initializeDateFormatting('id', null);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    OneSignal.initialize(dotenv.env['ONESIGNAL_APP_ID']!);

    OneSignal.Notifications.requestPermission(true);

    OneSignal.Notifications.clearAll();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => BayiCubit()),
        BlocProvider(create: (context) => MonitorTidurCubit()),
        BlocProvider(create: (context) => MonitorEkskresiCubit()),
        BlocProvider(create: (context) => PertumbuhanCubit()),
        BlocProvider(create: (context) => LaktasiCubit()),
        BlocProvider(create: (context) => LaktasiGrafikCubit()),
        BlocProvider(create: (context) => MakananCubit()),
        BlocProvider(create: (context) => NutrisiHarianCubit()),
        BlocProvider(create: (context) => ObstetriCubit()),
        BlocProvider(create: (context) => StatusGiziCubit()),
        BlocProvider(create: (context) => ScreeningPPDCubit()),
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
