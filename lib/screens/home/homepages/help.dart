import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:provider/provider.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthNotifier>(context).user!; 
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.grey ),
          centerTitle: true,
          title: const Text(
            "HELP PAGE",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height:40),
              const Text('How can HikersAfrique be of Help ?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
              const SizedBox(
                height: 20),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal:20 ,vertical: 20),
                child: TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: 'please input your need here !',
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                      Radius.circular(10),
                        )
                    )
                  ),
                  maxLines: 7,
                  maxLength: 4096,
                  textInputAction: TextInputAction.done,
                  validator: (String? text){
                    if (text == null || text.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  }
                  )
                  ),
                  isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Colors.black,
                    ))
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        // Only if the input form is valid (the user has entered text)
                        if (_formKey.currentState!.validate()) {
                          // We will use this var to show the result
                          // of this operation to the user
                          String message;

                          try {
                            // Get a reference to the `feedback` collection
                            final collection = FirebaseFirestore.instance
                                .collection('Help');

                            // Write the server's timestamp and the user's feedback
                            await collection.doc().set({
                              'timestamp': FieldValue.serverTimestamp(),
                              'message': _controller.text,
                              'name': user.clientName,
                              'role': user.role,
                            });

                            message = 'Help message sent successfully';
                          } catch (e) {
                            message = 'Error when sending feedback';
                          }

                          // Show a snackbar with the result
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(message)));
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(150, 40)),
                      child: const Text('Send'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
