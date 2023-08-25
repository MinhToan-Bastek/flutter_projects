import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shoes_store/controllers/product_provider.dart';

import '../../models/sneaker_model.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: FutureBuilder<List<Sneakers>>(
        future: _male,
        builder: (context, snapshot)
    {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text("Error ${snapshot.error}");
      } else {
        final male = snapshot.data;
        return Consumer<ProductNotifier>(
          builder: (context, productNotifier, child) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  leadingWidth: 0,
                  title: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: null,
                          child: const Icon(AntDesign.close, color: Colors
                              .black,),

                        ),
                        GestureDetector(
                          onTap: null,
                          child: const Icon(Ionicons.ellipsis_horizontal,
                            color: Colors.black,),

                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                  snap: false,
                  floating: true,
                  backgroundColor: Colors.transparent,
                  expandedHeight: MediaQuery
                      .of(context)
                      .size
                      .height,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        SizedBox(
                          height:
                          MediaQuery
                              .of(context)
                              .size
                              .height * 0.5,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              controller: pageController,
                              onPageChanged: (page) {
                                productNotifier.activePage = page;
                              },
                              itemBuilder: (context, int index) {
                                return Stack(
                                  children: [
                                    Container(
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.39,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      color: Colors.grey.shade300,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        // sneaker.imageUrl[index],
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Positioned(
                                        top: MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.1,
                                        right: 20,
                                        child: const Icon(
                                          AntDesign.hearto,
                                          color: Colors.grey,
                                        )),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.3,
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: List<Widget>.generate(
                                                length, (index) =>
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 4),
                                                  child: CircleAvatar(
                                                    radius: 5,
                                                    backgroundColor: productNotifier
                                                        .activepage !=
                                                        index
                                                        ? Colors
                                                        .grey
                                                        : Colors
                                                        .black,
                                                  ),
                                                ))
                                        )
                                    )

                                  ],
                                );
                              }
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );

          },
        );
      }
    }
    ),
    );
}
}
