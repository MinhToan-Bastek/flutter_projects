import 'package:flutter/material.dart';
import 'package:flutter_app_eco/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:flutter_app_eco/models/product_model/product_model.dart';
import 'package:flutter_app_eco/provider/app_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../custom_bottom_bar/custom_bottom_bar.dart';
import '../../widgets/primary_button/primary_button.dart';

class Checkout extends StatefulWidget {
  final ProductModel singleProduct;
  const Checkout({Key? key, required this.singleProduct,  }) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int groupValue = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      // bottomNavigationBar: SizedBox(
      //   height: 180,
      //   child: Padding(
      //     padding:const  EdgeInsets.all(12.0),
      //     child: Column(
      //       children: [
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children:  [
      //             Text("Tổng thanh toán", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
      //             Text("\$${appProvider.totalPrice().toString()}",
      //               style: TextStyle(
      //                 fontSize: 18.0,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             )
      //           ],
      //         ),
      //         const SizedBox(
      //           height: 24.0,
      //         ),
      //         PrimaryButton(title: "Thanh toán",
      //           onPressed: (){
      //
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),



      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Thanh Toán", style: TextStyle(color: Colors.black),),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 36,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border:
                Border.all(color: Theme.of(context).primaryColor, width: 2),
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                      value: 1,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      }),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Thanh toán trực tiếp",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border:
                Border.all(color: Theme.of(context).primaryColor, width: 2),
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                      value: 2,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      }),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Thanh toán online",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24,),




            PrimaryButton(
              title: "Tiếp tục",
              onPressed: () async {
                appProvider.clearBuyProduct();
                appProvider.addBuyProducts(widget.singleProduct);
                bool value = await FirebaseFirestoreHelper.instance
                    .uploadOrderedProductFirebase(
                    appProvider.getBuyProductList,
                    context,
                    groupValue == 1 ? "Thanh toán trực tiếp" : "Đã trả");
                if (value) {
                  Future.delayed(Duration(seconds: 2), () {
                    Routes.instance
                        .push(widget: CustomBottomBar(), context: context);
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
