import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _indexPage = 0;
  //final idUser = FirebaseAuth.instance.currentUser;
  final List _pages = [
    const ProductView(),
    Container(color: Colors.amber),
    const ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _indexPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      //extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
          preferredSize: Size.fromRadius(30), child: AppbarView()),
      body: _pages[_indexPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Sản phẩm'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Yêu thích',
              activeIcon: Icon(Icons.favorite)),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Tài khoản',
              activeIcon: Icon(Icons.account_circle_rounded)),
        ],
        currentIndex: _indexPage,
        onTap: _onItemTapped,
      ),
    );
  }
}