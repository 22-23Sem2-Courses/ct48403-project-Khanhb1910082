import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({super.key});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      "Đặt hàng thành công",
                      style: TextStyle(fontSize: 24),
                    )),
                Image.asset(
                  "assets/images/tick.png",
                  height: 30,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Trang chủ"))
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Đơn hàng")),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
