import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/ui/profile/profile_detail.dart';
import 'package:myproject_app/ui/screen.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileDetail()));
            },
            child: Row(
              children: const [
                Icon(
                  Icons.account_box_rounded,
                  color: Colors.pink,
                ),
                Text("Cập nhật thông tin tài khoản")
              ],
            ),
          ),
          Text(user!.email.toString()),
          ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginView()),
                      (route) => false);
                });
              },
              child: const Text("Đăng xuất"))
        ]),
      ),
    );
  }
}
