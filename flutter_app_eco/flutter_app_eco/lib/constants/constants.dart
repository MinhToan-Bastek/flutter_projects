
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message){
  Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
}
showLoaderDialog(BuildContext context){
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context){
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min ,
          children: [
            const CircularProgressIndicator(
              color: Color(0xffe16555),
            ),
            const SizedBox(
              height: 18,
            ),
            Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Đang tải..."),
            )
          ],
        ),
      );
    }

    ),
  );
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return alert;
      },
  );
}
String getMessageFromErrorCode(String errorCode){
  switch (errorCode){
    case "User_NOT_Found":
      return "User not found";
    case "ERROR_EMAIL_ALREADY_IN_USE":
    return "Email already used. go to login page";
    case "ERROR_USER_NOT_FOUND":
      return "No user found with this email";
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "Email already used. go to login page";
    case "ERROR_INVALID-EMAIL":
      return "Email address is invalid";
    case "invalid-email":
      return "Email address is invalid";
    default:
      return "Login failed.";
  }
}

bool loginVaildation(String email, String password){
  if (email.isEmpty && password.isEmpty){
    showMessage("Không được để trống");
    return false;
  } else if (email.isEmpty){
    showMessage("Email không được trống");
    return false;
  }
  else if (password.isEmpty){
    showMessage("Password không được trống");
    return false;
  } else{
    return true;
  }
}

bool SignUpVaildation(String email, String password, String name, String phone){
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty){
    showMessage("Không được để trống");
    return false;
  }else if (name.isEmpty){
    showMessage("Name không được trống");
    return false;
  }
  else if (email.isEmpty){
    showMessage("Email không được trống");
    return false;
  }
  else if (phone.isEmpty){
    showMessage("Phone không được trống");
    return false;
  }
  else if (password.isEmpty){
    showMessage("Password không được trống");
    return false;
  }
  else{
    return true;
  }
}
