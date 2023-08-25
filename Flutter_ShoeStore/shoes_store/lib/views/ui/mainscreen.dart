import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_store/controllers/mainscreen_provider.dart';
import 'package:shoes_store/views/ui/cartpage.dart';
import 'package:shoes_store/views/ui/homepage.dart';
import 'package:shoes_store/views/ui/product_by_cart.dart';
import 'package:shoes_store/views/ui/profile.dart';
import 'package:shoes_store/views/ui/searchpage.dart';
import '../shared/appstyle.dart';
import '../shared/bottom_nav.dart';
import '../shared/bottom_nav_widget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  List<Widget> pageList = const [
    HomePage(),
    SearchPage(),
    HomePage(),
    CartPage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {

    return Consumer<MainScreenNotifier>(
        builder: (context, MainScreenNotifier, child){
    return Scaffold(
    backgroundColor: const Color(0xFFE2E2E2),

    body: pageList[MainScreenNotifier.pageIndex],

    bottomNavigationBar: const BottomNavBar(),

    );
    },
    );
  }
}


