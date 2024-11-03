import 'package:babysitterapp/core/constants/styles.dart';
import 'package:babysitterapp/views/client_profile/widgets/save_changes_button.dart';
import 'package:babysitterapp/views/client_profile/widgets/user_profile.dart';

// flutter
import 'package:flutter/material.dart';

class ClientProfile extends StatelessWidget {
  const ClientProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          // Adjusts the height based on the content
          child: Column(
            children: <Widget>[
              const UserProfile(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      _buildInputField(
                          icon: Icons.person,
                          hintText: 'Enter you Name',
                          initialValue: 'Arvin Sison'),
                      const SizedBox(height: 20),
                      _buildInputField(
                          icon: Icons.location_on_sharp,
                          hintText: 'Enter your Address',
                          initialValue: 'Purok Salvacion Panabo City'),
                      const SizedBox(height: 20),
                      _buildInputField(
                          icon: Icons.phone,
                          hintText: 'Enter your Phone Number',
                          initialValue: '09252325981'),
                      const SizedBox(height: 20),
                      _buildInputField(
                          icon: Icons.email,
                          hintText: 'Enter your Email',
                          initialValue: 'arvinsison@gmail.com'),
                      const SizedBox(height: 20),
                      _buildInputField(
                          icon: Icons.password,
                          hintText: 'Enter your Password',
                          isPassword: true),
                      const SizedBox(height: 20),
                      const Spacer(),
                      SaveChangesButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildInputField(
    {IconData? icon,
    String? hintText,
    String? initialValue,
    bool isPassword = false}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 0.8,
          offset: const Offset(0, 4)
        )
      ]
    ),
    child: Row(
      children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: GlobalStyles.primaryButtonColor, 
              borderRadius: BorderRadius.circular(10)
            ),
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: Colors.white,
            ),

          ),

        Expanded(
          child: TextFormField(
            obscureText: isPassword,
            initialValue: initialValue,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 12
                ), 
              border: InputBorder.none, 
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            
          ),
        ),
      ],
    ),
  );
}
