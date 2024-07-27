import 'package:flutter/material.dart';

import '../../../data/models/user.dart';

class ListUser extends StatelessWidget {
  final UserModle user;
  const ListUser({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: Row(
          children: [
            // Image.asset(user.gender.name.getGenderWidget, height: 75),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                  ),
                  const SizedBox(height: 10),
                  Text(user.email)
                ],
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
