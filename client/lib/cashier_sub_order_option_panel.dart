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
      () => Tooltip(
        message: "Show Order Options",
        child: ExpansionTile(
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (UtilPref.pax.value.toString()),
              ),
              Text(
                UtilPref.customer['name'] ?? "",
              ),
            ],
          ),
          iconColor: Colors.green,
          textColor: Colors.green,
          collapsedBackgroundColor: Colors.green[100],
          backgroundColor: Colors.green[50],
          title: Text(
            "Order Options",
            style: TextStyle(fontSize: 16, color: Colors.green),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_circle),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("PAX COUNT"),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                animdo.ElasticInDown(
                  child: MaterialButton(
                      color: Colors.green[100],
                      child: Text(
                        "+",
                        style: TextStyle(fontSize: 24),
                      ),
                      onPressed: () {
                        UtilPref.paxSet(value: (UtilPref.pax.value + 1));
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    UtilPref.pax.value.toString(),
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
                animdo.ElasticInDown(
                  child: MaterialButton(
                      color: Colors.green[100],
                      child: Text(
                        "-",
                        style: TextStyle(fontSize: 24),
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
                color: Colors.green[100],
                child: ListTile(
                  leading: Icon(
                    Icons.people,
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Select Customer"),
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
                                                        color: Colors.green,
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
      ),
    );
  }
}
