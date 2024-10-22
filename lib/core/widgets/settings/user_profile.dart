import 'package:babysitterapp/core/constants/assets.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          const CircleAvatar(
            backgroundImage: AssetImage(avatar2),
            radius: 70,
          ),

          Positioned(
            bottom: 0,
            left: 0,
            child: GestureDetector(
              onTap: (){},
              child: Container(
                padding: const EdgeInsets.all(8.0),

                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),
          const Text(
            'Arvin Sison',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'arvinsison@gmail.com',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
