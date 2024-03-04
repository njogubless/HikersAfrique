import 'package:flutter/material.dart';
import 'package:hikersafrique/screens/admin/event_management.dart';
import 'package:hikersafrique/screens/admin/finance_management.dart';
import 'package:hikersafrique/screens/admin/partners.dart';
//import 'package:hikersafrique/screens/partners/partners_page.dart';
import 'package:hikersafrique/screens/admin/user_management.dart';
import 'package:hikersafrique/widgets/admin_bottombar.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    final pageNotifier = ValueNotifier<int>(0);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AdminAppBar(),
      ),
      bottomNavigationBar: AdminBottomNavBar(
        pageNotifier: pageNotifier,
      ),
      body: ValueListenableBuilder<int>(
          valueListenable: pageNotifier,
          builder: (context, page, _) {
            switch (page) {
              case 0:
                return const FinanceManagement();
              case 1:
                return const EventManagement();
              case 2:
                return const PartnersPage();
              default:
                return const UserManagement();
            }
          }),
    );
  }
}
