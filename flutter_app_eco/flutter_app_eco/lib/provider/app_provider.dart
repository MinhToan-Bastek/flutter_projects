
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_eco/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:flutter_app_eco/firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:flutter_app_eco/models/user_model/user_model.dart';

import '../constants/constants.dart';
import '../models/product_model/product_model.dart';

class AppProvider with ChangeNotifier{
  //Giỏ hàng
  final List<ProductModel> _cartProductList = [];
  final List<ProductModel> _buyProductList = [];
  UserModel? _userModel;
  UserModel get  getUserInformation=> _userModel!;

  void addCartProduct(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }
  List<ProductModel> get getCartProductList => _cartProductList;

  //Danh sách yêu thích
  final List<ProductModel> _favouriteProductList = [];

  void addFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.add(productModel);
    notifyListeners();
  }

  void removeFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.remove(productModel);
    notifyListeners();
  }

   List<ProductModel> get getFavouriteProductList => _favouriteProductList;
  void getUserInfoFirebase() async {
   _userModel = await FirebaseFirestoreHelper.instance.getUserInformation();
   notifyListeners();
   }
  void updateUserInfoFirebase(
      BuildContext context, UserModel userModel, File? file) async {

    // ignore: unnecessary_null_comparison
    if (file == null) {
      showLoaderDialog(context);
      _userModel = userModel;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    } else {
     String imageUrl= await FirebaseStorageHelper.instance.uploadUserImage(file);
      _userModel = userModel.copyWith(image: imageUrl);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
     Navigator.of(context, rootNavigator: true).pop();
     Navigator.of(context).pop();

    }
    showMessage("Cập nhật thành công");
    // ignore: use_build_context_synchronously
    notifyListeners();
  }
// thanh toán
  double totalPrice() {
    double totalPrice = 0.0;
    for (var element in _cartProductList) {
      totalPrice += element.price * element.qty!;
    }
    return totalPrice;
  }

  double totalPriceBuyProductList() {
    double totalPrice = 0.0;
    for (var element in _buyProductList) {
      totalPrice += element.price * element.qty!;
    }
    return totalPrice;
  }

  void updateQty(ProductModel productModel, int qty) {
    int index = _cartProductList.indexOf(productModel);
    _cartProductList[index].qty = qty;
    notifyListeners();
  }

  //Mua hàng
  void addBuyProducts(ProductModel model) {
    _buyProductList.add(model);
    notifyListeners();
  }

  void addBuyProductsCartList() {
    _buyProductList.addAll(_cartProductList);
    notifyListeners();
  }

  void clearCart() {
    _cartProductList.clear();
    notifyListeners();
  }

  void clearBuyProduct() {
    _buyProductList.clear();
    notifyListeners();
  }

  List<ProductModel> get getBuyProductList => _buyProductList;


}