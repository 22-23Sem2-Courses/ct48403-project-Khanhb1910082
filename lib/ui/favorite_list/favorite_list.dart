import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:myproject_app/model/product.dart';

import '../../service/product_service.dart';
import '../screen.dart';

class FavoriteListView extends StatefulWidget {
  const FavoriteListView({super.key});

  @override
  State<FavoriteListView> createState() => _FavoriteListViewState();
}

class _FavoriteListViewState extends State<FavoriteListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text("Sản phẩm yêu thích"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartView()));
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(
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
        stream: ProductService.readProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.hasError.toString());
          } else if (snapshot.hasData) {
            final product = snapshot.data!;
            return ListView(
              children: product.map(buidProduct).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
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
              SizedBox(
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
                    Text('Có sẵn: ${product.quantity.toString()}'),
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
                  const Icon(
                    Icons.favorite_border,
                    size: 28,
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
