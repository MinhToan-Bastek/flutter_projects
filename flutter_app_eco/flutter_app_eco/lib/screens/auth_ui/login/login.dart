// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_eco/constants/constants.dart';
import 'package:flutter_app_eco/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:flutter_app_eco/screens/auth_ui/sign_up/sign_up.dart';
import 'package:flutter_app_eco/screens/home/home.dart';
import 'package:flutter_app_eco/widgets/primary_button/primary_button.dart';
import 'package:flutter_app_eco/widgets/top_titles/top_titles.dart';

import '../../../constants/routes.dart';
import '../../../custom_bottom_bar/custom_bottom_bar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isShowPassWord = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              const TopTitles(title: "Đăng nhập", subtitle: "Chào mừng đến với thế giới mua sắm"),
              const SizedBox(
                height: 46.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "E-mail",
                  prefixIcon: Icon(Icons.email_outlined, )
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              TextFormField(
                obscureText: isShowPassWord,
                decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.key,
                    ),
                  suffixIcon: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          isShowPassWord = !isShowPassWord;
                          print(isShowPassWord);
                        });
                      },
                      child: const Icon(Icons.visibility, color: Colors.grey,)),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              PrimaryButton(title: "Đăng nhập",
              onPressed: () async {
               bool isVaildated = loginVaildation(email.text, password.text);
               if(isVaildated){
                bool isLogined = await FirebaseAuthHelper.instance.Login(
                     email.text, password.text, context);
                if(isLogined){
                  Routes.instance.pushAndRemoveUntil(
                      widget: const CustomBottomBar(), context: context);
                }
               }
              },
              ),
              const SizedBox(
                height: 24.0,
              ),
              const Center(child: Text("Chưa có tài khoản?"),),
              const SizedBox(
                height: 12.0,
              ),
              Center(
                child: CupertinoButton(
                  onPressed: (){
                    Routes.instance.push(widget: const SignUp(), context: context);
                  },
                  child: Text("Tạo tài khoản mới",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor
                    ) ,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
