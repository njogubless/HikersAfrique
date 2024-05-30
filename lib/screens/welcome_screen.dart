import 'package:flutter/material.dart';
import 'package:hikersafrique/features/client/screens/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'images/bg.jpg',
            ),
            fit: BoxFit.cover,
            opacity: 1.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 45.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Explore Text
                Text(
                  'Explore',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                ),

                const SizedBox(
                  height: 2.0,
                ),
                // the World! text
                const Text(
                  'the World!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                // Description text
                Text(
                  'To travel abroad is one of the most beneficial experiences for a person. People who travel abroad have the opportunity to learn about foreign nations and take in the allure and culture of a new land.',
                  style: TextStyle(
                      color: Colors.black12.withOpacity(0.9),
                      fontSize: 16.0,
                      letterSpacing: 1.2),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                // Navigate to HomePage Inkwell
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  },
                  child: Ink(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 20.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
