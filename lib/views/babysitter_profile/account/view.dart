import 'widgets/contacts.dart';
import 'widgets/image_edit_button.dart';
import 'widgets/rate.dart';
import 'widgets/ratings.dart';
import 'widgets/service_history.dart';
import 'widgets/valid_id.dart';
import 'widgets/years_experience.dart';
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
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 18),

              AccountImageEditButton(),

              SizedBox(height: 14),

              // BIO
              Text(
                'Good Day! My Name is Arvin Sison from Panabo City. I am currently looking for a job, babysit. I have many experience working as a babysitter. I am honest flexible and hardworking person.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),

              SizedBox(height: 14),

              Divider(color: Colors.grey, thickness: 1),

              SizedBox(height: 14),

              // YEARS EXPERIENCE
              Rate(),

              SizedBox(height: 15),

              Divider(color: Colors.grey, thickness: 1),

              SizedBox(height: 14),

              // YEARS EXPERIENCE
              YearsExperience(),

              SizedBox(height: 15),

              Divider(color: Colors.grey, thickness: 1),

              SizedBox(height: 16),

              // RATINGS
              Ratings(),

              SizedBox(height: 12),

              // SERVICE HISTORY UPLOAD

              Divider(color: Colors.grey, thickness: 1),

              ServiceHistoryUpload(),

              Divider(color: Colors.grey, thickness: 1),

              // VALID ID UPLOAD
              ValidIdUpload(),

              Divider(color: Colors.grey, thickness: 1),

              SizedBox(height: 14),

              // CONTACTS
              Contacts(),

              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
