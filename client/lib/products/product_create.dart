import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/products/comp_form_create_product.dart';
import 'package:client/products/comp_image_picker.dart';
import 'package:client/products/comp_stock.dart';
import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_load.dart';
import 'package:client/utils/util_pref.dart';
import 'package:client/utils/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProductCreate extends StatelessWidget {
  ProductCreate({Key? key, this.product}) : super(key: key);
  final Map? product;

  final customPrice = false.obs;
  final withImage = false.obs;

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final stockController = TextEditingController();
  final imageController = TextEditingController();
  final outletController = TextEditingController();
  final categoryController = TextEditingController();

  final body = {};

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return ListView(
          children: [
            Wrap(
              children: [
                // todo disini form  ,
                CompFormCreateProduct(
                  onNameChange: (name) => body["name"] = name,
                  onPriceChange: (price) => body["price"] = price,
                  onDescriptionChange: (description) => body["description"] = description,
                  onCategoryChange: (category) => body["categoriesId"] = category["id"],
                  onOutletChange: (outlet) => body["outletsId"] = outlet["id"],
                ),
                CompImagePicker(onImageNameChange: (value) => body["image"] = value),
                CompStock(
                  onMinStockChange: (minStock) => body["minStock"] = minStock,
                  onStockChange: (stock) => body["stock"] = stock,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                width: sizingInformation.isMobile ? double.infinity : 360,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () async {
                      if (body["name"] == null ||
                          body["price"] == null ||
                          body["categoriesId"] == null ) {
                        EasyLoading.showError('Please fill all field, name, price, description, category, outlet');
                        return;
                      }

                      try {
                        Get.dialog(AlertDialog(
                          title: Text("Are you sure?"),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Are you sure to create this product?"),
                              Divider(),
                              Text("Name: ${body["name"]}"),
                              Text("Price: ${body["price"]}"),
                              Text("Description: ${body["description"]}"),
                              Text("Category: ${body["categoriesId"]}"),
                              Text("Outlet: ${body["outletsId"]}"),
                              Text("Image: ${body["image"]}"),
                              Text("Min Stock: ${body["minStock"]}"),
                              Text("Stock: ${body["stock"]}"),

                            ],
                          ),
                          actions: [
                            MaterialButton(
                              child: Text("Cancel"),
                              onPressed: () => Get.back(),
                            ),
                            MaterialButton(
                              child: Text("Yes"),
                              onPressed: () async {
                                final res = await UtilHttp.productCreate(body);
                                if (res.statusCode == 200) {
                                  EasyLoading.showSuccess('Product created');
                                  UtilLoad.product(isAler: true);
                                  Get.back();
                                } else {
                                  EasyLoading.showError('Failed to create product');
                                }
                              },
                            ),
                          ],
                        ));

                      
                      } catch (e) {
                        print(e.toString());
                        EasyLoading.showError(e.toString());
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Center(
                        child: Text(
                          "Add Product",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
