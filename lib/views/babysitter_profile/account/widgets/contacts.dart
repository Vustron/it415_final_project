import 'package:babysitterapp/core/constants/styles.dart';
import 'package:flutter/material.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Contacts',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),

              SizedBox(height: 15),


              Row(
                children: <Widget>[
                  SizedBox(width: 18), 

                  Icon(
                    Icons.phone,
                    color: GlobalStyles.primaryButtonColor,
                    size: 30,
                  ),
                  SizedBox(width: 14),
                 
                  Text(
                    '09594820689',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 16,
                      ),
                  ),
                      
                   
                ],
              ),


              SizedBox(height: 22),

              Row(
                children: <Widget>[
                  SizedBox(width: 18), 

                  Icon(
                    Icons.facebook,
                    color: GlobalStyles.primaryButtonColor,
                    size: 30,
                  ),
                  SizedBox(width: 14),
                 
                  Text(
                    'Arvin Sison',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 16
                      ),
                  ),
                      
                   
                ],
              ),


              SizedBox(height: 22),

              Row(
                children: <Widget>[
                  SizedBox(width: 18), 

                  Icon(
                    Icons.my_location_outlined,
                    color: GlobalStyles.primaryButtonColor,
                    size: 30,
                  ),
                  SizedBox(width: 14),
                 
                  Text(
                    'San Vicente Panabo City',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 16
                      ),
                  ),
                      
                   
                ],
              ),
      ],
    );
  }
}
