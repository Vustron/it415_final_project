import 'package:flutter/material.dart';

Widget babySitterCardBio(BuildContext context, {required String userBio}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Text(
        userBio,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
              height: 1.4,
              fontSize: 13,
            ),
      ),
    );
