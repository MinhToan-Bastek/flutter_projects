import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_eco/constants/constants.dart';
import 'package:flutter_app_eco/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';

import '../../widgets/primary_button/primary_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isShowPassWord = true;
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Đổi mật khẩu", style: TextStyle(color: Colors.black),),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          TextFormField(
            controller: newpassword,
            obscureText: isShowPassWord,
            decoration: InputDecoration(
              hintText: "Mật khẩu mới",
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
          SizedBox(
            height: 24.0,
          ),
          TextFormField(
            controller: confirmpassword,
            obscureText: isShowPassWord,
            decoration: InputDecoration(
              hintText: "Xác nhận mật khẩu",
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
          SizedBox(height: 36,),
          PrimaryButton(title: "Cập nhật",
            onPressed: () async {
            if(newpassword.text.isEmpty){
              showMessage("Mật khẩu không được để trống");
            }else if(confirmpassword.text.isEmpty){
                showMessage("Xác nhận mật khẩu không được trống");}
            else if(confirmpassword.text == newpassword.text){
              FirebaseAuthHelper.instance.changePassword(newpassword.text, context);
            }
              else{
              showMessage("Cập nhật mật khẩu thất bại");
              }

            },
          ),
        ],
      ),
    );
  }
}
