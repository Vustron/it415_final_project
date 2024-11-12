import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:babysitterapp/core/constants.dart';

class EditImage extends StatelessWidget {
  const EditImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: <Widget>[
        Image.asset(avatar2, width: 120, height: 120),
        Positioned(
          bottom: 3,
          left: 2,
          child: GestureDetector(
            onTap: () {
              imageUpload();
            },
            child: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

Future<void> imageUpload() async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
  );

  if (result != null && result.files.isNotEmpty) {
    final PlatformFile file = result.files.first;

    log('File name: ${file.name}');
    log('File path: ${file.path}');
  } else {
    log('No file selected.');
  }
}
