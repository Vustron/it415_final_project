import 'package:flutter/material.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){}, 
          icon: const Icon(Icons.arrow_back, color: Colors.black),

        ),
      ),

      body: SingleChildScrollView( 
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20), 

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Personal Info',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12), // Space below "GENERAL"

              // Centering the SizedBox containing the input card
              Center(
                
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _buildInputField('First Name', 'Enter your First Name'),
                          const SizedBox(height: 12),

                           _buildInputField('First Name', 'Enter your First Name'),
                          const SizedBox(height: 12),

                           _buildInputField('First Name', 'Enter your First Name'),
                          const SizedBox(height: 12),

                           _buildInputField('First Name', 'Enter your First Name'),
                          const SizedBox(height: 12),

                           _buildInputField('First Name', 'Enter your First Name'),
                          const SizedBox(height: 12),

                           _buildInputField('First Name', 'Enter your First Name'),
                          const SizedBox(height: 12),

                          // _buildInputField('First Name'),
                          // const SizedBox(height: 12),

                          // _buildInputField('Address'),
                          // const SizedBox(height: 12),

                          // _buildInputField('Phone Number'),
                          // const SizedBox(height: 12),

                          // _buildInputField('Email'),
                          // const SizedBox(height: 12),

                          // _buildInputField('Password', isPassword: true),
                          // const SizedBox(height: 20),

                          Material( 
                            elevation: 5, 
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade200, // Set button background color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 10), // Reduced padding for smaller size
                                ),
                                child: const Text(
                                  'Save Changes',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // Set text color to white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),             
            ],
          ),
        ),
    );
  }
}



 Widget _buildInputField(String label, String hintText, {bool isPassword = false}) {
    return Container(
      width: double.infinity, 
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5), 
        
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
            
          Expanded(
            child: TextFormField(
              obscureText: isPassword,
              style: const TextStyle(fontWeight: FontWeight.bold), 
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey, 
                  fontWeight: FontWeight.w800
                ), 
                contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12), // Further reduced padding for height
                border: InputBorder.none, // Remove the border
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildInputRow(String label1, String label2) {
  //   return Row(
  //     children: [
  //       Expanded(child: _buildInputField(label1)),
  //       const SizedBox(width: 8),
  //       Expanded(child: _buildInputField(label2)),
  //     ],
  //   );
  // }
