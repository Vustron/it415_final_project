import 'package:flutter/material.dart';

import 'package:babysitterapp/core/components/input.dart';

import 'widgets/save_changes_button.dart';
import 'widgets/user_profile.dart';

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
          child: Column(
            children: <Widget>[
              const UserProfile(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      CustomTextInput(
                        onChanged: (String value) {},
                        hintText: 'Enter your Name',
                        initialValue: 'Arvin Sison',
                        prefixIcon:
                            const Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      CustomTextInput(
                        onChanged: (String value) {},
                        hintText: 'Enter your Address',
                        initialValue: 'Purok Salvacion Panabo City',
                        prefixIcon: const Icon(Icons.location_on_sharp,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      CustomTextInput(
                        onChanged: (String value) {},
                        hintText: 'Enter your Phone Number',
                        initialValue: '09252325981',
                        prefixIcon:
                            const Icon(Icons.phone, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      CustomTextInput(
                        onChanged: (String value) {},
                        hintText: 'Enter your Email',
                        initialValue: 'arvinsison@gmail.com',
                        prefixIcon:
                            const Icon(Icons.email, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      CustomTextInput(
                        onChanged: (String value) {},
                        hintText: 'Enter your Password',
                        obscureText: true,
                        prefixIcon:
                            const Icon(Icons.password, color: Colors.white),
                      ),
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
