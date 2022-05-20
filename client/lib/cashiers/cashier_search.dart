import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart' as anido;
import '../utils/util_pref.dart';

class CashierSearch extends StatelessWidget {
  CashierSearch({Key? key}) : super(key: key);
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(
            onPressed: () {
              final listTempSearch = [].obs;
              searchController.clear();
              // search dialog
              Get.dialog(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        anido.ElasticInDown(
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                            radius: 24,
                                            backgroundColor: Colors.orange,
                                            child: BackButton(
                                              color: Colors.white,
                                            )),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: searchController,
                                            onChanged: (value) {
                                              listTempSearch.assignAll(UtilPref.listMenu.where(
                                                  (p0) => p0['title'].toLowerCase().contains(value.toLowerCase())));
                                            },
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.search),
                                              labelText: "Search",
                                              fillColor: Colors.grey[100],
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(28),
                                                  borderSide: BorderSide(color: Colors.white)),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(28),
                                                  borderSide: BorderSide(color: Colors.white)),
                                              suffixIcon: IconButton(
                                                icon: Icon(Icons.close),
                                                onPressed: () {
                                                  searchController.clear();
                                                  UtilPref.searchSet(value: "");
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Flexible(
                          child: Obx(
                            () => listTempSearch.isEmpty
                                ? // display list history search
                                Card(
                                    child: ListView.builder(
                                      itemCount: UtilPref.listHistorySearch.length,
                                      itemBuilder: (context, idxx) {
                                        return ListTile(
                                          onTap: () {
                                            final itm = UtilPref.listHistorySearch[idxx];
                                            final idx = UtilPref.listorder
                                                .indexWhere((element) => element['title'] == itm['title']);
                                            if (idx == -1) {
                                              itm['qty'] = 1;
                                              itm['note'] = "";
                                              UtilPref.listorder.add(itm);
                                            } else {
                                              UtilPref.listorder[idx]['qty'] = UtilPref.listorder[idx]['qty'] + 1;
                                            }

                                            UtilPref.lastClick.value = itm;
                                            UtilPref.listorderSet(value: List.from(UtilPref.listorder));
                                            searchController.clear();
                                            Get.back();
                                          },
                                          title: Text(UtilPref.listHistorySearch[idxx]['title'].toString()),
                                        );
                                      },
                                    ),
                                  )
                                : Card(
                                    child: ListView.builder(
                                      itemCount: listTempSearch.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            ListTile(
                                              title: Text(listTempSearch[index]['title']),
                                              onTap: () {
                                                final itm = listTempSearch[index];
                                                final idx = UtilPref.listorder
                                                    .indexWhere((element) => element['title'] == itm['title']);
                                                if (idx == -1) {
                                                  itm['qty'] = 1;
                                                  itm['note'] = "";
                                                  UtilPref.listorder.add(itm);
                                                } else {
                                                  UtilPref.listorder[idx]['qty'] = UtilPref.listorder[idx]['qty'] + 1;
                                                }

                                                UtilPref.lastClick.value = itm;
                                                UtilPref.listorderSet(value: List.from(UtilPref.listorder));
                                                searchController.clear();

                                                // detect if exist in history search
                                                if (UtilPref.listHistorySearch
                                                        .indexWhere((element) => element['title'] == itm['title']) ==
                                                    -1) {
                                                  UtilPref.listHistorySearch.add(itm);
                                                  UtilPref.listHistorySearchSet(
                                                      value: List.from(UtilPref.listHistorySearch));
                                                }

                                                Get.back();
                                              },
                                            ),
                                            Divider()
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            icon: Icon(Icons.search)),
      ),
    );
  }
}
