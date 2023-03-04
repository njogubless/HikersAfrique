// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RegisterClient extends StatefulWidget {
  const RegisterClient({
    Key? key,
    required this.toggleView,
  }) : super(key: key);
  final Function toggleView;
  @override
  State<RegisterClient> createState() => _RegisterClientState();
}

class _RegisterClientState extends State<RegisterClient> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
