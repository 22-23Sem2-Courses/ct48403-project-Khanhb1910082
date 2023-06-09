import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:myproject_app/model/product.dart';
import 'package:myproject_app/ui/product/product_detail.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../../service/product_service.dart';
import '../cart/cart_manager.dart';
import '../screen.dart';

class FavoriteListView extends StatefulWidget {
  const FavoriteListView({super.key});

  @override
  State<FavoriteListView> createState() => _FavoriteListViewState();
}

class _FavoriteListViewState extends State<FavoriteListView> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartManager>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(161, 255, 255, 255),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        title: const Text("Sản phẩm yêu thích"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartView()));
            },
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -12, end: -12),
              showBadge: true,
              ignorePointer: false,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartView()));
              },
              badgeContent: Text('${cartProvider.cartCount}'),
              badgeAnimation: const BadgeAnimation.scale(
                animationDuration: Duration(seconds: 1),
                colorChangeAnimationDuration: Duration(seconds: 1),
                loopAnimation: false,
                curve: Curves.fastOutSlowIn,
                colorChangeAnimationCurve: Curves.easeInCubic,
              ),
              badgeStyle: badges.BadgeStyle(
                badgeColor: Colors.deepOrange,
                borderRadius: BorderRadius.circular(4),
                elevation: 0,
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 28,
              ),
            ),
          ),
          const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.chat_outlined)),
        ],
      ),
      body: StreamBuilder(
        stream: ProductService.readProductFavorite(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Lỗi phát sinh");
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final product = snapshot.data!;
            return ListView(
              children: product.map(buidProduct).toList(),
            );
          } else {
            return const Center(
              child: Text("Tìm kiếm sản phẩm yêu thích ngay nào."),
            );
          }
        },
      ),
    );
  }

  Widget buidProduct(Product product) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: const BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetail(product)));
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.width / 3.5,
                  width: MediaQuery.of(context).size.width / 3.5,
                  child: Column(
                    children: [
                      Image.network(
                        product.productUrl[0],
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.width / 3.5,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Text(
                        product.productName,
                        maxLines: 1,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text('Có sẵn: ${product.quantity - product.sold}'),
                    Text(
                      '${MoneyFormatter(amount: product.price.toDouble()).output.withoutFractionDigits}đ',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        FirebaseFirestore.instance
                            .collection("favoritelist")
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection(FirebaseAuth.instance.currentUser!.email
                                .toString())
                            .doc(product.id)
                            .delete();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text("Đã bỏ thích sản phẩm"),
                          action: SnackBarAction(
                            label: "Hủy",
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection("favoritelist")
                                  .doc(FirebaseAuth.instance.currentUser!.email)
                                  .collection(FirebaseAuth
                                      .instance.currentUser!.email
                                      .toString())
                                  .doc(product.id)
                                  .set(product.toMap());
                            },
                          ),
                        ));
                      });
                    },
                    child: const Icon(
                      Icons.favorite_outlined,
                      size: 28,
                      color: Colors.pink,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
