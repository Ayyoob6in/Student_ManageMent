


import 'package:flutter/material.dart';
import 'package:learn/constants/constants.dart';
import 'package:learn/presentation/views/home/widget/custom_textfield.dart';
const String  dummy= "https://images.pexels.com/photos/20037843/pexels-photo-20037843/free-photo-of-compania.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2";
class CustomDilog{

   final bool readOnly;
   final String option;
   final TextEditingController nameController;
   final TextEditingController ageController;
   final TextEditingController departController;
   final TextEditingController rollController;
   final TextEditingController phoneController;
   final VoidCallback onPress;
   

  CustomDilog({
     this.readOnly = false,
     required this.option,
     required this. nameController,
     required this.ageController,
     required this.departController,
     required this.phoneController,
     required this.rollController,
     required this.onPress
     });

  
  showEditDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Add your editable fields here, e.g., TextFields
                CustomTextFielsWidget(
                  readOnly: readOnly,
                  hint: 'Name',
                  fieldIcon: Icons.person,
                  controller: nameController, // Use appropriate controller
                ),
                sheight10,
                CustomTextFielsWidget(
                  readOnly:readOnly ,
                  hint: 'Age',
                  fieldIcon: Icons.lock_person_sharp,
                  controller: ageController,
                ),
                sheight10,
                CustomTextFielsWidget(
                  readOnly:readOnly ,
                  hint: 'Department',
                  fieldIcon: Icons.assignment_add,
                  controller:departController,
                ),
                sheight10,
                CustomTextFielsWidget(
                  readOnly:readOnly ,
                  hint: 'Roll Number',
                  fieldIcon: Icons.format_list_bulleted,
                  controller: rollController,
                ),
                sheight10,
                CustomTextFielsWidget(
                  readOnly:readOnly ,
                  hint: 'Phone',
                  fieldIcon: Icons.phone,
                  controller: phoneController,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Add your logic to save the edited details
                Navigator.of(context).pop(); // Close the dialog
              },
              child:Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                TextButton(
                  onPressed: (){
                  Navigator.of(context).pop();
                },
                 child: const Text("Cancel")),
                TextButton(
                  onPressed:onPress,
                  child:  Text(option)),
              ],
                
              )
            ),
          ],
        );
      },
    );
  }
 
}
