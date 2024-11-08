import 'package:babysitterapp/core/constants/styles.dart';
import 'package:flutter/material.dart';

class EditBio extends StatelessWidget {
  const EditBio({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Bio',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: GlobalStyles.primaryButtonColor),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue:
              'Good Day! My Name is Arvin Sison from Panabo City. I am currently looking for a job, babysit. I have many experience working as a babysitter. I am honest flexible and hardworking person.',
          maxLines: 3,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your bio here',
          ),
        )
      ],
    );
  }
}
