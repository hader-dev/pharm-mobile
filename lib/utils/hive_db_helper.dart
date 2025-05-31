// import 'package:cri/model/company.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:path_provider/path_provider.dart';

// import '../model/person.dart';
// import '../model/user.dart';

// class HiveDbHelper {
//   static Future<void> init() async {
//     final directory = await getApplicationDocumentsDirectory();
//     Hive.registerAdapter<User>(UserAdapter());
//     Hive.registerAdapter<Company>(CompanyAdapter());
//     Hive.registerAdapter<Person>(PersonAdapter());
//     Hive.init(directory.path);
//   }

//   static Future<Box> openBox(String boxName) async {
//     var box = await Hive.openBox(boxName);
//     return box;
//   }

//   static Future<void> closeBox(Box box) async {
//     await box.close();
//   }
// }

// enum HiveDbTable {
//   person,
// }
