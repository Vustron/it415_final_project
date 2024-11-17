import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:babysitterapp/core/components.dart';

import 'package:babysitterapp/models/models.dart';

class EditAccount extends StatelessWidget {
  const EditAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final List<InputFieldConfig> fields = <InputFieldConfig>[
      InputFieldConfig(
        label: 'Full Name',
        hintText: 'Enter your full name',
        value: 'Arvin Sison',
        prefixIcon: Icons.person,
        type: 'text',
      ),
      InputFieldConfig(
        label: 'Email',
        hintText: 'Enter your email',
        value: 'arvinsison@gmail.com',
        prefixIcon: Icons.email,
        keyboardType: TextInputType.emailAddress,
        type: 'email',
      ),
      InputFieldConfig(
        label: 'Phone Number',
        hintText: 'Enter your phone number',
        value: '09252325981',
        prefixIcon: Icons.phone,
        keyboardType: TextInputType.phone,
        type: 'text',
      ),
      InputFieldConfig(
        label: 'Address',
        hintText: 'Enter your address',
        value: 'Purok Salvacion Panabo City',
        prefixIcon: Icons.location_on_sharp,
        type: 'text',
      ),
      InputFieldConfig(
        label: 'Password',
        hintText: 'Enter your password',
        prefixIcon: Icons.password,
        obscureText: true,
        type: 'password',
      ),
    ];

    void onSubmit(Map<String, String> formData) {
      log(formData.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueAccent,
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            DynamicForm(
              fields: fields,
              onSubmit: onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
