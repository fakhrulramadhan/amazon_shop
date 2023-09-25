import 'package:amazon_shop/data/model/product.dart';
import 'package:amazon_shop/data/services/product_details_service.dart';
import 'package:amazon_shop/data/services/cart_service.dart';
import 'package:amazon_shop/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index; //utk kasih id index di masing2 produk
  const CartProduct({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsService productDetailsService = ProductDetailsService();
  final CartService cartServices = CartService();
  //fungsi tambah qty
  void increaseQty(Product product) {
    productDetailsService.addToCart(context: context, product: product);
  }

  void decreaseQty(Product product) {
    cartServices.removeToCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    //product (menampilkan data per produk)
    final productCart = context.watch<UserProvider>().user.cart[widget.index];

    final product = Product.fromMap(productCart['product']); //konvert ke json
    // {'product': {}, quantity}

    final quantity = productCart['quantity'];
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                width: 130.0,
                height: 130.0,
                fit: BoxFit.contain,
              ),
              //ecpanded utk ngerapihin layout
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        "\$${product.price}",
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: const Text(
                        "Eligible For Free Delivery",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.normal),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: const Text(
                        "In Stock",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.teal),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 1.5),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        decreaseQty(product);
                      },
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.remove,
                          size: 24.0,
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1.5),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0)),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Text(
                          "$quantity",
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        increaseQty(product);
                      },
                      hoverColor: Colors.yellow,
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add,
                          size: 24.0,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
