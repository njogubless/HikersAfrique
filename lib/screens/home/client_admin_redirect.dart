import 'package:flutter/material.dart';
import 'package:hikersafrique/models/client.dart';
import 'package:hikersafrique/screens/admin/admin_home.dart';
import 'package:hikersafrique/screens/admin/logistics.dart';
import 'package:hikersafrique/screens/event_manager/event_manager_home.dart';
import 'package:hikersafrique/screens/finance_manager/finance_manager_home.dart';
import 'package:hikersafrique/screens/home/home_screen.dart';
// import 'package:hikersafrique/screens/partners/partners_page.dart';
import 'package:hikersafrique/screens/admin/partners.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:provider/provider.dart';

class ClientAdminRedirect extends StatelessWidget {
  const ClientAdminRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthNotifier>(context).user;
    try {
      String status = user?.status ?? '';
      if (status != 'Verified') {
        return PendingApprovalPage(user: user);
      } else {
        if (user?.role == 'client') {
          return const HomeScreen();
        }
        if (user?.role == 'eventManager') {
          return const EventManagerHome();
        }
        if (user?.role == 'financeManager') {
          return const FinanceManagerHome();
        }
        if (user?.role == 'Partners') {
          return const PartnersPage();
        }
        if (user?.role == 'admin') {
          return const AdminHome();
        }
        if (user?.role =='Logistics'){
          return const LogisticsPage();
        }
        return const HomeScreen();
      }
    } catch (e) {
      return const Scaffold(
        body: Center(),
      );
    }
  }
}

class PendingApprovalPage extends StatelessWidget {
  const PendingApprovalPage({
    super.key,
    required this.user,
  });

  final Client? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pending approval',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Hey, ${user?.clientName}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Your registration has not been approved yet! Please check back soon.',
                overflow: TextOverflow.visible,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          )),
    );
  }
}
