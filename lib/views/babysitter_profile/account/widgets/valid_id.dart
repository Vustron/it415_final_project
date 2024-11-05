import 'package:babysitterapp/core/constants/assets.dart';
import 'package:babysitterapp/core/constants/styles.dart';
import 'package:flutter/material.dart';

class ValidIdUpload extends StatefulWidget {
  const ValidIdUpload({super.key});

  @override
  State<ValidIdUpload> createState() => _ValidIdUploadState();
}

class _ValidIdUploadState extends State<ValidIdUpload> {
  bool _isImageListVisible = false;

  final List<String> _images = <String>[
    avatar1,
    avatar2
  ];

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
                      Icons.file_download_outlined,
                      color: GlobalStyles.primaryButtonColor,
                      size: 35,
                    ),
                    SizedBox(width: 10),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Valid ID',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            'List of all your valid ID',
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
