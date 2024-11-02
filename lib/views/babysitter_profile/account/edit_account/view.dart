import 'package:babysitterapp/views/babysitter_profile/account/edit_account/widgets/bio.dart';
import 'package:babysitterapp/views/babysitter_profile/account/edit_account/widgets/image.dart';
import 'package:babysitterapp/views/babysitter_profile/account/edit_account/widgets/rate.dart';
import 'package:babysitterapp/views/babysitter_profile/account/edit_account/widgets/experience.dart';
import 'package:babysitterapp/views/babysitter_profile/account/edit_account/widgets/resume.dart';
import 'package:babysitterapp/views/babysitter_profile/account/edit_account/widgets/service_history.dart';
import 'package:babysitterapp/views/babysitter_profile/account/edit_account/widgets/valid_id.dart';
import 'package:babysitterapp/views/babysitter_profile/account/edit_account/widgets/contacts.dart';
import 'package:babysitterapp/views/babysitter_profile/account/edit_account/widgets/save_edit_button.dart';
import 'package:flutter/material.dart';

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

              EditBIO(),

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

              EditResume(),


              SizedBox(height: 24),

              Divider(color: Colors.grey, thickness: 1),

              SizedBox(height: 8),

              EditContacts(),


              SizedBox(height: 18),

              SaveEditButton(),
              
            ],
          ),
        ),
      ),
    );
  }
}
