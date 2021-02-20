import 'package:flutter/material.dart';
import 'package:projeto_igreja/models/user.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile({this.user});

  @override
  Widget build(BuildContext context) {
    final avatar = user.data == null || user.data.isEmpty
        ? CircleAvatar(
            child: Icon(Icons.person),
          )
        : CircleAvatar(backgroundImage: NetworkImage(user.data));

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
    );
  }
}
