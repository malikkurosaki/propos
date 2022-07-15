import 'package:client/utils/g_val.dart';
import 'package:client/utils/util_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CompSaveOrder extends StatelessWidget {
  CompSaveOrder({Key? key}) : super(key: key);
  final nameSaveOrder = "".obs;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: IconButton(
          onPressed: () {
            if (GVal.listOrders.value.val.isEmpty) {
              EasyLoading.showToast("Your order is empty");
              return;
            }

            if (GVal.savedOrder.value.val.isNotEmpty) {
              final index =
                  UtilValue.listSaveOrder.indexWhere((element) => element['id'] == GVal.savedOrder.value.val['id']);

              // final data = {
              //   "id": Uuid().v4(),
              //   "name": nameSaveOrder.value,
              //   "order": List.from(UtilPref.listorder),
              //   "pax": UtilPref.pax.value,
              //   "customer": Map.from(UtilPref.customer),
              //   "date": DateTime.now().toString()
              // };

              GVal.savedOrder.value.val["order"] = List.from(GVal.listOrders.value.val);
              GVal.savedOrder.value.val["pax"] = GVal.pax.value.val;
              GVal.savedOrder.value.val["customer"] = Map.from(GVal.customer.value.val);
              UtilValue.listSaveOrder[index] = Map.from(GVal.savedOrder.value.val);
              UtilValue.listSaveOrderSet(value: List.from(UtilValue.listSaveOrder));

              EasyLoading.showToast("data updated");
              return;
            }

            Get.dialog(
              AlertDialog(
                backgroundColor: Colors.teal,
                title: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Are you sure to save this order?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        onChanged: (value) => nameSaveOrder.value = value,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.teal[100],
                          filled: true,
                          labelText: "Order Name",
                        ),
                        controller: TextEditingController(
                            text: GVal.listOrders.value.val.isNotEmpty ? GVal.listOrders.value.val[0]['name'] : ""),
                      ),
                    )
                  ],
                ),
                actions: [
                  MaterialButton(
                    color: Colors.teal[800],
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      // check is empty name
                      if (nameSaveOrder.value.isEmpty) {
                        EasyLoading.showError("Please fill order name");
                        return;
                      }

                      // check duplicate name
                      if (UtilValue.listSaveOrder.any((element) => element['name'] == nameSaveOrder.value)) {
                        EasyLoading.showError("Order name already exist");
                        return;
                      }

                      if (GVal.listOrders.value.val.isEmpty) {
                        EasyLoading.showError("Please add order");
                        return;
                      }

                      final data = {
                        "id": const Uuid().v4(),
                        "name": nameSaveOrder.value,
                        "order": List.from(GVal.listOrders.value.val),
                        "pax": GVal.pax.value.val,
                        "customer": Map.from(GVal.customer.value.val),
                        "date": DateTime.now().toString()
                      };

                      EasyLoading.show(status: "Saving...");
                      UtilValue.listSaveOrder.add(data);
                      UtilValue.listSaveOrderSet();
                      GVal.listOrders.value.val =  [];
                      GVal.listOrders.refresh();
                      
                      EasyLoading.showSuccess("Save order success");

                      Get.back();
                    },
                  ),
                  MaterialButton(
                    color: Colors.teal[300],
                    child: const Text(
                      "No",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      EasyLoading.showToast("Baek lah, ga jadi ...");
                      Get.back();
                    },
                  ),
                ],
              ),
            );
          },
          icon: Icon(GVal.savedOrder.value.val.isEmpty ? Icons.save : Icons.update, color: Colors.cyan)),
    );
  }
}
