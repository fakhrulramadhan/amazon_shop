import 'package:amazon_shop/common/widgets/loader.dart';
import 'package:amazon_shop/constants/utils.dart';
import 'package:amazon_shop/data/model/product.dart';
import 'package:amazon_shop/features/account/widgets/single_product.dart';
import 'package:amazon_shop/features/admin/screens/add_product_screen.dart';
import 'package:flutter/material.dart';
import '../../../data/services/admin_service.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  final AdminService adminService = AdminService();
  void navigateToAddProduct() {
    Navigator.pushNamed(
      context,
      AddProductScreen.routeName,
    );
  }

  //pertama kali dijalankan
  @override
  void initState() {
    super.initState();

    gainAllProducts(); //enggak
  }

  void gainAllProducts() async {
    products =
        await AdminService().getAllProducts(context); //dapatin data product

    setState(() {}); //update UI
  }

  void deleteProduct(Product product, int index) {
    adminService.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index); //hapus produk sesuai id indexnya
        setState(() {}); //update UI
        showSnackBar(context, "Product Successfully deleted");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(products);
    return products == null
        ? const Loader()
        : Scaffold(
            // appBar: AppBar(
            //   title: const Text("Dashboard"),
            //   actions: const [],
            // ),
            body: GridView.builder(
              itemCount: products!.length,
              //setiap baris ada 2 produk
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                //sudah dipecah menjadi data per produk
                final productData = products![index];
                return Column(
                  children: [
                    SizedBox(
                      height: 120,
                      //images[0] artinya tampilkan gambar yang pertamanya aja
                      child: SingleProduct(image: productData.images[0]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            productData.name,
                            style: const TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w400),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteProduct(productData, index);
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                            size: 24.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                //
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddProductScreen()),
                );
              },
              tooltip: "Add A Product",
              child: const Icon(Icons.add), //hint text
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
