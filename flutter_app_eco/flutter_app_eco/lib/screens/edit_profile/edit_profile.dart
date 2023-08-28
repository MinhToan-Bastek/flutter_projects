import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_eco/constants/constants.dart';
import 'package:flutter_app_eco/firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:flutter_app_eco/models/user_model/user_model.dart';
import 'package:flutter_app_eco/provider/app_provider.dart';
import 'package:flutter_app_eco/widgets/primary_button/primary_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;
  void takePicture()async{
   XFile? value = await ImagePicker().pickImage(source: ImageSource.gallery);
   if(value != null){
     setState(() {
       image = File(value.path);
     });
   }
  }
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context,);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Profile", style: TextStyle(color: Colors.black),),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          image == null? CupertinoButton(
            onPressed: () {
              takePicture();
            },
            child: CircleAvatar(
                radius: 70, child: Icon(Icons.camera_alt)),
          )
              : CupertinoButton(
            onPressed: () {
              takePicture();
            },
            child: CircleAvatar(
              radius: 70,
              backgroundImage: FileImage(image!),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: "ten",
            ),
          ),
          const SizedBox(height: 25.0,),
          PrimaryButton(title: "Cập nhật",
            onPressed: () async {
            UserModel userModel = appProvider.getUserInformation.copyWith(name: textEditingController.text);
            appProvider.updateUserInfoFirebase(context, userModel, image!);
            // showMessage("Cập nhật thành công");
            },
          ),
        ],
      ),
    );
  }
}
