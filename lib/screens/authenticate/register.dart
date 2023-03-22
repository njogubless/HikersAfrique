// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hikersafrique/constant.dart';
import 'package:hikersafrique/models/client.dart';
import 'package:hikersafrique/services/auth.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:provider/provider.dart';

enum Role {
  client,
  eventManager,
  financeManager,
  guide,
}

class RegisterClient extends StatefulWidget {
  // Accepting the toggle view function
  final Function toggleView;
  const RegisterClient({super.key, required this.toggleView});

  @override
  State<RegisterClient> createState() => _RegisterClientState();
}

class _RegisterClientState extends State<RegisterClient> {
  // Instance of AuthService which accesses methods to
  // register and sign in with email and pass: used in an on pressed event
  final AuthService _auth = AuthService();
  // Form key for input validation
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  // Form fields, taking note of their states
  String name = '';
  String email = '';
  String password = '';
  String role = 'client';

  // Upon an attempt to register
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: white,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: white,
              elevation: 0.0,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                      child: const Text('Do',
                          style: TextStyle(
                              fontSize: 80.0, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(16.0, 70.0, 0.0, 0.0),
                      child: const Text('Sign Up',
                          style: TextStyle(
                              fontSize: 80.0, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(265.0, 70.0, 0.0, 0.0),
                      child: const Text('.',
                          style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: lightBlue,
                          )),
                    )
                  ],
                ),
                Container(
                    padding: const EdgeInsets.only(
                        top: 5.0, left: 20.0, right: 20.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'YOUR NAME',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: darkGrey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: lightBlue))),
                            validator: (val) => val!.trim().isEmpty
                                ? 'Enter a name consisting of 1+ characters'
                                : null,
                            onChanged: (val) {
                              setState(() {
                                name = val.trim();
                              });
                            },
                          ),
                          const SizedBox(height: 20.0),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'EMAIL',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: darkGrey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: lightBlue))),
                            validator: (val) =>
                                EmailValidator.validate(val!.trim())
                                    ? null
                                    : 'Enter a valid email address',
                            onChanged: (val) {
                              setState(() {
                                email = val.trim();
                              });
                            },
                          ),
                          const SizedBox(height: 20.0),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'PASSWORD',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: darkGrey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: lightBlue))),
                            validator: (val) => val!.trim().length < 6
                                ? 'Password less than 6 characters long'
                                : null,
                            onChanged: (val) {
                              setState(() {
                                password = val.trim();
                              });
                            },
                            obscureText: true,
                          ),
                          const SizedBox(height: 20.0),
                          DropdownButtonFormField<Role>(
                            hint: const Text('Select role'),
                            items: const [
                              DropdownMenuItem(
                                value: Role.client,
                                child: Text('Client'),
                              ),
                              DropdownMenuItem(
                                value: Role.eventManager,
                                child: Text('Event manager'),
                              ),
                              DropdownMenuItem(
                                value: Role.financeManager,
                                child: Text('Finance manager'),
                              ),
                              DropdownMenuItem(
                                value: Role.guide,
                                child: Text('Guide'),
                              ),
                            ],
                            onChanged: (item) {
                              setState(() {
                                switch (item!) {
                                  case Role.client:
                                    role = 'client';
                                    break;
                                  case Role.eventManager:
                                    role = 'eventManager';
                                    break;
                                  case Role.financeManager:
                                    role = 'financeManager';
                                    break;
                                  case Role.guide:
                                    role = 'guide';
                                    break;
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 45.0),
                          SizedBox(
                            height: 40.0,
                            child: GestureDetector(
                              onTap: () async {
                                if (_formkey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });

                                  // AuthService method to register user when validation is successful
                                  Client? result =
                                      await _auth.registerWithEmailAndPassword(
                                    name,
                                    email,
                                    password,
                                    role,
                                  );

                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                      error =
                                          'Credentials may have been used before. Try again';
                                    });
                                  } else {
                                    Provider.of<AuthNotifier>(context)
                                        .setUser(result);
                                  }

                                  // Else, the Wrapper gets a new user and shows the Home Page
                                }
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.blueAccent,
                                color: Colors.blue,
                                elevation: 7.0,
                                child: const Center(
                                  child: Text(
                                    'REGISTER',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    )),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Already have an account?',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    const SizedBox(width: 5.0),
                    InkWell(
                      onTap: () {
                        widget.toggleView();
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                            color: lightBlue,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      error,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                  ],
                )
              ],
            ));
  }
}
