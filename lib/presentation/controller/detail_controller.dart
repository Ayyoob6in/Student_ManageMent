import 'package:get/get.dart';
import 'package:learn/data/model/student_model.dart';
import 'package:learn/domain/api/apiservice.dart';

class DetailsController extends GetxController{
  final ApiService apiService = ApiService();
  RxList<AfterExicution> data = <AfterExicution>[].obs;

  @override
  void onInit() {
    refresh();
    fetchData();
    super.onInit();
  }

  void fetchData()async{
    try {
        StudentManageMent studentManageMent = await apiService.fetchData();
        data.value = studentManageMent.afterExicution;
        // ignore: unnecessary_null_comparison
        if (studentManageMent != null) {
        data.value = studentManageMent.afterExicution;
    }
    } catch (e) {
      print("error fetching data $e");
    }
  }

  Future<void>deleteStudent(int id)async{
    try {
      await apiService.deleteStudentById(id);
    } catch (e) {
      print("error $e");
    }
  }


   Future<void> editStudentDetails({
    required String id,
    required String name,
    required String rollNo,
    required String age,
    required String department,
    required String phone,
  }) async {
    try {
      await apiService.editStudentDetails(
        id: id,
        name: name,
        rollNo: rollNo,
        age: age,
        department: department,
        phone: phone,
      );
      fetchData();
      update();
    } catch (e) {
      print('Error editing student details: $e');
    }
  }


  Future<void> searchByNameRoll(String query) async {
  try {
    StudentManageMent searchData = await apiService.searchByNameRoll(query);
    data.value = searchData.afterExicution;
  } catch (e) {
    print('Error searching data: $e');
  }
}

  
}