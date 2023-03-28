import 'package:flutter/material.dart';

class AppbarView extends StatefulWidget {
  const AppbarView({super.key});

  @override
  State<AppbarView> createState() => _AppbarViewState();
}

class _AppbarViewState extends State<AppbarView> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      //backgroundColor: const Color.fromARGB(1, 0, 0, 0),
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: 35,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const TextField(
          decoration: InputDecoration(
            icon: Icon(
              Icons.search_outlined,
              size: 25,
              color: Colors.pink,
            ),
            hintText: 'Set quà tặng siêu cute',
            border: InputBorder.none,
          ),
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Icon(
            Icons.shopping_cart_outlined,
            size: 28,
          ),
        ),
        Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.chat_outlined)),
      ],
      elevation: 0,
    );
  }
}
