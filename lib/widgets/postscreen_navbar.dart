import 'package:flutter/material.dart';
import 'package:hikersafrique/constant.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:hikersafrique/services/database.dart';
import 'package:provider/provider.dart';

class PostScreenNavBar extends StatelessWidget {
  const PostScreenNavBar({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthNotifier>(context).user;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Consumer(builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        event.eventName,
                        style: const TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10.0),
                      const Row(
                        children: [
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
                const SizedBox(height: 50.0),
                Text(
                  'Location: ${event.eventLocation}\nDate: ${event.eventDate}\nTime: ${event.eventTime}\n\nCost: Ksh. ${event.eventCost}',
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 47.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          Database.saveSavedEvent(
                                  user!.clientEmail, event.eventID)
                              .then((_) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              backgroundColor: Colors.greenAccent,
                              content: Text(
                                  'Event saved!\nIt will appear on your home page'),
                            ));
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26, blurRadius: 4.0)
                              ]),
                          child: const Icon(
                            Icons.bookmark_outline,
                            size: 25.0,
                          ),
                        ),
                      ),
                      //Book Now
                      ElevatedButton(
                        onPressed: () async {
                          Database.saveBookedEvent(
                                  user!.clientEmail, event.eventID)
                              .then((_) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              backgroundColor: Colors.greenAccent,
                              content: Text(
                                  'Event booked!\nWe will contact you for further instructions'),
                            ));
                          });
                          Misc.getReceipt(event, user).then((_) =>
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                backgroundColor: Colors.greenAccent,
                                content: Text(
                                    'Find your receipt in your Downloads!'),
                              )));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
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
