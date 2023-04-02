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
    double widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(),
      body: Center(
        child: Column(children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileDetail()));
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    width: widthDevice / 7,
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                      Icons.account_box_rounded,
                      color: Colors.pink,
                      size: 35,
                    ),
                  ),
                  const Text(
                    "Thông tin người dùng",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          InkWell(
            onTap: () {},
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    width: widthDevice / 7,
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                      Icons.near_me_rounded,
                      color: Colors.pink,
                      size: 35,
                    ),
                  ),
                  const Text(
                    "Thông tin đơn hàng",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
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
