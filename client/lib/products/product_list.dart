import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/utils/g_val.dart';
import 'package:client/utils/util_comp.dart';
import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_load.dart';
import 'package:client/utils/util_value.dart';
import 'package:client/utils/util_val.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // table product UtilPref.products

   
    
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Obx(
        () => GVal.products.value.val.isEmpty
            ? MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  UtilValue.indexProductPageSet(value: 1);
                },
                child: const Text(
                  "Product empty",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : ListView(
              controller: ScrollController(),
              children: [
                for(final pro in GVal.products.value.val)
                  Column(
                    children: [
                      ListTile(
                        leading: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: UtilComp().gambar(pro),
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                        title: Text(pro['name'].toString()),
                        trailing: Text(pro['price'].toString()),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text((pro?['Stocks']?['quantity']??"").toString()),
                            Text((pro?['Stocks']?['minQuantity']??"").toString()),
                          ],
                        ),
                        onTap: () {
                          debugPrint(pro.toString());
                        },
                      ),
                      const Divider(),
                    ],
                  ),
              ],
            )
            // SingleChildScrollView(
            //   scrollDirection: Axis.vertical,
            //   controller: ScrollController(),
            //   child: FittedBox(
            //     fit: BoxFit.fitWidth,
            //     child: DataTable(
            //         headingRowColor: MaterialStateProperty.all<Color>(Colors.blue),
            //         headingTextStyle: TextStyle(color: Colors.white),
            //         // dataRowColor: MaterialStateProperty.all(Colors.grey[100]),
            //         columns: [
            //           DataColumn(
            //             label: Text("#"),
            //           ),
            //           DataColumn(
            //             label: Text(
            //               "name".toUpperCase(),
            //             ),
            //           ),
            //           DataColumn(
            //             label: Text("price".toUpperCase()),
            //           ),
            //           DataColumn(
            //             label: Text("description".toUpperCase()),
            //           ),
            //           DataColumn(
            //             label: Text("stock".toUpperCase()),
            //           ),
            //           DataColumn(
            //             label: Text("min stock".toUpperCase()),
            //           ),
            //           DataColumn(
            //             label: Text("image".toUpperCase()),
            //           ),
            //           DataColumn(
            //             label: Text("category".toUpperCase()),
            //           ),
            //           DataColumn(
            //             label: Text("outlet".toUpperCase()),
            //           ),
            //           DataColumn(label: Text("action".toUpperCase())),
            //         ],
            //         rows: [
            //           for (var product in UtilValue.products)
            //             DataRow(
            //               cells: [
            //                 DataCell(
            //                   Text((UtilValue.products.indexOf(product) + 1).toString()),
            //                 ),
            //                 DataCell(
            //                   Container(width: 200, child: Text(product["name"].toString())),
            //                 ),
            //                 DataCell(
            //                   Text(
            //                     product["price"].toString(),
            //                     overflow: TextOverflow.ellipsis,
            //                   ),
            //                 ),
            //                 DataCell(
            //                   Text(product["description"].toString()),
            //                 ),
            //                 DataCell(
            //                   Text((product["Stocks"]?['quantity'] ?? "0").toString()),
            //                 ),
            //                 DataCell(
            //                   Text((product["Stocks"]?['minQuantity'] ?? "0").toString()),
            //                 ),
            //                 DataCell(
            //                   Container(
            //                     alignment: Alignment.topLeft,
            //                     width: 100,
            //                     height: 100,
            //                     child: Padding(
            //                       padding: const EdgeInsets.all(4),
            //                       child: CachedNetworkImage(
            //                         imageUrl: (product["Images"]?['url'] ?? "").toString(),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 DataCell(
            //                   Text((product["Categories"]['name']).toString()),
            //                 ),
            //                 DataCell(
            //                   Text((product["Outlets"]?['name'] ?? "All").toString()),
            //                 ),
            //                 DataCell(
            //                   Row(
            //                     children: [
            //                       IconButton(
            //                         icon: Icon(
            //                           Icons.edit,
            //                           color: Colors.deepPurple,
            //                         ),
            //                         onPressed: () {},
            //                       ),
            //                       IconButton(
            //                         icon: Icon(Icons.delete, color: Colors.pink),
            //                         onPressed: () {
            //                           Get.dialog(
            //                             AlertDialog(
            //                               title: Text("Delete"),
            //                               content: Text("Are you sure?"),
            //                               actions: [
            //                                 MaterialButton(
            //                                   child: Text("Yes"),
            //                                   onPressed: () async {
            //                                     final del = await UtilHttp.productDelete(product["id"]);
            //                                     final result = jsonDecode(del.body);
            //                                     Get.back();
            //                                     if (result['success']) {
            //                                       EasyLoading.showSuccess("Delete Success");
            //                                       UtilLoad.product();
            //                                     } else {
            //                                       EasyLoading.showError("Delete Failed");
            //                                     }
            //                                   },
            //                                 ),
            //                                 MaterialButton(
            //                                   child: Text("No"),
            //                                   onPressed: () {
            //                                     Get.back();
            //                                   },
            //                                 ),
            //                               ],
            //                             ),
            //                           );
            //                         },
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //         ],
            //       ),
            //   ),
            // ),
      ),
    );
  }
}
