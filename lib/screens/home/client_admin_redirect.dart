import 'package:flutter/material.dart';
import 'package:hikersafrique/screens/home/home_screen.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:provider/provider.dart';

class ClientAdminRedirect extends StatelessWidget {
  const ClientAdminRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthNotifier>(context).user;
    try {
      if (user!.role == 'client') {
        return const HomeScreen();
      } else {
        return const Scaffold(
          body: Center(child: Text('Admin')),
        );
      }
    } catch (e) {
      return const Scaffold(
        body: Center(),
      );
    }
  }
}
