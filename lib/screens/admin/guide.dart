import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hikersafrique/screens/home/homepages/sidebar/feedback_list.dart';
import 'package:hikersafrique/services/auth.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:hikersafrique/models/client.dart';
import 'package:provider/provider.dart';

class GuidesPage extends StatefulWidget {
  const GuidesPage({Key? key}) : super(key: key);

  @override
  _GuidesPageState createState() => _GuidesPageState();
}

class _GuidesPageState extends State<GuidesPage> {
  Future<Client> getClientData(String email) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('clients')
        .where('clientEmail', isEqualTo: email)
        .get();
    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    return docs
        .map((doc) => Client.fromJson(doc.data() as Map<String, dynamic>))
        .toList()
        .first;
  }

  Future<void> updateAllocationStatus(
      String docId, bool approve, bool reject) async {
    try {
      // Update the allocation document with the new status
      await FirebaseFirestore.instance.collection('allocations').doc(docId).update({
        'guideApproved': approve,
        'guideRejected': reject,
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(approve ? 'Event approved successfully' : 'Event rejected successfully'),
        ),
      );
      setState(() {});
    } catch (e) {
      debugPrint('Error updating allocation status: $e');
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating status: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthNotifier>(context).user!;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: GuidesPageAppBar(),
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
                    fontSize: 30,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
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
                      builder: (context) => const FeedbackListScreen(),
                    ),
                  );
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
      body: StreamBuilder(
        stream: firestore
            .collection('allocations')
            .where('guide', isEqualTo: user.clientName)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return FutureBuilder<Client>(
            future: getClientData(user.clientEmail),
            builder: (context, clientSnapshot) {
              if (clientSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final client = clientSnapshot.data!;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('UID')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Role')),
                    DataColumn(label: Text('Event')),
                    DataColumn(label: Text('Guide Approved')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    bool isApproved = data['guideApproved'] ?? false;
                    bool isRejected = data['guideRejected'] ?? false;

                    return DataRow(
                      cells: [
                        DataCell(Text(client.uid)),
                        DataCell(Text(client.clientName)),
                        DataCell(Text(client.clientEmail)),
                        DataCell(Text(client.role)),
                        DataCell(Text(data['event'] ?? '')),
                        DataCell(Text(isApproved ? 'Approved' : 'Not Approved')),
                        DataCell(
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: isApproved || isRejected
                                    ? null
                                    : () {
                                        setState(() {
                                          // Update the state locally
                                          data['guideApproved'] = true;
                                          data['guideRejected'] = false;
                                        });
                                        // Update the allocation status in Firestore
                                        updateAllocationStatus(document.id, true, false);
                                      },
                                child: Text(isApproved ? 'Approved' : 'Approve'),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: isApproved || isRejected
                                    ? null
                                    : () {
                                        setState(() {
                                          // Update the state locally
                                          data['guideApproved'] = false;
                                          data['guideRejected'] = true;
                                        });
                                        // Update the allocation status in Firestore
                                        updateAllocationStatus(document.id, false, true);
                                      },
                                child: Text(isRejected ? 'Rejected' : 'Reject'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class GuidesPageAppBar extends StatelessWidget {
  const GuidesPageAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Sort
            InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
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
            // Location and City
            const Row(
              children: [
                // Location on icon
                Icon(
                  Icons.supervised_user_circle_rounded,
                  color: Color(0xFFF65959),
                ),
                // City Text
                Text(
                  'Guides Page',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                )
              ],
            ),
            // Search icon
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
