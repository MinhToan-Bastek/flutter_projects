import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_eco/constants/routes.dart';
import 'package:flutter_app_eco/models/product_model/product_model.dart';
import 'package:flutter_app_eco/screens/buy_product/buy_product.dart';
import 'package:flutter_app_eco/screens/cart_screen/widgets/single_cart_item.dart';
import 'package:flutter_app_eco/widgets/primary_button/primary_button.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class CartScreen extends StatefulWidget {

  const CartScreen({Key? key, }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 180,
        child: Padding(
          padding:const  EdgeInsets.all(12.0),
          child: Column(
            children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text("Tổng thanh toán", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                  Text("\$${appProvider.totalPrice().toString()}",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  )
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              PrimaryButton(title: "Thanh toán",
                onPressed: (){
                // Routes.instance.push(widget: const Checkout(), context: context);
                },
              ),
            ],
          ),
        ),
      ),


      appBar: AppBar(
        centerTitle: true,
        title: const Text("Giỏ hàng",
        style: TextStyle(
          color: Colors.black
        ),
        ),
      ),
      body: appProvider.getCartProductList.isEmpty?Center(child: Text("Giỏ hàng trống"),)
      :ListView.builder(
        itemCount: appProvider.getCartProductList.length,
          padding: const EdgeInsets.all(12.0),
          itemBuilder: (ctx, index){
          return SingleCartItem(
            singleProduct: appProvider.getCartProductList[index],
          );
          }
      ),
    );
  }
}
