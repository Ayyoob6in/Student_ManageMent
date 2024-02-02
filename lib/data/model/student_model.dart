// To parse this JSON data, do
//
//     final studentManageMent = studentManageMentFromJson(jsonString);

import 'dart:convert';

StudentManageMent studentManageMentFromJson(String str) => StudentManageMent.fromJson(json.decode(str));

String studentManageMentToJson(StudentManageMent data) => json.encode(data.toJson());

class StudentManageMent {
    int statusCode;
    String message;
    List<AfterExicution> afterExicution;

    StudentManageMent({
        required this.statusCode,
        required this.message,
        required this.afterExicution,
    });

    factory StudentManageMent.fromJson(Map<String, dynamic> json) => StudentManageMent(
        statusCode: json["status_code"],
        message: json["message"],
        afterExicution: List<AfterExicution>.from(json["after exicution"].map((x) => AfterExicution.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "after exicution": List<dynamic>.from(afterExicution.map((x) => x.toJson())),
    };
}

class AfterExicution {
    String? id;
    String name;
    String rollNo;
    String age;
    String department;
    String phone;
    String image;

    AfterExicution({
        this.id,
        required this.name,
        required this.rollNo,
        required this.age,
        required this.department,
        required this.phone,
        required this.image,
    });

    factory AfterExicution.fromJson(Map<String, dynamic> json) => AfterExicution(
        id: json["id"],
        name: json["name"],
        rollNo: json["roll_no"],
        age: json["age"],
        department: json["department"],
        phone: json["phone"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "roll_no": rollNo,
        "age": age,
        "department": department,
        "phone": phone,
        "image": image,
    };
}
