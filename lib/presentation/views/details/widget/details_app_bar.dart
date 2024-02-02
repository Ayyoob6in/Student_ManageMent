import 'package:flutter/material.dart';
import 'package:learn/presentation/views/home/widget/custom_textfield.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  CustomTextFielsWidget titile;
  VoidCallback? onPress;
  IconData? appBarLeadingIcon;
   CustomAppBar({
    super.key,
    required this.titile,
    this.onPress,
    this.appBarLeadingIcon
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurpleAccent[50],
      title:titile ,
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(onPressed: onPress,
         icon: Icon(appBarLeadingIcon,color: Colors.purple[200],size: 30,)
        ),
      ],
    
    );
  }
   
}
