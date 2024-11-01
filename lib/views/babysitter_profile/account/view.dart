import 'package:babysitterapp/core/constants/assets.dart';
import 'package:babysitterapp/core/constants/styles.dart';
import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  // PROFILE AND RATE PER HOUR
                  Row(
                    children: <Widget>[
                      Image.asset(
                        avatar2,
                        width: 120,
                        height: 120,
                      ),
                      const SizedBox(width: 8),
                      const Column(
                        children: <Widget>[
                          Text(
                            'Arvin Sison',
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'arvinsison@gmail.com',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          
                        ],
                      ),
                    ],
                  ),

                  Column(
                    children: <Widget>[
                      const Text(
                        '₱ 300/hr',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 3),
                      ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                const WidgetStatePropertyAll<Color>(
                                    GlobalStyles.primaryButtonColor),
                            shape: MaterialStatePropertyAll<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          child: const Row(
                            children: <Widget>[
                              Icon(
                                Icons.edit,
                                size: 12,
                              ),
                              SizedBox(width: 3),
                              Text(
                                'Edit Profile',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ))
                    ],
                  )
                ],
              ),

              const SizedBox(height: 18),

              // BIO
              const Text(
                'Good Day! My Name is Arvin Sison from Panabo City. I am currently looking for a job, babysit. I have many experience working as a babysitter. I am honest flexible and hardworking person.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),

              const SizedBox(height: 14),

              const Divider(color: Colors.grey, thickness: 1),

              const SizedBox(height: 14),

              // YEARS EXPERIENCE
              const Row(
                children: <Widget>[
                  SizedBox(width: 18), 

                  Icon(
                    Icons.baby_changing_station,
                    color: GlobalStyles.primaryButtonColor,
                    size: 35,
                  ),
                  SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'BabySitting Experience',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        '+8 years',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 15),

              const Divider(color: Colors.grey, thickness: 1),

              const SizedBox(height: 16),

              // RATINGS
              const Row(
                children: <Widget>[
                  SizedBox(width: 18), 

                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 35,
                  ),
                  SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Ratings',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        '4.5 stars',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),


              const SizedBox(height: 12),


              // SEVICE HISTORY UPLOAD

              const Divider(color: Colors.grey, thickness: 1),
              
              GestureDetector(
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
                              Icons.history,
                              color: GlobalStyles.primaryButtonColor,
                              size: 35,
                            ),

                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Service History',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                Text(
                                  'Uploaded images for experiences proof',
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
              ),

              const Divider(color: Colors.grey, thickness: 1),


              // VALID ID UPLOAD
              GestureDetector(
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
              ),

              const Divider(color: Colors.grey, thickness: 1),




              // RESUME ID UPLOAD
              GestureDetector(
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
              ),

              const Divider(color: Colors.grey, thickness: 1),

              const SizedBox(height: 14),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Contacts',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),

              const SizedBox(height: 15),


              const Row(
                children: <Widget>[
                  SizedBox(width: 18), 

                  Icon(
                    Icons.phone,
                    color: GlobalStyles.primaryButtonColor,
                    size: 30,
                  ),
                  SizedBox(width: 14),
                 
                  Text(
                    '+639594820689',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 16
                      ),
                  ),
                      
                   
                ],
              ),


              const SizedBox(height: 22),

              const Row(
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


              const SizedBox(height: 22),

              const Row(
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


              const SizedBox(height: 100),

            ],
          ),
        ),
      ),
    );
  }
}
