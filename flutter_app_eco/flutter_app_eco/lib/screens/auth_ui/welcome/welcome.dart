import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_eco/constants/asset_images.dart';
import 'package:flutter_app_eco/screens/auth_ui/login/login.dart';
import 'package:flutter_app_eco/screens/auth_ui/sign_up/sign_up.dart';
import 'package:flutter_app_eco/widgets/top_titles/top_titles.dart';

import '../../../constants/routes.dart';
import '../../../widgets/primary_button/primary_button.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopTitles(
                title: "Welcome",
                subtitle: "Mua sắm theo ý thích của bạn"),
            SizedBox(height: 40,),
            Center(
              child: Image.asset(
                  AssetsImages.instance.welcomeImage,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  onPressed: (){},
                  padding: EdgeInsets.zero,
                  child: const Icon(Icons.facebook,
                    size: 45,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                CupertinoButton(
                  onPressed: (){},
                  padding: EdgeInsets.zero,
                  child: const Icon(Icons.apple,
                    size: 45,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0,),
            PrimaryButton(
              title: "Đăng nhập",
              onPressed: (){
                Routes.instance.push(widget: const Login(), context: context);
              },),
            const SizedBox(height: 18.0,),
            PrimaryButton(
              title: "Đăng ký",
              onPressed: (){
                Routes.instance.push(widget: const SignUp(), context: context);
              },),
          ],
        ),
      ),
    );
  }
}
