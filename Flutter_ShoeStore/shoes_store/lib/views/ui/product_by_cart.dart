import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../models/sneaker_model.dart';
import '../../services/helper.dart';
import '../shared/appstyle.dart';
import '../shared/category_btn.dart';
import '../shared/custom_spacer.dart';
import '../shared/latest_shoes.dart';
import '../shared/stagger_tile.dart';

class ProductByCart extends StatefulWidget {
  const ProductByCart({Key? key, required this.tabIndex}) : super(key: key);
  final int tabIndex;

  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart>
    with TickerProviderStateMixin {
  late final TabController _tabController =
  TabController(length: 3, vsync: this);
  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _female;
  late Future<List<Sneakers>> _kids;

  void getMale() {
    _male = Helper().getMaleSneakers();
  }

  void getFemale() {
    _female = Helper().getFemaleSneakers();
  }

  void getkids() {
    _kids = Helper().getKidsSneakers();
  }

  @override
  void initState() {
    super.initState();
    getMale();
    getkids();
    getFemale();
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<String> brand = [
    "assets/images/adidas.png",
    "assets/images/gucci.png",
    "assets/images/jordan.png",
    "assets/images/nike.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
        padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
        height: MediaQuery.of(context).size.height*0.4,
        decoration: const BoxDecoration(

            image: DecorationImage(image: AssetImage("assets/images/top_image.png"),
                fit: BoxFit.fill
            )
        ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                        padding: EdgeInsets.fromLTRB(6, 12, 6, 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(AntDesign.close, color: Colors.white,),
                          ),
                          GestureDetector(
                            onTap: (){
                              filter();
                            },
                            child: Icon(FontAwesome.sliders, color: Colors.white,),
                          ),

                        ],
                    ),
                  ),
                  TabBar(
                      padding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.transparent,
                      controller: _tabController ,
                      isScrollable: true,
                      labelColor: Colors.white,
                      labelStyle: appStyle(24, Colors.white, FontWeight.bold),
                      unselectedLabelColor: Colors.grey.withOpacity(0.3),
                      tabs:
                      const [
                        Tab(text: "Giày Nam",),
                        Tab(text: "Giày Nữ",),
                        Tab(text: "Giày Trẻ Em",),
                      ]
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2,
                left: 16,
                right: 12,
              ),

              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: TabBarView(
                    controller: _tabController,
                    children: [
                      maleLatest(male: _male),
                      maleLatest(male: _female),
                      maleLatest(male: _kids),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future<dynamic> filter(){
    double _value = 100;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white54,
        builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.84,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 5,
                width: 40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black38,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  children: [
                    const CustomSpacer(),
                    Text(
                      "Lọc",
                      style: appStyle(40, Colors.black, FontWeight.bold),
                    ),
                    const CustomSpacer(),
                    Text(
                      "Giới tính",
                      style: appStyle(20, Colors.black, FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        CategoryBtn(
                          label: "Nam",
                          buttonClr: Colors.black,
                        ),
                        CategoryBtn(
                          label: "Nữ",
                          buttonClr: Colors.grey,
                        ),
                        CategoryBtn(
                          label: "Trẻ em",
                          buttonClr: Colors.grey,
                        ),
                      ],
                    ),
                    const CustomSpacer(),
                    Text(
                      "Category",
                      style: appStyle(20, Colors.black, FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        CategoryBtn(
                          label: "Shoes",
                          buttonClr: Colors.black,
                        ),
                        CategoryBtn(
                          label: "Apparrels",
                          buttonClr: Colors.grey,
                        ),
                        CategoryBtn(
                          label: "Accessories",
                          buttonClr: Colors.grey,
                        ),
                      ],
                    ),
                    const CustomSpacer(),
                    Text(
                      "Price",
                      style: appStyle(20, Colors.black, FontWeight.bold),
                    ),
                    const CustomSpacer(),
                    Slider(
                        value: _value,
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey,
                        thumbColor: Colors.black,
                        max: 500,
                        divisions: 50,
                        label: _value.toString(),
                        secondaryTrackValue: 200,
                        onChanged: (double value) {}),
                    CustomSpacer(),
                    Text(
                      "Brand",
                      style: appStyle(20, Colors.black, FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 80,
                      child: ListView.builder(
                          itemCount: brand.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12))),
                                child: Image.asset(
                                  brand[index],
                                  height: 60,
                                  width: 80,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }),
                    )

                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}

