import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class MyImageUploadWidget extends StatefulWidget {
  @override
  _MyImageUploadWidgetState createState() => _MyImageUploadWidgetState();
}

class _MyImageUploadWidgetState extends State<MyImageUploadWidget> {
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventImageUrlController =
      TextEditingController();

  File? imageFile;
  String? pickedImageFileName;

  void pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
        pickedImageFileName = pickedImage.name;
      });
    }
  }

  void uploadEvent(WidgetRef ref) async {
    if (imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please select an image"),
        ),
      );
    } else {
      debugPrint("uploading");
      await Database.createEvent(
        Event(
          eventID: const Uuid().v4(),
          eventCost: int.parse(_eventCostController.text),
          eventDate: _eventDateController.text,
          eventImageUrl: _eventImageUrlController.text,
          eventLocation: _eventLocationController.text,
          eventName: _eventNameController.text,
          eventTime: _eventTimeController.text,
        ),
        imageFile: imageFile!,
        context: context,
      ).then((value) => Navigator.of(context).pop());
    }
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventImageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 45.0),
        InkWell(
          onTap: () => pickImage(),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.image),
          ),
        ),
        SizedBox(height: 10),
        Text(pickedImageFileName ?? 'No image selected'),
        ElevatedButton(
          onPressed: () => uploadEvent(context),
          child: Text('Upload Event'),
        ),
      ],
    );
  }
}
