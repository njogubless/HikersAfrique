// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hikersafrique/constant.dart';
import 'package:hikersafrique/services/auth.dart';

class SignIn extends StatefulWidget {
  // Accepting the toggle view function
  final Function toggleView;
  const SignIn({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Instance of AuthService which accesses methods to
  // register and sign in with email and pass: used in an on pressed event
  final AuthService _auth = AuthService();
  // Form key for input validation
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  // Form fields, taking note of their states
  String email = '';
  String password = '';

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
                      padding: const EdgeInsets.fromLTRB(15.0, 60.0, 0.0, 0.0),
                      child: const Text('Welcome',
                          style: TextStyle(
                              fontSize: 50.0, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(16.0, 110.0, 0.0, 0.0),
                      child: const Text('Back',
                          style: TextStyle(
                              fontSize: 80.0, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(177.0, 110.0, 0.0, 0.0),
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
                        top: 30.0, left: 20.0, right: 20.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
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
                            validator: (val) => val!.length < 6
                                ? 'Password less than 6 characters long'
                                : null,
                            onChanged: (val) {
                              setState(() {
                                password = val.trim();
                              });
                            },
                            obscureText: true,
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
                                  // AuthService method to sign in user when validation is successful
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);

                                  if (result == null) {
                                    loading = false;
                                    setState(() => error =
                                        'Invalid login, please try again');
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
                                    'SIGN IN',
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
                      'Don\'t have an account?',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    const SizedBox(width: 5.0),
                    InkWell(
                      onTap: () {
                        widget.toggleView();
                      },
                      child: const Text(
                        'Register',
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
