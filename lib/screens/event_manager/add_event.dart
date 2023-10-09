import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddEvents extends StatefulWidget {
  const AddEvents({Key? key}) : super(key: key);

  @override
  State<AddEvents> createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  final _formkey = GlobalKey<FormState>();
  final _eventNameController = TextEditingController();
  final _eventDateController = TextEditingController();
  final _eventTimeController = TextEditingController();
  final _eventCostController = TextEditingController();
  final _eventLocationController = TextEditingController();
  final _eventImageUrlController = TextEditingController();

  File? imageFile;
  String? pickedImageFileName;

   Future pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        imageFile = File(image.path);
        pickedImageFileName = image.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Add Events',
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
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
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
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _eventTimeController,
                      decoration: const InputDecoration(
                        labelText: 'EVENT TIME',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _eventCostController,
                      decoration: const InputDecoration(
                        labelText: 'EVENT COST',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _eventLocationController,
                      decoration: const InputDecoration(
                        labelText: 'EVENT LOCATION',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _eventImageUrlController,
                      decoration: const InputDecoration(
                        labelText: 'EVENT IMAGE URL',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                       ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 45.0),
                        InkWell(
                          onTap: () => pickImage(),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.image),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(pickedImageFileName ?? 'No image selected'),
                        ElevatedButton(
                          onPressed: () => pickImage(),
                          child: const Text('Upload image'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 45.0),
                    InkWell(
                      onTap: () async {
                        if (imageFile != null) {
                          createEventWithImage(imageFile!);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please pick an image'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      child: SizedBox(
                        height: 40,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.black,
                          elevation: 7.0,
                          child: const Center(
                            child: Text(
                              'CREATE EVENT',
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
            ),
          ],
        ),
      ),
    );
  }

  void createEventWithImage(File imageFile) async {
    final scaff = ScaffoldMessenger.of(context);
    final event = Event(
      eventID: const Uuid().v4(),
      eventCost: int.parse(_eventCostController.text),
      eventDate: _eventDateController.text,
     eventImageUrl: _eventImageUrlController.text,
      eventLocation: _eventLocationController.text,
      eventName: _eventNameController.text,
      eventTime: _eventTimeController.text,
    );

    await Database.createEvent(
      event,
      imageFile: imageFile,
      context: context,
    );

    _eventNameController.clear();
    _eventDateController.clear();
    _eventTimeController.clear();
    _eventCostController.clear();
    _eventLocationController.clear();
    //_eventImageUrlController.clear();
    scaff.showSnackBar(
      const SnackBar(
        content: Text('Event created!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
