import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart' as animdo;
import 'util_pref.dart';

class CashierSubOrderOptionPanel extends StatelessWidget {
  const CashierSubOrderOptionPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ExpansionTile(
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.pink,
                child: Icon(
                  Icons.groups,
                  color: Colors.white,
                ),
              ),
              label: Text(
                UtilPref.pax.value.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey
                ),
              ),
              backgroundColor: Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
            Chip(
              label: Text(
                UtilPref.customer['name'] ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey
                ),
              ),
              backgroundColor: Colors.white,
              avatar: Icon(
                Icons.account_circle_rounded,
                color: Colors.green[300],
              ),
            ),
          ],
        ),
        iconColor: Colors.brown,
        textColor: Colors.brown,
        collapsedBackgroundColor: Colors.pink[100],
        backgroundColor: Colors.pink[300],
        title: Text(
          "Order Options".toUpperCase(),
          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.pink,
                  child: Icon(
                    Icons.groups_sharp,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "PAX COUNT",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              animdo.ElasticInDown(
                child: MaterialButton(
                    color: Colors.white,
                    child: Icon(
                      Icons.add_circle,
                      color: Colors.cyan[300],
                      size: 32,
                    ),
                    onPressed: () {
                      UtilPref.paxSet(value: (UtilPref.pax.value + 1));
                    }),
              ),
              SizedBox(
                width: 20,
              ),
              animdo.ElasticInDown(
                child: MaterialButton(
                    color: Colors.white,
                    child: Icon(
                      Icons.remove_circle,
                      size: 32,
                      color: Colors.cyan[300],
                    ),
                    onPressed: () {
                      if (UtilPref.pax.value > 1) {
                        UtilPref.paxSet(value: (UtilPref.pax.value - 1));
                      }
                    }),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          animdo.ZoomIn(
            child: Card(
              elevation: 0,
              color: Colors.white,
              child: ListTile(
                leading: Icon(
                  Icons.account_circle_sharp,
                  color: Colors.green,
                ),
                title: Text(
                  UtilPref.customer['name'] ?? "Select Customer",
                  style: TextStyle(color: Colors.green),
                ),
                onTap: () {
                  // dialog search and select customer
                  final search = "".obs;
                  final listCustomer = List.from(UtilPref.listCustomer).obs;
                  Get.dialog(
                    Dialog(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                    backgroundColor: Colors.orange,
                                    child: BackButton(
                                      color: Colors.white,
                                    )),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Select Customer"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.red[300],
                                  child: IconButton(
                                      onPressed: () {
                                        UtilPref.customerSet(value: {});
                                        Get.back();
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      )),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onChanged: (value) {
                                listCustomer.assignAll(List.from(UtilPref.listCustomer).where((element) =>
                                    element['name'].toString().toLowerCase().contains(value.toLowerCase())));
                              },
                              controller: TextEditingController(),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.grey[100],
                                  filled: true,
                                  hintText: "eg: gunawan",
                                  prefixIcon: Icon(Icons.search)),
                            ),
                          ),
                          Flexible(
                            child: Obx(
                              () => GridView.extent(
                                childAspectRatio: 12 / 8,
                                maxCrossAxisExtent: Get.width * 0.2,
                                children: [
                                  for (final cus in listCustomer)
                                    InkWell(
                                      onTap: () {
                                        UtilPref.customerSet(value: cus);
                                        Get.back();
                                      },
                                      child: Card(
                                        color: Colors.green[100],
                                        child: Column(
                                          children: [
                                            Flexible(
                                              child: Center(
                                                child: Icon(
                                                  Icons.account_circle,
                                                  size: 70,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    cus['name'].toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.brown,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(cus['phone'].toString()),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                trailing: Icon(Icons.arrow_drop_down_circle_rounded, color: Colors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
