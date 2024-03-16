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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            ),
            const SizedBox(height: 20.0),
            CustomServiceCard(
              color: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            ),
            const SizedBox(height: 20.0),
            const CustomMessageBox(
              color: Colors.blue,
            ),
            const SizedBox(height: 20.0),
            const CustomCircularCard(
              color: Colors.grey,
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

  const CustomServiceCard({
    Key? key,
    required this.color,
    required this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: shape,
      color: color,
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Vision',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15.0),
            Text(
              'To be a world class adventure travel designer and facilitator'
              'setting the global standard for curating extraordinary travel experiences that delve into the rich tapestry of African history,'
              ' diverse landscapes, and cultural treasures..',
              style: TextStyle(fontSize: 16.0),
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
            'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

class CustomCircularCard extends StatelessWidget {
  final Color color;

  const CustomCircularCard({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(150.0),
      ),
      child: const ListTile(
        title: Text(
          'Background',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
