
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppBarWidget extends StatelessWidget {
  String titile;
  VoidCallback? onPress;
  IconData? appBarLeadingIcon;
   AppBarWidget({
    super.key,
    required this.titile,
    this.onPress,
    this.appBarLeadingIcon
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurpleAccent[50],
      title: Text(titile,),
      titleTextStyle: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w500),
      centerTitle: true,
      automaticallyImplyLeading: false,
      
      actions: [
        IconButton(onPressed: onPress,
         icon: Icon(appBarLeadingIcon,color: Colors.black,)
        ),
      ],
    
    );
  }
   
}

