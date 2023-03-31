import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/model/user.dart';

import '../../service/user_service.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final docUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<List<Users>>(
        stream: UserService.readUser(),
        builder: (context, snapshot) {
          final user = snapshot.data!;
          return ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: user.map(_buildUser).toList());
        },
      ),
    );
  }

  Widget _buildUser(Users user) {
    return Center(
        child: Column(
      children: [
        Text(user.email),
        Text(user.address),
        Text(user.phone),
        Text(user.toMap().toString())
      ],
    ));
  }
}
