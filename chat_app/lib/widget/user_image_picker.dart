import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onpickedimage});
  final void Function(File pickedimage) onpickedimage;

  @override
  State<UserImagePicker> createState() {
    return _UserImagePickerState();
  }
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedimagefile;

  void _pickimage() async {
    bool? isCamera = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Camera"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("gallery "),
            ),
          ],
        ),
      ),
    );
    if (isCamera == null) return;

    final pickedimage = await ImagePicker().pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 150);
    if (pickedimage == null) {
      return;
    }

    setState(() {
      _pickedimagefile = File(pickedimage.path);
    });
    widget.onpickedimage(_pickedimagefile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:
              _pickedimagefile != null ? FileImage(_pickedimagefile!) : null,
        ),
        TextButton.icon(
            onPressed: _pickimage,
            icon: const Icon(Icons.image),
            label: Text(
              "Add Image",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ))
      ],
    );
  }
}
