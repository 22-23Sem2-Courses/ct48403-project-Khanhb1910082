import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';

import 'package:myproject_app/service/product_service.dart';
import 'package:myproject_app/ui/product/product_detail.dart';

import '../../model/product.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool _isFavorite = false;
  final GlobalKey _productKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
        stream: ProductService.readProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.hasError.toString());
          } else if (snapshot.hasData) {
            final product = snapshot.data!;
            return GridView(
              padding: const EdgeInsets.only(top: 3),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 2 / 3.6,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: product.map(buidProduct).toList(),
            );
          } else {
            return const Center(
              child: Text("Sản phẩm hiện chưa được trưng bày"),
            );
          }
        });
  }

  Widget buidProduct(Product product) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetail(product)));
                },
                child: Image.network(product.productUrl[0],
                    height: 285, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Hot",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            _isFavorite = !_isFavorite;
                          });
                        },
                        child: Icon(
                            !_isFavorite
                                ? Icons.favorite_border
                                : Icons.favorite_sharp,
                            color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            alignment: Alignment.centerLeft,
            child: Text(
              product.productName.toString(),
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(
              height: 0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${MoneyFormatter(amount: product.price.toDouble()).output.withoutFractionDigits}đ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                Text(
                  'Đã bán ',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
