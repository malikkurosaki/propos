import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_load.dart';
import 'package:client/utils/util_pref.dart';
import 'package:client/utils/util_val.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProductTable extends StatelessWidget {
  const ProductTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // table product UtilPref.products
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Obx(
              () => UtilPref.products.isEmpty
                  ? MaterialButton(
                      color: Colors.blue,
                      onPressed: () {
                        UtilPref.indexProductPageSet(value: 1);
                      },
                      child: Text(
                        "Product empty",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FittedBox(
                        child: Card(
                          child: DataTable(
                            headingRowColor: MaterialStateProperty.all<Color>(Colors.blue),
                            headingTextStyle: TextStyle(color: Colors.white),
                            // dataRowColor: MaterialStateProperty.all(Colors.grey[100]),
                            columns: [
                              DataColumn(
                                label: Text("#"),
                              ),
                              DataColumn(
                                label: Text("name".toUpperCase()),
                              ),
                              DataColumn(
                                label: Text("price".toUpperCase()),
                              ),
                              DataColumn(
                                label: Text("description".toUpperCase()),
                              ),
                              DataColumn(
                                label: Text("stock".toUpperCase()),
                              ),
                              DataColumn(
                                label: Text("min stock".toUpperCase()),
                              ),
                              DataColumn(
                                label: Text("image".toUpperCase()),
                              ),
                              DataColumn(
                                label: Text("category".toUpperCase()),
                              ),
                              DataColumn(
                                label: Text("outlet".toUpperCase()),
                              ),
                              DataColumn(label: Text("action".toUpperCase())),
                            ],
                            rows: [
                              for (var product in UtilPref.products)
                                DataRow(
                                  cells: [
                                    DataCell(
                                      Text((UtilPref.products.indexOf(product) + 1).toString()),
                                    ),
                                    DataCell(
                                      Text(product["name"].toString()),
                                    ),
                                    DataCell(
                                      Text(product["price"].toString()),
                                    ),
                                    DataCell(
                                      Text(product["description"].toString()),
                                    ),
                                    DataCell(
                                      Text((product["Stocks"]?['quantity'] ?? "0").toString()),
                                    ),
                                    DataCell(
                                      Text((product["Stocks"]?['minQuantity'] ?? "0").toString()),
                                    ),
                                    DataCell(
                                      Container(
                                        alignment: Alignment.topLeft,
                                        width: 100,
                                        height: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: CachedNetworkImage(
                                            imageUrl: UtilHttp.urlImageWithUser +
                                                (product["Images"]?['url'] ?? "").toString(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text((product["Categories"]['name']).toString()),
                                    ),
                                    DataCell(
                                      Text((product["Outlets"]?['name'] ?? "All").toString()),
                                    ),
                                    DataCell(
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.deepPurple,
                                            ),
                                            onPressed: () {},
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete, color: Colors.pink),
                                            onPressed: () {
                                              Get.dialog(
                                                AlertDialog(
                                                  title: Text("Delete"),
                                                  content: Text("Are you sure?"),
                                                  actions: [
                                                    MaterialButton(
                                                      child: Text("Yes"),
                                                      onPressed: () async {
                                                        final del = await UtilHttp.productDelete(product["id"]);
                                                        final result = jsonDecode(del.body);
                                                        Get.back();
                                                        if (result['success']) {
                                                          EasyLoading.showSuccess("Delete Success");
                                                          UtilLoad.product();
                                                        } else {
                                                          EasyLoading.showError("Delete Failed");
                                                        }
                                                      },
                                                    ),
                                                    MaterialButton(
                                                      child: Text("No"),
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                    ),
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
                        ),
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
