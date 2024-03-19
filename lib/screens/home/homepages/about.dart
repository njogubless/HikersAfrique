import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomServiceCard(
              color: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              title: 'Our Vision',
              content:
                  'To be a world class adventure travel designer and facilitator'
                  'setting the global standard for curating extraordinary travel experiences that delve into the rich tapestry of African history,'
                  ' diverse landscapes, and cultural treasures..',
            ),
            const SizedBox(height: 20.0),
            CustomServiceCard(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              title: 'Our Mission',
              content:
                  'To curate transformative travel experiences and create memories that last, moments that inspire, and adventures that push you to endure, think, act, and explore deeply. We seek to push boundaries, encouraging travelers to embrace the spirit of discovery, forging a legacy of not just vacations, but transformative odysseys that leave an indelible mark on the soul.',
            ),
            const SizedBox(height: 20.0),
            const CustomMessageBox(
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomServiceCard extends StatelessWidget {
  final Color color;
  final ShapeBorder shape;
  final String title;
  final String content;

  const CustomServiceCard({
    Key? key,
    required this.color,
    required this.shape,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: shape,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15.0),
            Text(
              content,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomMessageBox extends StatelessWidget {
  final Color color;

  const CustomMessageBox({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.blue, width: 2.0),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our Values',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            '"Step into the wilderness, where mountains whisper tales,'
            'In Hiker'
            's'
            'Haven, we craft adventures, each trail unveils.'
            'Nature'
            's'
            'canvas unfolds, as we trek through sun and shade,'
            'Discovering hidden gems, where memories are made.'
            'Join us, embrace the wild, let your spirit roam free.',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
