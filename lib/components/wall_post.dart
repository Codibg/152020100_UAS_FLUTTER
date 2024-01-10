import 'package:flutter/material.dart';

class WallPost extends StatelessWidget {
  final String message;
  final String user;
  const WallPost({
    super.key,
    required this.message,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: EdgeInsets.all(18),
      child: Row(
        children: [
          //profile
          Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.grey[400]),
            padding: EdgeInsets.all(10),
            child: const Icon(
              Icons.person,
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 20),

          //message user email

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user,
                style: TextStyle(color: Colors.grey[500]),
              ),
              const SizedBox(height: 10),
              Text(message),
            ],
          )
        ],
      ),
    );
  }
}
