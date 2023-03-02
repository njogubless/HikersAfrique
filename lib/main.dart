import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:hikersafrique/components/city_names.dart';
import 'package:hikersafrique/constants/constants.dart';
import 'package:hikersafrique/screens/welcome_screen.dart';

void main() => runApp(const HikersAfriqueApp());

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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HikersAfrique App',
        theme: ThemeData(
          scaffoldBackgroundColor: kScaffoldBgColor,
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}
