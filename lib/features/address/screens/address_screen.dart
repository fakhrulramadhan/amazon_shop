import 'package:amazon_shop/common/widgets/custom_textfield.dart';
import 'package:amazon_shop/constants/global_variables.dart';
import 'package:amazon_shop/features/search/screens/search_screen.dart';
import 'package:amazon_shop/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "/address";
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final addressFormKey = GlobalKey<FormState>();

  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  List<PaymentItem> paymentItems = [];

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void onApplePayResult(res) {}

  void onGooglePayeResult(res) {}

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  //prefsize agar bisa diatur posisi appbarnya
  @override
  Widget build(BuildContext context) {
    // memantau alamat user yang login did atabase
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), //tinggi appbar 60
        //posisi appbar flexible
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Form(
                  key: addressFormKey,
                  child: Column(
                    children: [
                      // jika halaman nya ada, muncul alamat user di container
                      if (address.isNotEmpty)
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Colors.black12,
                              )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  address,
                                  style: const TextStyle(
                                    fontSize: 17.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            const Text(
                              "OR",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      CustomTextField(
                        controller: flatBuildingController,
                        hintText: "Flat, House no, Building",
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      CustomTextField(
                        controller: areaController,
                        hintText: "Area Street",
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      CustomTextField(
                        controller: pincodeController,
                        hintText: "Pincode",
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      CustomTextField(
                        controller: cityController,
                        hintText: "Town / Cities",
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  )),
              //hanya muncul di Ios
              ApplePayButton(
                onPaymentResult: onApplePayResult,
                paymentItems: paymentItems,
                paymentConfigurationAsset: "appplepay.json",
                width: double.infinity,
                style: ApplePayButtonStyle.whiteOutline,
                type: ApplePayButtonType.buy,
                height: 50,
                margin: const EdgeInsets.only(top: 15),
              ),
              const SizedBox(
                height: 15.0,
              ),
              GooglePayButton(
                onPaymentResult: onGooglePayeResult,
                paymentItems: paymentItems,
                paymentConfigurationAsset: "gpay.json.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
