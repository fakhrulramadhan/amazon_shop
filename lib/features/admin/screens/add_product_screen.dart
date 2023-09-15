import 'dart:io';

import 'package:amazon_shop/common/widgets/custom_button.dart';
import 'package:amazon_shop/common/widgets/custom_textfield.dart';
import 'package:amazon_shop/constants/global_variables.dart';
import 'package:amazon_shop/constants/utils.dart';
import 'package:amazon_shop/data/services/admin_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "/add-product";
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String category = 'Mobiles';
  List<File> images = []; //kasih nilai list kosong
  final _addProductFormKey = GlobalKey<FormState>();

  // final ImagePicker imagePicker = ImagePicker();
  // List<XFile>? imageFileList = [];

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminService adminService = AdminService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'fashion'
  ];

  // void selectImages() async {
  //   var res = await pickImages();
  //   setState(() {
  //     images = res;
  //   });
  // }

  void gainImages() async {
    var res = await pickPhotos(); //bikin fungsi dulu di services
    setState(() {
      images = res;
    });
  }

  void sellProduct() async {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminService.sellProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text), //string ke double
          quantity: double.parse(quantityController.text),
          category: category,
          images: images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(52), //tingginya 52
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: const Text(
            "Add Product",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          leading: const BackButton(),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
              key: _addProductFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    images.isNotEmpty
                        ? CarouselSlider(
                            //harus image.file, karena images tipenya file
                            items: images.map((i) {
                              return Builder(
                                builder: (BuildContext context) => Image.file(
                                  i,
                                  fit: BoxFit.cover,
                                  height: 200,
                                ),
                              );
                            }).toList(),
                            options: CarouselOptions(
                                viewportFraction: 1, height: 200))
                        : GestureDetector(
                            onTap: gainImages,
                            child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(10),
                                dashPattern: const [10, 4],
                                strokeCap: StrokeCap.round,
                                child: Container(
                                  width: double.infinity,
                                  height: 148,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.folder_open_outlined,
                                        size: 30.0,
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "Select Product Images",
                                        style: TextStyle(
                                          fontSize: 17.0,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    CustomTextField(
                        controller: productNameController,
                        hintText: "Product Name"),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomTextField(
                      controller: descriptionController,
                      hintText: "Description",
                      maxLines: 8,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomTextField(
                        controller: priceController, hintText: "Price"),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomTextField(
                        controller: quantityController, hintText: "Quantity"),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButton(
                        items: productCategories.map((String item) {
                          return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ));
                        }).toList(),
                        onChanged: (String? newValue) {
                          //category sekarang diganti sama newvalue
                          //yang dipilih
                          category = newValue!;
                          setState(() {}); //update UI
                        },
                        value: category, //nilai awalnya category
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          size: 24.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomButton(
                      text: "Sell",
                      onTap: () {
                        sellProduct();
                      },
                    )
                  ],
                ),
              ))),
    );
  }
}
