import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:myproject_app/model/cart.dart';
import 'package:myproject_app/model/product.dart';
import '../screen.dart';

class BottomSheetView extends StatefulWidget {
  const BottomSheetView(this.product, this.nameBottom, {super.key});
  final Product product;
  final String nameBottom;
  @override
  State<BottomSheetView> createState() => _BottomSheetViewState();
}

class _BottomSheetViewState extends State<BottomSheetView> {
  int indexItem = 1;
  int _selectedIndex = 0;
  @override
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 10;
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Container(
            height: 4,
            width: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(225, 223, 221, 221),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                  width: width * 3.5,
                  child:
                      Image.network(widget.product.productUrl[_selectedIndex])),
              const SizedBox(width: 20),
              SizedBox(
                height: width * 3.5,
                width: width * 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.productName,
                      style: const TextStyle(fontSize: 17),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Text("Số lượng: ${widget.product.quantity}"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                "Màu:",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 30),
              for (int i = 0; i < widget.product.color.length; i++)
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = i;
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        color: _selectedIndex != i
                            ? Colors.black12
                            : Colors.pinkAccent,
                        borderRadius:
                            const BorderRadius.all(Radius.elliptical(10, 5)),
                        border: Border.all(color: Colors.black)),
                    child: Text(
                      widget.product.color[i],
                      style: TextStyle(
                        color:
                            _selectedIndex == i ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                'Số lượng:',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 30),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (indexItem > 1) {
                        indexItem--;
                      }
                    });
                  },
                  child: const Icon(
                    CupertinoIcons.minus,
                    size: 18,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 25,
                child: Center(
                  child: Text(
                    '$indexItem',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (indexItem < 40) {
                        indexItem++;
                      }
                    });
                  },
                  child: const Icon(
                    Icons.add,
                    size: 18,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Thanh toán:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${MoneyFormatter(amount: indexItem * widget.product.price.toDouble()).output.withoutFractionDigits}đ',
                style: const TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          InkWell(
            onTap: () {
              if (widget.nameBottom != 'Đặt hàng') {
                CollectionReference cart =
                    FirebaseFirestore.instance.collection('cart');
                cart
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection(
                        FirebaseAuth.instance.currentUser!.email.toString())
                    .add(CartItem(
                            id: widget.product.id,
                            productName: widget.product.productName,
                            productUrl:
                                widget.product.productUrl[_selectedIndex],
                            quantity: indexItem,
                            price: widget.product.price.toDouble())
                        .toMap());
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => widget.nameBottom != 'Đặt hàng'
                          ? const CartView()
                          : const OrderView()));
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.nameBottom,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
