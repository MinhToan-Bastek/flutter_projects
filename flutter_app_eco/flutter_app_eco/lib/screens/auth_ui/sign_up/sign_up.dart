// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_eco/constants/routes.dart';
import 'package:flutter_app_eco/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:flutter_app_eco/screens/home/home.dart';
import 'package:flutter_app_eco/widgets/primary_button/primary_button.dart';
import 'package:flutter_app_eco/widgets/top_titles/top_titles.dart';

import '../../../constants/constants.dart';
import '../../../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
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
                controller: name,
                decoration: const InputDecoration(
                    hintText: "Tên đăng nhập",
                    prefixIcon: Icon(Icons.person_outline, )
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: "E-mail",
                    prefixIcon: Icon(Icons.email_outlined, )
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              TextFormField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    hintText: "Số điện thoại",
                    prefixIcon: Icon(Icons.phone_outlined, )
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              TextFormField(
                controller: password,
                obscureText: isShowPassWord,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock,
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
              PrimaryButton(title: "Đăng ký tài khoản",
                onPressed: ()async {
                  bool isVaildated = SignUpVaildation(email.text, password.text, name.text, phone.text);
                  if(isVaildated){
                    bool isLogined = await FirebaseAuthHelper.instance.SignUp(
                      name.text,
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
              const Center(child: Text("Đã có tài khoản?"),),
              const SizedBox(
                height: 12.0,
              ),
              Center(
                child: CupertinoButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("Đăng nhập",
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
