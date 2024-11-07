import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants/assets.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomLeft,
            children: <Widget>[
              const CircleAvatar(
                backgroundImage: AssetImage(avatar2),
                radius: 70,
              ),
              Positioned(
                bottom: 3,
                left: 2,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
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

          const SizedBox(height: 20),

          // const Stats(),
        ],
      ),
    );
  }
}
