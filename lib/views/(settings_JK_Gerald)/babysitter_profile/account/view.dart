import 'package:flutter/material.dart';

import 'widgets/image_edit_button.dart';
import 'widgets/years_experience.dart';
import 'widgets/service_history.dart';
import 'widgets/contacts.dart';
import 'widgets/valid_id.dart';
import 'widgets/ratings.dart';

import 'package:babysitterapp/views/(settings_JK_Gerald)/babysitter_profile/account/widgets/rate.dart';

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
        automaticallyImplyLeading: false,
        title: const Text('Account'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 18),
              AccountImageEditButton(),
              SizedBox(height: 14),
              Text(
                'Good Day! My Name is Arvin Sison from Panabo City. I am currently looking for a job, babysit. I have many experience working as a babysitter. I am honest flexible and hardworking person.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 14),
              Divider(color: Colors.grey, thickness: 1),
              SizedBox(height: 14),
              Rate(),
              SizedBox(height: 15),
              Divider(color: Colors.grey, thickness: 1),
              SizedBox(height: 14),
              YearsExperience(),
              SizedBox(height: 15),
              Divider(color: Colors.grey, thickness: 1),
              SizedBox(height: 16),
              Ratings(),
              SizedBox(height: 12),
              Divider(color: Colors.grey, thickness: 1),
              ServiceHistoryUpload(),
              Divider(color: Colors.grey, thickness: 1),
              ValidIdUpload(),
              Divider(color: Colors.grey, thickness: 1),
              SizedBox(height: 14),
              Contacts(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
