import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopTitles extends StatelessWidget {
  final String title, subtitle;
  const TopTitles({Key? key, required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: kToolbarHeight +12,
        ),
         if(title =="Đăng nhập" || title == "Tạo tài khoản")
           GestureDetector(
             onTap: (){
               Navigator.of(context).pop();
             },
             child: const Icon(Icons.arrow_back_ios),
           ),
         const SizedBox(
           height: 12.0,
         ),
         Text(title, style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),),
        const SizedBox(
          height: 12,
        ),
        Text(subtitle,
          style: TextStyle(
              fontSize: 20.0
          ),
        ),
      ],
    );
  }
}
