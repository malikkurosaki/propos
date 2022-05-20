// category table
import 'dart:convert';

import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_load.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../utils/util_pref.dart';
import '../utils/util_val.dart';

class CategoryTable extends StatelessWidget {
  CategoryTable({Key? key}) : super(key: key);
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          SizedBox(
            width: UtilVal.isMobile.value ? double.infinity : 720,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Card(
                elevation: 0,
                child: DataTable(
                  columns: const [
                    // DataColumn(
                    //   label: Text("id"),
                    // ),
                    DataColumn(
                      label: Text("#"),
                    ),
                    DataColumn(
                      label: Text("name"),
                    ),
                    DataColumn(
                      label: Text("description"),
                    ),
                    DataColumn(label: Text("action")),
                  ],
                  rows: [
                    for (var category in UtilPref.categories)
                      DataRow(
                        cells: [
                          // DataCell(
                          //   Text(category["id"].toString()),
                          // ),
                          DataCell(
                            Text((UtilPref.categories.indexOf(category) + 1).toString()),
                          ),
                          DataCell(
                            Text(category["name"].toString()),
                          ),
                          DataCell(
                            Text(category["description"].toString()),
                          ),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.orange,),
                                  onPressed: () {
                                    _titleController.text = category['name'];
                                    _descriptionController.text = category['description'];
          
                                    Get.dialog(
                                      AlertDialog(
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // title
                                              TextField(
                                                controller: _titleController,
                                                decoration: InputDecoration(
                                                  labelText: "Title",
                                                ),
                                              ),
                                              // description
                                              TextField(
                                                controller: _descriptionController,
                                                decoration: InputDecoration(
                                                  labelText: "Description",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          // no
                                          MaterialButton(
                                            onPressed: () => Get.back(),
                                            child: Text("NO"),
                                          ),
                                          // yes
                                          MaterialButton(
                                            color: Colors.blue,
                                            child: Text(
                                              "Save",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            onPressed: () {
                                              category.name = _titleController.text;
                                              category.description = _descriptionController.text;
                                              Get.back();
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.pink,),
                                  onPressed: () {
                                    Get.dialog(
                                      AlertDialog(
                                        title: Text("Delete "),
                                        actions: [
                                          MaterialButton(
                                            onPressed: () => Get.back(),
                                            child: Text("No"),
                                          ),
                                          MaterialButton(
                                            onPressed: () async {
                                              final delData = await UtilHttp.categoryDelete(category['id']);
                                              final hasil = jsonDecode(delData.body);
                                              if (hasil['success']) {
                                                Get.back();
                                                EasyLoading.showSuccess("Berhasil");
                                                UtilLoad.category();
                                              }
                                            },
                                            child: Text("Yes"),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                // Table(
                //   defaultColumnWidth: FlexColumnWidth(1),
                //   children: [
                //     TableRow(
                //       decoration:
                //           BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1)))),
                //       children: const [
                //         // TableCell(
                //         //   child: Padding(
                //         //     padding: const EdgeInsets.all(8.0),
                //         //     child: Text(
                //         //       "id",
                //         //       style: TextStyle(
                //         //         fontSize: 16,
                //         //         fontWeight: FontWeight.bold,
                //         //       ),
                //         //     ),
                //         //   ),
                //         // ),
                //         TableCell(
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Text(
                //               "name",
                //               style: TextStyle(
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //           ),
                //         ),
                //         TableCell(
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Text(
                //               "description",
                //               style: TextStyle(
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //           ),
                //         ),
                //         // actions
                //         TableCell(
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Text(
                //               "actions",
                //               style: TextStyle(
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //     ...UtilPref.categories
                //         .map(
                //           (element) => TableRow(
                //             children: [
                //               // TableCell(
                //               //   child: Padding(
                //               //     padding: const EdgeInsets.all(8.0),
                //               //     child: Text(
                //               //       element['id'].toString(),
                //               //       style: TextStyle(
                //               //         fontSize: 16,
                //               //       ),
                //               //     ),
                //               //   ),
                //               // ),
                //               TableCell(
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Text(
                //                     element['name'].toString(),
                //                     style: TextStyle(
                //                       fontSize: 16,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               TableCell(
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Text(
                //                     element['description'].toString(),
                //                     style: TextStyle(
                //                       fontSize: 16,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               // actions
                //               TableCell(
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Row(
                //                     mainAxisAlignment: MainAxisAlignment.end,
                //                     children: [
                //                       IconButton(
                //                         icon: Icon(Icons.edit),
                //                         onPressed: () {
                //                           _titleController.text = element['name'];
                //                           _descriptionController.text = element['description'];
          
                //                           Get.dialog(
                //                             AlertDialog(
                //                               content: Padding(
                //                                 padding: const EdgeInsets.all(8.0),
                //                                 child: Column(
                //                                   mainAxisSize: MainAxisSize.min,
                //                                   children: [
                //                                     // title
                //                                     TextField(
                //                                       controller: _titleController,
                //                                       decoration: InputDecoration(
                //                                         labelText: "Title",
                //                                       ),
                //                                     ),
                //                                     // description
                //                                     TextField(
                //                                       controller: _descriptionController,
                //                                       decoration: InputDecoration(
                //                                         labelText: "Description",
                //                                       ),
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ),
                //                               actions: [
                //                                 // no
                //                                 MaterialButton(
                //                                   onPressed: () => Get.back(),
                //                                   child: Text("NO"),
                //                                 ),
                //                                 // yes
                //                                 MaterialButton(
                //                                   color: Colors.blue,
                //                                   child: Text(
                //                                     "Save",
                //                                     style: TextStyle(color: Colors.white),
                //                                   ),
                //                                   onPressed: () {
                //                                     element.name = _titleController.text;
                //                                     element.description = _descriptionController.text;
                //                                     Get.back();
                //                                   },
                //                                 )
                //                               ],
                //                             ),
                //                           );
                //                         },
                //                       ),
                //                       IconButton(
                //                         icon: Icon(Icons.delete),
                //                         onPressed: () async {
                //                           Get.dialog(
                //                             AlertDialog(
                //                               title: Text("Delete "),
                //                               actions: [
                //                                 MaterialButton(
                //                                   onPressed: () => Get.back(),
                //                                   child: Text("No"),
                //                                 ),
                //                                 MaterialButton(
                //                                   onPressed: () async {
                //                                     final delData = await UtilHttp.categoryDelete(element['id']);
                //                                     final hasil = jsonDecode(delData.body);
                //                                     if (hasil['success']) {
                //                                       Get.back();
                //                                       EasyLoading.showSuccess("Berhasil");
                //                                       UtilLoad.category();
          
                //                                     }
                //                                   },
                //                                   child: Text("Yes"),
                //                                 )
                //                               ],
                //                             ),
                //                           );
                //                         },
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         )
                //         .toList(),
                //   ],
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
