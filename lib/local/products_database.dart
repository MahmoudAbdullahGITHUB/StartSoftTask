// import 'package:sqflite/sqflite.dart';
//
// class DbHelper {
//   // var db = await openDatabase('my_db.db');
//
//   void createDatabase() async {
//     var database = await openDatabase(
//       'start.db',
//       version: 1,
//       onCreate: (database, version) {
//         database
//             .execute(
//                 'CREATE TABLE products (id INTEGER PRIMARY KEY autoincrement, productId Integer, title TEXT, price TEXT, description TEXT, category TEXT, image TEXT, color TEXT)')
//             .then((value) {
//           print('database is created');
//         }).catchError((error){print('Error in database  '+error.toString());});
//       },
//       onOpen: (database) {
//         print('database is opened');
//       },
//     );
//   }
// }
//
// // class DbHelper {
// //   static final DbHelper _instance = DbHelper._init();
// //
// //   factory DbHelper() => _instance;
// //
// //   DbHelper._init();
// //
// //   static late Database _db;
// //
// //   Future<Database> createDatabase() async {
// //     if (_db != null) {
// //       return _db;
// //     }
// //     // String path =
// //     _db = await openDatabase(
// //       'star.db',
// //       version: 1,
// //       onCreate: (Database db, int version) {
// //         db
// //             .execute(
// //                 'CREATE TABLE products (id INTEGER PRIMARY KEY autoincrement,productId Integer,title TEXT,date TEXT,time TEXT,status TEXT)')
// //             .then((value) {
// //           print('table created');
// //         }).catchError((error) {
// //           print(error.toString());
// //         });
// //         return db;
// //       });
// //
// //     //   onOpen: (Database _database) {
// //     //     getDataFromDatabase(_database);
// //     //     print('opened');
// //     //   },
// //     // ).then((value) {
// //     //   _database = value;
// //     // });
// //   }
// //
// // // List<Map> newTasks = [];
// // // List<Map> doneTasks = [];
// // // List<Map> archivedTasks = [];
// //
// // /*
// //   void createDatabase() {
// //     openDatabase(
// //       'todo.db',
// //       version: 1,
// //       onCreate: (Database _database, int version) {
// //         _database
// //             .execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
// //             .then((value) {
// //           print('table created');
// //         }).catchError((error) {
// //           print(error.toString());
// //         });
// //       },
// //       onOpen: (Database _database) {
// //         getDataFromDatabase(_database);
// //         print('opened');
// //       },
// //     ).then((value) {
// //       _database = value;
// //     });
// //   }
// //
// //
// //   insertToDatabase({
// //     required String title,
// //     required String date,
// //     required String time,
// //   }) async {
// //     return await _database.transaction((txn) async {
// //       txn.rawInsert('INSERT INTO tasks (title,date,time,status) VALUES ("$title","$date","$time","new")').then((value) {
// //         print('task inserted');
// //         // emit(AppInsertDatabaseState());
// //         getDataFromDatabase(_database);
// //       }).catchError((err) {
// //         print(err.toString());
// //       });
// //     });
// //   }
// //
// //   void getDataFromDatabase(Database _database) {
// //     newTasks = [];
// //     doneTasks = [];
// //     archivedTasks = [];
// //
// //     // emit(AppCreateDatabaseLoadingState());
// //     _database.rawQuery('SELECT * FROM tasks').then((value) {
// //       value.forEach((element) {
// //         if (element['status'] == 'new')
// //           newTasks.add(element);
// //         else if (element['status'] == 'done')
// //           doneTasks.add(element);
// //         else
// //           archivedTasks.add(element);
// //       });
// //       // emit(AppGetDatabaseState());
// //     });
// //   }
// //
// // */
// //
// // }
