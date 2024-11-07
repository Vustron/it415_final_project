import 'package:flutter/material.dart';
import 'widgets/bio.dart';
import 'widgets/image.dart';
import 'widgets/rate.dart';
import 'widgets/experience.dart';
import 'widgets/service_history.dart';
import 'widgets/valid_id.dart';
import 'widgets/contacts.dart';
import 'widgets/save_edit_button.dart';

class EditBabySitterProfile extends StatelessWidget {
  const EditBabySitterProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Account'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              EditImage(),
              SizedBox(height: 20),
              EditBio(),
              SizedBox(height: 14),
              Divider(color: Colors.grey, thickness: 1),
              SizedBox(height: 8),
              EditRate(),
              SizedBox(height: 14),
              EditBabySittingExperience(),
              SizedBox(height: 14),
              Divider(color: Colors.grey, thickness: 1),
              SizedBox(height: 8),
              EditServiceHistory(),
              SizedBox(height: 24),
              EditValidID(),
              SizedBox(height: 24),
              Divider(color: Colors.grey, thickness: 1),
              SizedBox(height: 8),
              EditContacts(),
              SizedBox(height: 18),
              SaveEditButton(),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
