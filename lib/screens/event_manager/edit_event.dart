// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/services/database.dart';

class EditEvent extends StatefulWidget {
  const EditEvent({super.key, required this.event});

  final Event event;

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  bool _loading = false;
  final _formkey = GlobalKey<FormState>();
  late TextEditingController _eventNameController;
  late TextEditingController _eventDateController;
  late TextEditingController _eventTimeController;
  late TextEditingController _eventCostController;
  late TextEditingController _eventLocationController;
  late TextEditingController _eventImageUrlController;

  @override
  void initState() {
    _eventNameController = TextEditingController()
      ..text = widget.event.eventName;
    _eventDateController = TextEditingController()
      ..text = widget.event.eventDate;
    _eventTimeController = TextEditingController()
      ..text = widget.event.eventTime;
    _eventCostController = TextEditingController()
      ..text = widget.event.eventCost.toString();
    _eventLocationController = TextEditingController()
      ..text = widget.event.eventLocation;
    _eventImageUrlController = TextEditingController()
      ..text = widget.event.eventImageUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Edit Event',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _eventNameController,
                        decoration: const InputDecoration(
                            labelText: 'EVENT NAME',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                          controller: _eventDateController,
                          decoration: const InputDecoration(
                            labelText: 'EVENT DATE',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                              ),
                            ),
                          )),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: _eventTimeController,
                        decoration: const InputDecoration(
                            labelText: 'EVENT TIME',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: _eventCostController,
                        decoration: const InputDecoration(
                            labelText: 'EVENT COST',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: _eventLocationController,
                        decoration: const InputDecoration(
                            labelText: 'EVENT LOCATION',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: _eventImageUrlController,
                        decoration: const InputDecoration(
                            labelText: 'EVENT IMAGE URL',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      const SizedBox(height: 45.0),
                      if (_loading)
                        const CircularProgressIndicator()
                      else
                        InkWell(
                          onTap: () async {
                            setState(() {
                              _loading = true;
                            });
                            await Database.editEvent(
                              widget.event,
                              Event(
                                eventID: widget.event.eventID,
                                eventCost: int.parse(_eventCostController.text),
                                eventDate: _eventDateController.text,
                                eventImageUrl: _eventImageUrlController.text,
                                eventLocation: _eventLocationController.text,
                                eventName: _eventNameController.text,
                                eventTime: _eventTimeController.text,
                              ),
                            );
                            _eventNameController.clear();
                            _eventDateController.clear();
                            _eventTimeController.clear();
                            _eventCostController.clear();
                            _eventLocationController.clear();
                            _eventImageUrlController.clear();
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Event edited!'),
                              behavior: SnackBarBehavior.floating,
                            ));
                          },
                          child: SizedBox(
                            height: 40,
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.blue,
                              elevation: 7.0,
                              child: const Center(
                                child: Text(
                                  'EDIT EVENT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
