// import 'dart:convert';

// class StudentModel {
//   final String faculty;
//   final String name;
//   final String studentId;
  
//   StudentModel({
//     this.faculty,
//     this.name,
//     this.studentId,
//   });
  

//   StudentModel copyWith({
//     String faculty,
//     String name,
//     String studentId,
//   }) {
//     return StudentModel(
//       faculty: faculty ?? this.faculty,
//       name: name ?? this.name,
//       studentId: studentId ?? this.studentId,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'faculty': faculty,
//       'name': name,
//       'studentId': studentId,
//     };
//   }

//   factory StudentModel.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
  
//     return StudentModel(
//       faculty: map['faculty'],
//       name: map['name'],
//       studentId: map['studentId'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory StudentModel.fromJson(String source) => StudentModel.fromMap(json.decode(source));

//   @override
//   String toString() => 'StudentModel(faculty: $faculty, name: $name, studentId: $studentId)';

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;
  
//     return o is StudentModel &&
//       o.faculty == faculty &&
//       o.name == name &&
//       o.studentId == studentId;
//   }

//   @override
//   int get hashCode => faculty.hashCode ^ name.hashCode ^ studentId.hashCode;
// }
