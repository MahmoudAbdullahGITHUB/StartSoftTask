import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sqflite/sqflite.dart';
import 'package:start_software_flutter/models/product_model.dart';
import 'package:start_software_flutter/shared/components.dart';
import 'package:start_software_flutter/utils/constants/constants.dart';

import 'item_card.dart';

class HomeScreen extends StatefulWidget {
  static const routName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final tabs = [];
  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheetShown = false;
  var titleController = TextEditingController();
  var priceController = TextEditingController();
  var descriptionController = TextEditingController();
  var imageController = TextEditingController();

  // var titleController = TextEditingController();
  // var titleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Container(
          child: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("assets/images/app_home_bar.png"),
                      fit: BoxFit.none),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              backgroundColor: HexColor('020101'),
              title: Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: Icon(Icons.filter_list),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.zero,
                            filled: true,
                            fillColor: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.notifications_active,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              )),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GridView.builder(
                      itemCount: productsMap.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) => Center(
                            // child: ItemCard(product: KMyProductsObject[index]),
                            child: ItemCard(index),
                          )),
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (isBottomSheetShown) {
            Navigator.pop(context);
            isBottomSheetShown = false;
          } else {
            scaffoldKey.currentState!.showBottomSheet(
              (context) => Container(
                color: Colors.grey[100],
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: defaultFormField(
                            controller: titleController,
                            type: TextInputType.text,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Enter value';
                              }
                              return null;
                            },
                            label: 'Production Title',
                            prefix: Icons.title,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: defaultFormField(
                            controller: priceController,
                            type: TextInputType.text,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Enter value';
                              }
                              return null;
                            },
                            label: 'Production price',
                            prefix: Icons.monetization_on_outlined,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: defaultFormField(
                            controller: descriptionController,
                            type: TextInputType.text,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Enter value';
                              }
                              return null;
                            },
                            label: 'Production description',
                            prefix: Icons.title,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: defaultFormField(
                            controller: imageController,
                            type: TextInputType.text,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Enter value';
                              }
                              return null;
                            },
                            label: 'Product image',
                            prefix: Icons.title,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlatButton(
                            child: Text(
                              'Add Product',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            color: Colors.deepOrange,
                            textColor: Colors.white,
                            onPressed: () {
                              insertToDatabase(
                                  titleController.text,
                                  priceController.text,
                                  descriptionController.text,
                                  'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg');
                              print('yessssssssssssssssssssssss ' +
                                  titleController.text);
                              Navigator.pop(context);

                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
            isBottomSheetShown = true;
          }
        },
      ),
    );
  }

  void createDatabase() async {
    database = await openDatabase(
      'start.db',
      version: 1,
      onCreate: (database, version) {
        print('database is created');
        database
            .execute(
                'CREATE TABLE products (id INTEGER PRIMARY KEY autoincrement, productId TEXT, title TEXT, price TEXT, description TEXT, category TEXT, image TEXT, color TEXT)')
            .then((value) {
          print('table is created');
        }).catchError((error) {
          print('Error in database  ' + error.toString());
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database).then((value) {
          setState(() {
            productsMap = value;
            print('database is opened $productsMap');

          });
        });
      },
    );
  }

  void insertToDatabase(
    String title,
    String price,
    String description,
    String image,
  ) {
    database.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO products (productId, title, price, description, category, image, color) VALUES ("5","$title","$price","productDescription","productCategory","$image","productColor")')
          .then((value) {
        print('inserted Successful');
         getDataFromDatabase(database).then((value) {
          // Navigator.pop(context);
          setState(() {
            isBottomSheetShown = false;
            productsMap = value;
            print('database is opened $productsMap');

          });
        });

      }).catchError((error) {
        print('catch error in insert data in database');
      });
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database.rawQuery('SELECT * FROM products');
  }
}

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//
//   final tabs = [];
//
//   Widget image_slider_carousel = Padding(
//     padding: EdgeInsets.only(top: 10),
//     child: Container(
//       height: 200,
//       child: Carousel(
//         boxFit: BoxFit.fill,
//         images: [
//           AssetImage('assets/images/image1.png'),
//           AssetImage('assets/images/image1.png'),
//           AssetImage('assets/images/image1.png'),
//         ],
//       ),
//     ),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(70),
//         child: Container(
//           child: AppBar(
//               flexibleSpace: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   image: DecorationImage(
//                       image: AssetImage("assets/images/app_home_bar.png"),
//                       fit: BoxFit.none),
//                 ),
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(50),
//                   bottomRight: Radius.circular(50),
//                 ),
//               ),
//               backgroundColor: HexColor('020101'),
//               title: Container(
//                 child: Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(13.0),
//                       child: GestureDetector(
//                         onTap: () {},
//                         child: Icon(
//                           Icons.menu,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: TextField(
//                         decoration: InputDecoration(
//                             hintText: 'Search',
//                             prefixIcon: Icon(Icons.search),
//                             suffixIcon: Icon(Icons.filter_list),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide.none,
//                             ),
//                             contentPadding: EdgeInsets.zero,
//                             filled: true,
//                             fillColor: Colors.white),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(13.0),
//                       child: GestureDetector(
//                         onTap: () {},
//                         child: Icon(
//                           Icons.notifications_active,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                 ),
//               )),
//         ),
//       ),
//       body: Container(
//         // child: SingleChildScrollView(
//         //   child: Column(
//         //     children: [
//         //       Container(
//         //         height: 200,
//         //         child: ListView(
//         //           children: [image_slider_carousel],
//         //         ),
//         //       ),
//         //       SizedBox(
//         //         height: 10,
//         //       ),
//         //       Container(
//         //         width: double.infinity,
//         //         child: Text(
//         //           '   Categories',
//         //           textAlign: TextAlign.left,
//         //           style: TextStyle(fontFamily: 'Cairo', color: Colors.red),
//         //         ),
//         //       ),
//         //       Container(
//         //         height: 200,
//         //         child: GridView.count(
//         //           crossAxisCount: 3,
//         //           childAspectRatio: .9,
//         //           padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
//         //           crossAxisSpacing: 10.0,
//         //           children: [
//         //             Container(
//         //               child: Card(
//         //                 semanticContainer: true,
//         //                 clipBehavior: Clip.antiAliasWithSaveLayer,
//         //                 shape: RoundedRectangleBorder(
//         //                   borderRadius: BorderRadius.circular(10.0),
//         //                 ),
//         //                 elevation: 5,
//         //                 child: Column(
//         //                   children: [
//         //                     Container(
//         //                       width: 67,
//         //                       height: 65,
//         //                       child: Padding(
//         //                         padding: const EdgeInsets.all(3.0),
//         //                         child: Image(
//         //                           image: AssetImage('assets/images/1.png'),
//         //                           fit: BoxFit.fill,
//         //                         ),
//         //                       ),
//         //                     ),
//         //                     Expanded(
//         //                         child: Container(
//         //                       height: 100,
//         //                       child: Padding(
//         //                         padding: const EdgeInsets.only(bottom: 2.0),
//         //                         child: Text('tires'),
//         //                       ),
//         //                     ))
//         //                   ],
//         //                 ),
//         //               ),
//         //             ),
//         //             Container(
//         //               child: Card(
//         //                 semanticContainer: true,
//         //                 clipBehavior: Clip.antiAliasWithSaveLayer,
//         //                 shape: RoundedRectangleBorder(
//         //                   borderRadius: BorderRadius.circular(10.0),
//         //                 ),
//         //                 elevation: 5,
//         //                 child: Column(
//         //                   children: [
//         //                     Container(
//         //                       width: 67,
//         //                       height: 65,
//         //                       child: Padding(
//         //                         padding: const EdgeInsets.all(3.0),
//         //                         child: Image(
//         //                           image: AssetImage('assets/images/6.png'),
//         //                           fit: BoxFit.fill,
//         //                         ),
//         //                       ),
//         //                     ),
//         //                     Expanded(
//         //                         child: Container(
//         //                       height: 100,
//         //                       child: Padding(
//         //                         padding: const EdgeInsets.only(bottom: 2.0),
//         //                         child: Text('tires'),
//         //                       ),
//         //                     ))
//         //                   ],
//         //                 ),
//         //               ),
//         //             ),
//         //             Container(
//         //               child: Card(
//         //                 semanticContainer: true,
//         //                 clipBehavior: Clip.antiAliasWithSaveLayer,
//         //                 shape: RoundedRectangleBorder(
//         //                   borderRadius: BorderRadius.circular(10.0),
//         //                 ),
//         //                 elevation: 5,
//         //                 child: Column(
//         //                   children: [
//         //                     Container(
//         //                       width: 67,
//         //                       height: 65,
//         //                       child: Padding(
//         //                         padding: const EdgeInsets.all(3.0),
//         //                         child: Image(
//         //                           image: AssetImage('assets/images/2.png'),
//         //                           fit: BoxFit.fill,
//         //                         ),
//         //                       ),
//         //                     ),
//         //                     Expanded(
//         //                         child: Container(
//         //                       height: 100,
//         //                       child: Padding(
//         //                         padding: const EdgeInsets.only(bottom: 2.0),
//         //                         child: Text('tires'),
//         //                       ),
//         //                     ))
//         //                   ],
//         //                 ),
//         //               ),
//         //             ),
//         //             Container(
//         //               child: Card(
//         //                 semanticContainer: true,
//         //                 clipBehavior: Clip.antiAliasWithSaveLayer,
//         //                 shape: RoundedRectangleBorder(
//         //                   borderRadius: BorderRadius.circular(10.0),
//         //                 ),
//         //                 elevation: 5,
//         //                 child: Column(
//         //                   children: [
//         //                     Container(
//         //                       width: 67,
//         //                       height: 65,
//         //                       child: Padding(
//         //                         padding: const EdgeInsets.all(3.0),
//         //                         child: Image(
//         //                           image: AssetImage('assets/images/6.png'),
//         //                           fit: BoxFit.fill,
//         //                         ),
//         //                       ),
//         //                     ),
//         //                     Expanded(
//         //                         child: Container(
//         //                       height: 100,
//         //                       child: Padding(
//         //                         padding: const EdgeInsets.only(bottom: 2.0),
//         //                         child: Text('tires'),
//         //                       ),
//         //                     ))
//         //                   ],
//         //                 ),
//         //               ),
//         //             ),
//         //             Container(
//         //               child: Card(
//         //                 semanticContainer: true,
//         //                 clipBehavior: Clip.antiAliasWithSaveLayer,
//         //                 shape: RoundedRectangleBorder(
//         //                   borderRadius: BorderRadius.circular(10.0),
//         //                 ),
//         //                 elevation: 5,
//         //                 child: Column(
//         //                   children: [
//         //                     Container(
//         //                       width: 67,
//         //                       height: 65,
//         //                       child: Padding(
//         //                         padding: const EdgeInsets.all(3.0),
//         //                         child: Image(
//         //                           image: AssetImage('assets/images/4.png'),
//         //                           fit: BoxFit.fill,
//         //                         ),
//         //                       ),
//         //                     ),
//         //                     Expanded(
//         //                         child: Container(
//         //                       height: 100,
//         //                       child: Padding(
//         //                         padding: const EdgeInsets.only(bottom: 2.0),
//         //                         child: Text('tires'),
//         //                       ),
//         //                     ))
//         //                   ],
//         //                 ),
//         //               ),
//         //             ),
//         //             Container(
//         //               child: Card(
//         //                 semanticContainer: true,
//         //                 clipBehavior: Clip.antiAliasWithSaveLayer,
//         //                 shape: RoundedRectangleBorder(
//         //                   borderRadius: BorderRadius.circular(10.0),
//         //                 ),
//         //                 elevation: 5,
//         //                 child: Column(
//         //                   children: [
//         //                     Container(
//         //                       width: 67,
//         //                       height: 65,
//         //                       child: Padding(
//         //                         padding: const EdgeInsets.all(3.0),
//         //                         child: Image(
//         //                           image: AssetImage('assets/images/5.png'),
//         //                           fit: BoxFit.fill,
//         //                         ),
//         //                       ),
//         //                     ),
//         //                     Expanded(
//         //                         child: Container(
//         //                       height: 100,
//         //                       child: Padding(
//         //                         padding: const EdgeInsets.only(bottom: 2.0),
//         //                         child: Text('tires'),
//         //                       ),
//         //                     ))
//         //                   ],
//         //                 ),
//         //               ),
//         //             ),
//         //           ],
//         //         ),
//         //       ),
//         //       Container(
//         //         child: Padding(
//         //           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//         //           child: Row(
//         //             children: [
//         //               Expanded(
//         //                 child: Text(
//         //                   "Most Selling",
//         //                   style:
//         //                       TextStyle(color: Colors.red, fontFamily: 'Cairo'),
//         //                 ),
//         //               ),
//         //               Text(
//         //                 "show All",
//         //                 style: TextStyle(
//         //                   color: Colors.red,
//         //                   fontFamily: 'Cairo',
//         //                   fontWeight: FontWeight.values[5],
//         //                   decoration: TextDecoration.underline,
//         //                 ),
//         //               )
//         //             ],
//         //           ),
//         //         ),
//         //       ),
//         //       Container(
//         //         height: 200,
//         //         color: Colors.red,
//         //         child: ListView(
//         //           scrollDirection: Axis.horizontal,
//         //           children: [
//         //             Container(
//         //               width: 265,
//         //               height: 138,
//         //               color: HexColor('D9D9D9'),
//         //               child: Row(
//         //                 children: [
//         //                   SizedBox(
//         //                     width: 20,
//         //                   ),
//         //                   Container(
//         //                     width: 42,
//         //                     height: 91,color: Colors.red,
//         //                     child: Image(
//         //                       image: AssetImage("assets/images/7.png"),
//         //                       fit: BoxFit.fitHeight,
//         //                     ),
//         //                   ),
//         //                   Column(
//         //                     children: [Text('زيت فرامل موبيل')],
//         //                   )
//         //                 ],
//         //               ),
//         //             ),
//         //             Icon(Icons.featured_play_list),
//         //             Icon(Icons.featured_play_list),
//         //             Icon(Icons.featured_play_list),
//         //             Icon(Icons.featured_play_list),
//         //             Icon(Icons.featured_play_list),
//         //           ],
//         //         ),
//         //       )
//         //     ],
//         //   ),
//         // ),
//       ),
//     );
//   }
// }
