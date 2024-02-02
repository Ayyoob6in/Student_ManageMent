
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:learn/constants/constants.dart';
import 'package:learn/data/model/student_model.dart';
import 'package:learn/presentation/controller/detail_controller.dart';
import 'package:learn/presentation/views/details/widget/details_app_bar.dart';
import 'package:learn/presentation/views/home/home.dart';
import 'package:learn/presentation/views/home/widget/custom_textfield.dart';
import 'package:learn/presentation/widgets/custom_dilog.dart';

// ignore: must_be_immutable
class ScreenDisplay extends StatelessWidget {
    ScreenDisplay({super.key});

  final TextEditingController searchController = TextEditingController();
  DetailsController controller = Get.find<DetailsController>();


  

  @override
  Widget build(BuildContext context) {
    controller.fetchData();
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(double.infinity, 70), child:CustomAppBar(
        titile:CustomTextFielsWidget(
          hint: "Search", fieldIcon: Icons.search,
           controller: searchController,
           size: 50,
           radius: 20,
           onchange: (value) {
            controller.searchByNameRoll(searchController.text);
            controller.fetchData();
           },
           shadow: const [BoxShadow(
            blurRadius: 2,
            color: Colors.purple,
            blurStyle: BlurStyle.inner
           )],
           
           ),
          appBarLeadingIcon: Icons.post_add,
          onPress: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
          },
         )),
         body:
          Obx(() {
           final searchResults = searchController.text.isEmpty
      ? controller.data
      : controller.data
          .where((student) => student.name
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();

  if (searchResults.isEmpty) {
    return const Center(
      child: Text('Searched Data Not found'),
    );
  }

            return GridView.builder(
            shrinkWrap: true,
            itemCount: controller.data.length,
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio:  0.7,
              crossAxisSpacing: 5,
              
              ), 
            itemBuilder: (context,index){
              AfterExicution student = controller.data[index];
              return Card(
               child: Column(children: [
                sheight20,
                ClipOval(
                    child: InstaImageViewer(
                      child: Image.network(
                        student.image,fit: BoxFit.cover,height: 90,width: 90,),
                    ),
                  ),
                  const SizedBox(height: 5,),
                     Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("Name: ${student.name}"),
                      Text("Age: ${student.age}"),
                     Text("Department: ${student.department}"),
                     Text("Roll Number: ${student.rollNo}"),
                     Text("Phone: ${student.phone}"),
                    const SizedBox(height: 10,),
                      Row(children: [
                         ElevatedButton(onPressed: (){
                         TextEditingController nameController = TextEditingController(text: student.name);
                         TextEditingController ageController = TextEditingController(text: student.age);
                         TextEditingController rollController = TextEditingController(text: student.rollNo);
                         TextEditingController departController = TextEditingController(text: student.department);
                         TextEditingController phoneController = TextEditingController(text: student.phone);
                          CustomDilog(
                             
                            option: "Save",
                            onPress: ()async{
                             await controller.apiService.editStudentDetails(
                                id: student.id.toString(),
                                 name:nameController.text,
                                  rollNo: rollController.text,
                                   age: ageController.text,
                                    department: departController.text,
                                     phone: phoneController.text
                                     );
                                     controller.fetchData();
                                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ScreenDisplay()));  
                                     Get.snackbar("Success", "Edited SuccessFully",backgroundColor: Colors.greenAccent[50]); 
                                    
                            },
                            ageController: ageController,
                             departController:departController,
                             nameController:nameController,
                            phoneController: phoneController,
                             rollController:rollController,
                             
                          ).showEditDialog(context);
                         }, child:const Text("Edit")),

                         const SizedBox(width: 10,),
                      ElevatedButton(onPressed: (){
                        CustomDilog(
                          onPress: ()async{
                            await controller.apiService.deleteStudentById(int.parse(student.id!));
                            Get.snackbar("Delete", "Deleted SuccessFully",backgroundColor: Colors.red[100]);
                            Navigator.of(context).pop();
                            controller.fetchData();

                          },
                         ageController: TextEditingController(text: student.age),
                         departController:TextEditingController(text: student.department) ,
                         nameController:TextEditingController(text: student.name),
                         phoneController: TextEditingController(text: student.phone),
                         rollController:TextEditingController(text: student.rollNo),
                          option: "Delete",
                          readOnly: true,
                        ).showEditDialog(context);
                      }, child: const Text("Delete"))
                      ],)
                   
                    ],)
                   ],),
                    
                     
               ],)
              );
            });
          }
             )
       
    );
  }
}

