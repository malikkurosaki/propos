import 'package:client/utils/g_val.dart';
import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_load.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/util_value.dart';
import '../utils/util_val.dart';

// outlet table
class OutletTable extends StatelessWidget {
  OutletTable({Key? key}) : super(key: key);
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          // table outlet
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: UtilVal.isMobile.value ? double.infinity : 720,
              child: Card(
                elevation: 0,
                child: DataTable(
                  showCheckboxColumn: true,
                  columns: const [
                    DataColumn(
                      label: Text("#"),
                    ),
                    DataColumn(
                      label: Text("name"),
                    ),
                    DataColumn(
                      label: Text("description"),
                    ),
                    DataColumn(
                      label: Text("action"),
                    ),
                  ],
                  rows: [
                    for (var outlet in GVal.outlets.value.val)
                      DataRow(
                        cells: [
                          DataCell(
                            Text((GVal.outlets.value.val.indexOf(outlet)+1).toString()),
                          ),
                          DataCell(
                            Text(outlet["name"].toString()),
                          ),
                          DataCell(
                            Text(outlet["description"].toString()),
                          ),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.orange,),
                                  onPressed: () {
                                    // dialog edit table
                                    Get.dialog(
                                      AlertDialog(
                                        title: const Text("Edit Outlet"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // name
                                            TextField(
                                              controller: _titleController,
                                              decoration: const InputDecoration(
                                                labelText: "Name",
                                              ),
                                            ),
                                            // description
                                            TextField(
                                              controller: _descriptionController,
                                              decoration: const InputDecoration(
                                                labelText: "Description",
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          MaterialButton(
                                            child: const Text("Save"),
                                            onPressed: () {
                                              // update data
                                              GVal.outlets.value.val[GVal.outlets.value.val.indexOf(outlet)]["name"] =
                                                  _titleController.text;
                                              GVal.outlets.value.val[GVal.outlets.value.val.indexOf(outlet)]["description"] =
                                                  _descriptionController.text;
                                              // close dialog
                                              Get.back();
                                            },
                                          ),
                                          MaterialButton(
                                            child: const Text("Cancel"),
                                            onPressed: () {
                                              // close dialog
                                              Get.back();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.pink,),
                                  onPressed: () {
                                    // dialog delete table
                                    Get.dialog(
                                      AlertDialog(
                                        title: const Text("Delete Outlet"),
                                        content: const Text("Are you sure?"),
                                        actions: [
                                          MaterialButton(
                                            child: const Text("Yes"),
                                            onPressed: () async {
                                              await UtilHttp.outletDelete(outlet["id"]);
                                              await UtilLoad.loadOutlet();
                                              Get.back();
                                            },
                                          ),
                                          MaterialButton(
                                            child: const Text("No"),
                                            onPressed: () {
                                              // close dialog
                                              Get.back();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  onPressed: (){
                                    UtilValue.indexOutletPageSet(value: 3);
                                  }, 
                                  icon: const Icon(Icons.grading_outlined, color: Colors.green,),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Table(
          //   defaultColumnWidth: FlexColumnWidth(1),
          //   children: [
          //     TableRow(
          //       decoration: BoxDecoration(
          //         color: Colors.grey[200],
          //       ),
          //       children: const [
          //         TableCell(
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Text("id",
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.bold,
          //                 )),
          //           ),
          //         ),
          //         TableCell(
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Text("name",
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.bold,
          //                 )),
          //           ),
          //         ),
          //         TableCell(
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Text("description",
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.bold,
          //                 )),
          //           ),
          //         ),
          //         // actions
          //         TableCell(
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Text("actions",
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.bold,
          //                 )),
          //           ),
          //         ),
          //       ],
          //     ),
          //     // table data
          //     ...UtilPref.outlets.map((e) {
          //       return TableRow(
          //         children: [
          //           TableCell(
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Text(e["id"] ?? ""),
          //             ),
          //           ),
          //           TableCell(
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Text(e["name"] ?? ""),
          //             ),
          //           ),
          //           TableCell(
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Text(e["description"] ?? ""),
          //             ),
          //           ),
          //           // actions
          //           TableCell(
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Row(
          //                 children: [
          //                   // edit
          //                   IconButton(
          //                     icon: Icon(Icons.edit),
          //                     onPressed: () {
          //                       // dialog edit table
          //                       Get.dialog(
          //                         AlertDialog(
          //                           title: Text("Edit Outlet"),
          //                           content: Column(
          //                             mainAxisSize: MainAxisSize.min,
          //                             children: [
          //                               // name
          //                               TextField(
          //                                 controller: _titleController,
          //                                 decoration: InputDecoration(
          //                                   labelText: "Name",
          //                                 ),
          //                               ),
          //                               // description
          //                               TextField(
          //                                 controller: _descriptionController,
          //                                 decoration: InputDecoration(
          //                                   labelText: "Description",
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                           actions: [
          //                             MaterialButton(
          //                               child: Text("Save"),
          //                               onPressed: () {
          //                                 // update data
          //                                 UtilPref.outlets[UtilPref.outlets.indexOf(e)]["name"] =
          //                                     _titleController.text;
          //                                 UtilPref.outlets[UtilPref.outlets.indexOf(e)]["description"] =
          //                                     _descriptionController.text;
          //                                 // close dialog
          //                                 Get.back();
          //                               },
          //                             ),
          //                             MaterialButton(
          //                               child: Text("Cancel"),
          //                               onPressed: () {
          //                                 // close dialog
          //                                 Get.back();
          //                               },
          //                             ),
          //                           ],
          //                         ),
          //                       );
          //                     },
          //                   ),
          //                   // delete
          //                   IconButton(
          //                     icon: Icon(Icons.delete),
          //                     onPressed: () {
          //                      // dialog delete table
          //                       Get.dialog(
          //                         AlertDialog(
          //                           title: Text("Delete Outlet"),
          //                           content: Text("Are you sure?"),
          //                           actions: [
          //                             MaterialButton(
          //                               child: Text("Yes"),
          //                               onPressed: () async{
          //                                 await UtilHttp.outletDelete(e["id"]);
          //                                 await UtilLoad.outlet();
          //                                 Get.back();
          //                               },
          //                             ),
          //                             MaterialButton(
          //                               child: Text("No"),
          //                               onPressed: () {
          //                                 // close dialog
          //                                 Get.back();
          //                               },
          //                             ),
          //                           ],
          //                         ),
          //                       );
          //                     },
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ],
          //       );
          //     }).toList(),
          //   ],
          // ),
        ],
      ),
    );
  }
}
