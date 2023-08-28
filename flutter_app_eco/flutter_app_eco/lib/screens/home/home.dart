import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_eco/constants/routes.dart';
import 'package:flutter_app_eco/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:flutter_app_eco/provider/app_provider.dart';
import 'package:flutter_app_eco/screens/category_view/category_view.dart';
import 'package:flutter_app_eco/screens/product_details/product_details.dart';
import 'package:flutter_app_eco/widgets/top_titles/top_titles.dart';
import 'package:provider/provider.dart';

import '../../models/category_model/category_model.dart';
import '../../models/product_model/product_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categoriesList= [];
  List<ProductModel> productModelList = [];
  bool isLoading = false;
  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getCategoryList();
    super.initState();
  }
  void getCategoryList()async{
    setState(() {
      isLoading = true;
    });
    //FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getbestProducts();


    productModelList.shuffle();

      isLoading = false;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:isLoading?Center(child: Container(
        height: 100,
        width: 100,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
      )
      :SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopTitles(title: "Siêu thị của mọi nhà", subtitle: ""),
                  TextFormField(
                    decoration: const InputDecoration(hintText: "Search..."),
                  ),
                 const SizedBox(
                   height: 24.0,
                 ),
                 const Text("Sản phẩm của Ecoken",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),


         categoriesList.isEmpty?Center(child: Text("Categories is empty"),):
         SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categoriesList
                .map(
            (e) => Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: (){
                    Routes.instance.push(widget: CategoryView(categoryModel: e), context: context);
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child:

                      Image.network(e.image),
                      ),
                    ),
                ),
                ),
              ).toList(),
            ),
          ),
            const SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0,left: 12.0),
              child: const Text("Mua nhiều nhất",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            productModelList.isEmpty?Center(child: Text("Best products is empty"),):
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 50),
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



