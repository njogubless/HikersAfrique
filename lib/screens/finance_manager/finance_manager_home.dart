import 'package:flutter/material.dart';
import 'package:hikersafrique/screens/finance_manager/payment_details.dart';
import 'package:hikersafrique/services/auth.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:provider/provider.dart';

class FinanceManagerHome extends StatelessWidget {
  const FinanceManagerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthNotifier>(context).user!;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: FinanceManagerAppBar(),
      ),
      drawer: Drawer(
        child: SafeArea(
            child: Column(
          children: [
            Image.asset(
              'Image/wheat.jpg',
              fit: BoxFit.fitWidth,
              height: 150,
              width: double.infinity,
            ),
            ListTile(
              title: Text(
                user.clientName,
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              onTap: null,
            )
          ],
        )),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              SizedBox(height: 20.0),
              Row(
                children: [
                  Text(
                    'Payments from Clients',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: PaymentDetailsScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FinanceManagerAppBar extends StatelessWidget {
  const FinanceManagerAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6.0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Icon(Icons.sort_rounded, size: 28.0),
              ),
            ),
            const Row(
              children: [
                Icon(
                  Icons.supervised_user_circle_rounded,
                  color: Color(0xFFF65959),
                ),
                Text(
                  'Finance Manager',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                )
              ],
            ),
            DropdownButton<int>(
              icon: const Icon(Icons.more_vert),
              underline: const SizedBox.shrink(),
              items: const [
                DropdownMenuItem(
                  value: 1,
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontFamily: 'AvenirNext',
                    ),
                  ),
                ),
              ],
              onChanged: (selection) {
                auth.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
