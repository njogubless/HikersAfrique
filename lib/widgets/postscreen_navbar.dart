import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostScreenNavBar extends StatelessWidget {
  const PostScreenNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      padding: const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Consumer(builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Milan,Italy',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: const [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Text(
                            '4.5',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 10.0),
                const Text(
                  'Milan, Italian Milano, city, capital of Milano province (provincia) and of the region (regione) of Lombardy (Lombardia), northern Italy. It is the leading financial centre and the most prosperous manufacturing and commercial city of Italy',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            'images/city3.jpg',
                            fit: BoxFit.cover,
                            height: 90.0,
                            width: 120.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            'images/city2.jpg',
                            fit: BoxFit.cover,
                            height: 90.0,
                            width: 120.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            'images/city4.jpg',
                            fit: BoxFit.cover,
                            height: 90.0,
                            width: 100.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 47.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(color: Colors.black26, blurRadius: 4.0)
                            ]),
                        child: const Icon(
                          Icons.bookmark_outline,
                          size: 25.0,
                        ),
                      ),
                      //Book Now
                      Container(
                        // margin: const EdgeInsets.only(bottom: 10.0),
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: const [
                            BoxShadow(color: Colors.white, blurRadius: 4.0)
                          ],
                        ),
                        child: const Text(
                          'Book Now',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
