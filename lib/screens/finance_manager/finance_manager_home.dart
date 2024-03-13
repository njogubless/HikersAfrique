import 'package:flutter/material.dart';
import 'package:hikersafrique/screens/finance_manager/payment_model.dart';
import 'package:hikersafrique/screens/home/homepages/feedback.dart';
import 'package:hikersafrique/services/auth.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:hikersafrique/services/database.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  "Contact us",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  launchlink("https://www.hikersafrique.com/");
                },
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
                          builder: (context) => const FeedbackDialog()));
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
      body: const Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
            Expanded(
              child: PaymentDetailsScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Future launchlink(String link) async {
    try {
      await launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
    } catch (error) {
      print(error);
    }
  }
}

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({Key? key}) : super(key: key);

  @override
  _PaymentDetailsScreenState createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  late List<Payment> _pendingPayments;
  late List<Payment> _approvedPayments;
  late List<Payment> _rejectedPayments;

  @override
  void initState() {
    super.initState();
    _pendingPayments = [];
    _approvedPayments = [];
    _rejectedPayments = [];
    _loadPayments();
  }

  Future<void> _loadPayments() async {
    try {
      List<Payment> payments = await Database.getrecordPayments();
      setState(() {
        _pendingPayments =
            payments.where((payment) => payment.status == 'Pending').toList();
        _approvedPayments =
            payments.where((payment) => payment.status == 'Approved').toList();
        _rejectedPayments =
            payments.where((payment) => payment.status == 'Rejected').toList();
      });
    } catch (e) {
      print('Error fetching payments: $e');
    }
  }

  void _approvePayment(Payment payment) {
    setState(() {
      _pendingPayments.remove(payment);
      _approvedPayments.add(payment);
    });
    Database.updatePaymentStatus(payment.docId ?? '', 'Approved');
  }

  void _rejectPayment(Payment payment) {
    setState(() {
      _pendingPayments.remove(payment);
      _rejectedPayments.add(payment);
    });
    Database.updatePaymentStatus(payment.docId ?? '', 'Rejected');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Payment Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildPaymentCard(
            title: 'Approved Payments',
            payments: _approvedPayments,
            isEmpty: _approvedPayments.isEmpty,
            actionButtonLabel: 'Approved',
          ),
          const SizedBox(height: 20),
          _buildPaymentCard(
            title: 'Pending Payments',
            payments: _pendingPayments,
            isEmpty: _pendingPayments.isEmpty,
            actionButtonLabel: 'Approve',
            onActionButtonPressed: _approvePayment,
            showRejectButton: true,
            onRejectButtonPressed: _rejectPayment,
          ),
          const SizedBox(height: 20),
          _buildPaymentCard(
            title: 'Rejected Payments',
            payments: _rejectedPayments,
            isEmpty: _rejectedPayments.isEmpty,
            actionButtonLabel: 'Reject',
            onActionButtonPressed: _approvePayment,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard({
    required String title,
    required List<Payment> payments,
    required bool isEmpty,
    String actionButtonLabel = '',
    void Function(Payment)? onActionButtonPressed,
    bool showRejectButton = false,
    void Function(Payment)? onRejectButtonPressed,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            if (isEmpty)
              const Text(
                'No payments available.',
                textAlign: TextAlign.justify,
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: payments.map((payment) {
                  return ListTile(
                    title: Text(payment.clientName),
                    subtitle: Text('Amount: ${payment.totalCost}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (actionButtonLabel.isNotEmpty)
                          ElevatedButton(
                            onPressed: () {
                              onActionButtonPressed?.call(payment);
                            },
                            child: Text(actionButtonLabel),
                          ),
                        if (showRejectButton) const SizedBox(width: 8),
                        if (showRejectButton)
                          ElevatedButton(
                            onPressed: () {
                              onRejectButtonPressed?.call(payment);
                            },
                            child: const Text('Reject'),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
          ],
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
