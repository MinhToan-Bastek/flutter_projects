import 'package:flutter/material.dart';
import 'package:flutter_app_eco/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:flutter_app_eco/models/category_model/category_model.dart';
import 'package:flutter_app_eco/widgets/top_titles/top_titles.dart';

import '../../constants/routes.dart';
import '../../models/product_model/product_model.dart';
import '../product_details/product_details.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryView({Key? key, required this.categoryModel}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  void getCategoryList()async{
    setState(() {
      isLoading = true;
    });
    //FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    productModelList = await FirebaseFirestoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.id);
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {
    getCategoryList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading?Center(child: Container(
        height: 100,
        width: 100,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
      )
          :SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: kToolbarHeight *1,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    const BackButton(),
                    Center(
                      child: Text(
                        widget.categoryModel.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),

            productModelList.isEmpty?Center(child: Text("Best products is empty"),):
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: productModelList.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.7,
                      crossAxisCount: 2),
                  itemBuilder:(ctx, index){
                    ProductModel singleProduct = productModelList[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 12.0,
                          ),
                          Image.network(singleProduct.image,
                            height: 100,
                            width: 100,
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Text
                            (
                            singleProduct.name  ,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Price: \$${singleProduct.price}"),
                          const SizedBox(height: 30.0,),
                          SizedBox(
                            height: 35,
                            width: 140,
                            child: OutlinedButton(
                              onPressed: (){
                                Routes.instance.push(widget: ProductDetails(singleProduct: singleProduct), context: context);
                              },

                              child: const Text(
                                "Mua",

                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              ),
            ),
            const SizedBox(height: 12.0,
            ),
        ],
      ),
          ),
    );
  }
}
