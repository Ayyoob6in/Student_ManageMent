

// ignore_for_file: body_might_complete_normally_nullable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn/constants/constants.dart';
import 'package:learn/data/model/student_model.dart';
import 'package:learn/domain/api/apiservice.dart';
import 'package:learn/presentation/controller/detail_controller.dart';
import 'package:learn/presentation/controller/home_cotroller.dart';
import 'package:learn/presentation/views/details/details.dart';
import 'package:learn/presentation/views/home/widget/custom_textfield.dart';
import 'package:learn/presentation/widgets/app_bar.dart';
import 'package:learn/presentation/widgets/image_picker.dart';
import 'package:image/image.dart' as img ;


// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
   MyHomePage({super.key,});

   final controller = Get.put(HomeImagePicker());
   final imagePickerController = Get.put(ImagePickerController());
  DetailsController dcontroller = Get.find<DetailsController>();

   final TextEditingController nameController = TextEditingController();
   final TextEditingController ageController = TextEditingController();
   final TextEditingController departMentController = TextEditingController();
   final TextEditingController rollNumberController = TextEditingController();
   final TextEditingController phonenumberController = TextEditingController();
   final GlobalKey <FormState>_formkey = GlobalKey<FormState>();
   File? pickedImage;
   String patttern = r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)';

  
  @override
  Widget build(BuildContext context) {
    
    return   Scaffold(
      appBar: PreferredSize(
        preferredSize:const Size(double.infinity, 50), child: AppBarWidget(
        titile: "Home",
        onPress: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ScreenDisplay()));
        },
         appBarLeadingIcon: Icons.person_outline,

        
      )),
      body: Obx(() => Form(
        key: _formkey,
        child: ListView(
          padding: const EdgeInsets.all(40),
          children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.deepPurpleAccent[50],
            
            child: GestureDetector(
               onTap: ()async{
                pickedImage =   await imagePickerController.pickImage() as File;
                if(pickedImage!=null){
                  pickedImage = resizeImage(pickedImage!);
                   Future.delayed(Duration.zero, () {
                });
                }
               },
                child: imagePickerController.pickedImage.value!=null? 
                ClipOval(
                  child: Image.file(imagePickerController.pickedImage.value!
                  ,fit: BoxFit.cover,
                  width: 140,
                  height: 140,
                  ),
                ): const Icon(Icons.add_a_photo)
            )
          ),
          sheight20,
         CustomTextFielsWidget(
          hint: "Name", fieldIcon: Icons.person, controller: nameController,validator: (value) {
            if(value!.isEmpty){
              return "Please Enter name";
            }if(value.isEmpty||value.contains(' ')){
              return "should not contain spaces";
            }
            return null;
          },),
         sheight20,
          CustomTextFielsWidget(
          hint: "Age", fieldIcon: Icons.lock_person_sharp, controller: ageController,validator: (value) {
            if(value!.isEmpty){
              return "Please enter age";
            }if(value.isEmpty||value.contains(' ')){
              return "should not contain spaces";
            }
            return null;
          },),
          sheight20,
          CustomTextFielsWidget(
          hint: "Department", fieldIcon: Icons.assignment_add, controller: departMentController,validator: (value) {
            if(value!.isEmpty){
              return "Please enter department";
            }
            if(value.isEmpty||value.contains(' ')){
              return "should not contain spaces";
            }
            return null;
          },),
         sheight20,
           CustomTextFielsWidget(
          hint: "Rollnumber", fieldIcon: Icons.format_list_bulleted, controller: rollNumberController,validator: (value) {
            if(value!.isEmpty){
              return "Please enter Rollnumber";
            }
            if(value.isEmpty||value.contains(' ')){
              return "should not contain spaces";
            }
            return null;
          },),
          sheight20,
           CustomTextFielsWidget(
          hint: "Phone number", fieldIcon: Icons.phone, controller: phonenumberController,validator: (value){
            if(value!.isEmpty){
              return "Please enter phone number";
            }
            final RegExp phoneRegExp = RegExp(patttern);
            if (!phoneRegExp.hasMatch(value)) {
            return 'Please enter a valid phone number';
             }
            
          },),
        
          sheight20,
        
          ElevatedButton(onPressed: ()async{
           
            

            if(_formkey.currentState?.validate() ?? false || pickedImage!=null){
              print("Form is valid!");
              Get.snackbar("Success", "Saved",backgroundColor: Colors.green[100]);
            String name = nameController.text;
            String age = ageController.text;
            String department = departMentController.text;
            String rollNo = rollNumberController.text;
            String phone = phonenumberController.text;
            String image  = pickedImage?.path?? '';

            StudentManageMent studentData = StudentManageMent(
              statusCode: 200, 
              message: 'Success',
               afterExicution: [
                AfterExicution(
                  name: name, 
                  rollNo: rollNo,
                   age: age, 
                   department: department,
                    phone: phone,
                     image: image)
               ]
               );
               _formkey.currentState?.reset();
               pickedImage ==null;
               
               try {
                 await ApiService().postData(studentData);
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ScreenDisplay()));
                 
               } catch (e) {
                  print('Error posting data: $e');
                  Get.snackbar("Error", "Failed to save data", backgroundColor: Colors.red[200]);
               }
                
            }else{
              Get.snackbar("Error", "complete fields",backgroundColor: Colors.red[200]);
            }
          }, child:const Text("SUBMIT"))
        ]),
      ),)
    );
  }

File resizeImage(File originalImage, {int width = 800, int height = 600}) {
  final rawImage = img.decodeImage(originalImage.readAsBytesSync())!;
  final resizedImage = img.copyResize(rawImage, width: width, height: height);
  
  final resizedFile = File(originalImage.path)
    ..writeAsBytesSync(img.encodeJpg(resizedImage));

  return resizedFile;
}

   
  }






