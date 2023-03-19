import 'package:flutter/material.dart';
import 'package:hikersafrique/models/client.dart';
import 'package:hikersafrique/screens/authenticate/authenticate.dart';
import 'package:hikersafrique/screens/home/client_admin_redirect.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:hikersafrique/services/database.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Return either Home or Authentication widget

    // Using the data from the Provider
    final userAuth = Provider.of<Client?>(context);

    // Return either Home() or Authenticate()
    if (userAuth == null) {
      return const Authenticate();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Provider.of<AuthNotifier>(context, listen: false).setUser(
          await Database.getClientData(userAuth.clientEmail),
        );
      });
      return const ClientAdminRedirect();
    }
  }
}
