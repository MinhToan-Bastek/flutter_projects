import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../controllers/mainscreen_provider.dart';
import 'bottom_nav_widget.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, MainScreenNotifier, child){
        return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BotomNavWidget(
                      onTap: () {
                        MainScreenNotifier.pageIndex = 0;
                      },
                      icon: MainScreenNotifier.pageIndex == 0
                          ? Ionicons.home
                          :Ionicons.home_outline,
                    ),
                    BotomNavWidget(
                      onTap: () {
                        MainScreenNotifier.pageIndex = 1;
                      },
                      icon: MainScreenNotifier.pageIndex == 1
                          ? Ionicons.search
                          :Ionicons.search,
                    ),
                    BotomNavWidget(
                      onTap: () {
                        MainScreenNotifier.pageIndex = 2;
                      },
                      icon: MainScreenNotifier.pageIndex == 2
                          ? Ionicons.add_circle_outline
                          :Ionicons.add,
                    ),
                    BotomNavWidget(onTap: () {
                      MainScreenNotifier.pageIndex = 3;
                    },
                      icon: MainScreenNotifier.pageIndex == 3
                          ? Ionicons.cart
                          :Ionicons.cart_outline,
                    ),
                    BotomNavWidget(
                      onTap: () {
                        MainScreenNotifier.pageIndex = 4;
                      },
                      icon: MainScreenNotifier.pageIndex == 4
                          ? Ionicons.person
                          :Ionicons.person_outline,
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}