import 'package:babysitterapp/core/constants/styles.dart';
import 'package:flutter/material.dart';

class EditValidID extends StatelessWidget {
  const EditValidID({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Valid ID',
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
                  // Handle the click event here
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
                        'Add new valid ID ',
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
