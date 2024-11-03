import 'package:babysitterapp/core/constants/styles.dart';
import 'package:flutter/material.dart';

class ResumeUpload extends StatelessWidget {
  const ResumeUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                onTap: () {
                  // Add your click action here
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
                              ]
                            )
                          ],
                        ),

                        Icon(
                          Icons.arrow_forward_ios,
                          size: 24,
                        )
                        
                    ],
                  ),
                ),
              );
  }
}
