import 'package:babysitterapp/core/constants/styles.dart';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';


class EditServiceHistory extends StatelessWidget {
  const EditServiceHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Service History',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: GlobalStyles.primaryButtonColor

                  ),
                ),
              ),

              const SizedBox(height: 4),

              GestureDetector(
                onTap: () {
                  serviceHistoryUpload();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 2.0, // Border width
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the content horizontally
                    children: <Widget>[

                      Icon(
                        Icons.add, 
                        color: Colors.black, 
                        size: 20, 
                      ),

                      Text(
                        'Add new service history image ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      
                    ],
                  ),
                ),
              )
      ],
    );
  }
}


Future<void> serviceHistoryUpload() async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
  );

  if (result != null && result.files.isNotEmpty) {
      final PlatformFile file = result.files.first;

      print('File name: ${file.name}');
      print('File path: ${file.path}'); 
    } else {
      print('No file selected.');
    }
} 
