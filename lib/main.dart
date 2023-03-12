import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hikersafrique/firebase_options.dart';
import 'package:hikersafrique/models/client.dart';
import 'package:hikersafrique/screens/home/wrapper.dart';
import 'package:hikersafrique/services/auth.dart';
import 'package:provider/provider.dart';

import 'package:hikersafrique/components/city_names.dart';
import 'package:hikersafrique/constants/constants.dart';
import 'package:hikersafrique/screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const HikersAfriqueApp());
}

class HikersAfriqueApp extends StatefulWidget {
  const HikersAfriqueApp({super.key});

  @override
  State<HikersAfriqueApp> createState() => _HikersAfriqueAppState();
}

class _HikersAfriqueAppState extends State<HikersAfriqueApp> {
  // Display config
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CityNames(),
      child: StreamProvider<Client?>.value(
        initialData: null,
        value: AuthService().user,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'HikersAfrique App',
          theme: ThemeData(
            scaffoldBackgroundColor: kScaffoldBgColor,
          ),
          routes: {
            '/': (context) => const Wrapper(),
            '/welcome': (context) => const WelcomeScreen(),
          },
        ),
      ),
    );
  }
}
