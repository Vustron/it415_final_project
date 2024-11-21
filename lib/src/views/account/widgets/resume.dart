import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';

class ResumeUpload extends StatefulWidget {
  const ResumeUpload({super.key});

  @override
  State<ResumeUpload> createState() => _ResumeUploadState();
}

class _ResumeUploadState extends State<ResumeUpload> {
  bool _isImageListVisible = false;

  final List<String> _images = <String>[avatar1, avatar2];

  void _toggleImageList() {
    setState(() {
      _isImageListVisible = !_isImageListVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _toggleImageList();
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.insert_drive_file,
                      color: GlobalStyles.primaryButtonColor,
                      size: 35,
                    ),
                    SizedBox(width: 10),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Resume',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            'List of all your resume',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ])
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 24,
                )
              ],
            ),
          ),
        ),
        if (_isImageListVisible) ...<Widget>[
          SizedBox(
            height: 100,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _images.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      _images[index],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  );
                }),
          )
        ]
      ],
    );
  }
}
