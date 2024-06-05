import 'package:flutter/material.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);
  Future<void> launchlink(String link) async {
    try {
      await launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
    } catch (error) {
      // ignore: avoid_print
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final user = Provider.of<AuthNotifier>(context).user!;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.grey),
        centerTitle: true,
        title: const Text(
          "HELP CENTRE",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How can HikersAfrique help you?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to the Help page! Here you can find information on how to use the HikersAfrique application.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              '1. How to book for an Event:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'To book for an event, please follow these steps:\n\n'
              '1. Log in to your account,\n'
              '2. Select an event,\n'
              '3. Book the event,\n'
              '4. Pay for the event by inputting your M-Pesa code,\n'
              '5. Download your ticket',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              '2. How to send Feedback:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
            'Getting to have your feedack is important for us and this is how you can  do it:\n\n'
  '1.Log in to your account,\n'
  '2.You can navigate to the sidemenu on the topleft of the app-screen,\n'
  '3.Select feedback and write or after paying for an event,\n'
  '4.click the finish button and you can chose to provide feedback, \n',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              '3. How to know more about us',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'To know moe about us,please follow these steps:\n\n'
  '1.Log in to your account,\n'
  '2.You can navigate to the sidemenu on the topleft of the app-screen,\n'
  '3. Select the "About Us !!" and read all about this company,\n',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              '4. Get Help:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'If you encounter any issues or have questions, feel free to send us an email',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                launchlink('https://www.hikersafrique.com/more/contact-info');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(150, 40),
              ),
              child: const Text('Contact Support'),
            ),
          ],
        ),
      ),
    );
  }
}
