import 'package:flutter/material.dart';
import 'package:flutter_app_eco/constants/routes.dart';
import 'package:flutter_app_eco/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:flutter_app_eco/screens/change_password/change_password.dart';
import 'package:flutter_app_eco/screens/edit_profile/edit_profile.dart';
import 'package:flutter_app_eco/widgets/primary_button/primary_button.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import '../favourite_screen/favourite_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context,);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Tài khoản", style: TextStyle(
          color: Colors.black,
        ),),
      ),
      body: Column(
        children: [
          Expanded(child: Column(
            children: [
              const Icon(Icons.person_outline, size: 120,),

              Text(
                "Toan",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "Toan@gmail.com" ,
              ),
               const SizedBox(height: 12.0,),
              SizedBox(

                width: 130,
                child: PrimaryButton(title: "Chỉnh sửa",
                onPressed: () {
                  Routes.instance.push(widget: EditProfile(), context: context);
                },
                ),
              )
            ],
          )),
          Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  children: [
                    ListTile(
                      onTap: (){},
                      leading: Icon(Icons.shopping_bag_outlined),
                      title: Text("Đơn hàng của bạn"),
                    ),
                    ListTile(
                      onTap: (){
                        Routes.instance.push(widget: const FavouriteScreen(), context: context);
                      },
                      leading: Icon(Icons.favorite_outline),
                      title: Text("Danh sách yêu thích"),
                    ),
                    ListTile(
                      onTap: (){},
                      leading: Icon(Icons.info_outline),
                      title: Text("Thông tin cửa hàng"),
                    ),
                    ListTile(
                      onTap: (){},
                      leading: Icon(Icons.support_agent_outlined),
                      title: Text("Hỗ trợ"),
                    ),
                    ListTile(
                      onTap: (){
                        Routes.instance.push(widget: const ChangePassword(), context: context);
                      },
                      leading: Icon(Icons.key_outlined),
                      title: Text("Đổi mật khẩu"),
                    ),
                    ListTile(
                      onTap: (){
                        FirebaseAuthHelper.instance.signOut();
                        setState(() {

                        });
                      },
                      leading: Icon(Icons.logout),
                      title: Text("Đăng xuất"),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text("Version 1.0.0")
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
