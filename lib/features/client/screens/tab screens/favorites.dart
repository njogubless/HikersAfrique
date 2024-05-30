import 'package:flutter/material.dart';
import 'package:hikersafrique/features/client/screens/widgets/saved_events.dart';
import 'package:provider/provider.dart';

import '../../../../models/event.dart';
import '../../../../services/auth_notifier.dart';
import '../../../../services/database.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder<List<Event>>(
                  future: Database.getSavedEvents(
                      Provider.of<AuthNotifier>(context).user!.clientEmail),
                  initialData: const [],
                  builder: (context, snapshot) {
                    return ListView.builder(
                      padding: const EdgeInsets.only(right: 20),
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: SavedEvent(
                            event: snapshot.data![index],
                          ),
                        );
                      },
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
