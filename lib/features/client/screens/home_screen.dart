import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hikersafrique/features/client/screens/widgets/rating.dart';
import 'package:hikersafrique/screens/home/homepages/sidebar/about.dart';
import 'package:hikersafrique/screens/home/homepages/cart.dart';
import 'package:hikersafrique/features/client/screens/tab%20screens/events_page.dart';
import 'package:hikersafrique/features/client/screens/tab%20screens/favorites.dart';
import 'package:hikersafrique/screens/home/homepages/sidebar/feedbackselection.dart';
import 'package:hikersafrique/screens/home/homepages/sidebar/help.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:hikersafrique/widgets/home_appbar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../screens/home/homepages/sidebar/replies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  Future launchlink(String link) async {
    try {
      await launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
    } catch (error) {
      // ignore: avoid_print
      print(error);
    }
  }

  // Selected item function
  void onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List pages = [
    const EventsPage(),
    const Favorites(),
    const Rating(),
    const Purchased(),
  ];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthNotifier>(context).user!;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: CustomHomeAppBar(),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Image.asset(
                'assets/images/new.jpeg',
                fit: BoxFit.fitWidth,
                height: 150,
                width: double.infinity,
              ),
              ListTile(
                title: Text(
                  user.clientName,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  user.clientEmail,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  user.role,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                  title: const Text(
                    "Contact us",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    launchlink(
                        "https://www.hikersafrique.com/more/contact-info");
                    // ignore: unused_local_variable
                  }),
              ListTile(
                  title: const Text(
                    "Feedback",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const FeedbackRecipientSelection()));
                  }),
              ListTile(
                title: const Text(
                  "Replies",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RepliesPage(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  "Help ",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HelpPage()));
                },
              ),
              ListTile(
                title: const Text(
                  " About Us !!",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutUsPage()));
                },
              ),
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green,
                      Colors.blue,
                      Colors.grey,
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        animationCurve: Curves.bounceOut,
        animationDuration: const Duration(milliseconds: 700),
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        onTap: (i) => onTappedItem(i),
        index: _selectedIndex,
        items: const [
          Icon(
            Icons.home,
            size: 30.0,
          ),
          Icon(
            Icons.bookmark,
            size: 30.0,
          ),
          Icon(
             Icons.rate_review,
             size: 30.0,  
          ),
          Icon(
            Icons.shopping_cart_outlined,
            size: 30.0,
          )
        ],
      ),
      body: pages[_selectedIndex],
    );
  }
}
