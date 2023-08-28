import 'package:flutter/material.dart';
import 'package:flutter_app_eco/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';

import '../../models/order_model/order_model.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Đơn hàng của bạn", style: TextStyle(color: Colors.black),),
        ),
      body: FutureBuilder(
          future: FirebaseFirestoreHelper.instance.getUserOrder(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            if(snapshot.data!.isEmpty || snapshot.data == null || !snapshot.hasData)
            {
              return Center(child: Text("Không có đơn hàng nào"),);
            }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index){
                OrderModel orderModel=  snapshot.data![index];
                  return ExpansionTile(title:
                  Text(
                    orderModel.payment,
                    style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500),
                  ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          orderModel.status,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  );
            }
              );
          }
          ),
    );
  }
}
