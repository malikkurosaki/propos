import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/cashiers/cashier_fun.dart';
import 'package:client/comps/comp_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CashierSearch extends StatelessWidget {
  CashierSearch({Key? key, required this.value}) : super(key: key);
  final searchController = TextEditingController();
  final listTempSearch = [].obs;
  final List value;
  final historySearch = [].val("historySearch").obs;

  _refreshList() {
    if (value.isNotEmpty) {
      listTempSearch.value = List.from(value);
    }
  }

  _onload() {
    _refreshList();
  }

  _dialogSearch(BuildContext context) {
    searchController.clear();
// search dialog
    showBottomSheet(
      context: context,
      builder: (context) => Material(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ListView(
            controller: ScrollController(),
            children: [
              CompAppBar(title: "search", onBack: () => Get.back()),
              const SizedBox(height: 8),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search",
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      listTempSearch.value = List.from(value);
                    },
                  ),
                ),
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    final hasil = value
                        .where((element) =>
                            element['name'].toString().toLowerCase().contains(val.toString().toLowerCase()))
                        .toList();

                    debugPrint(hasil.toString());
                    if (hasil.isNotEmpty) {
                      listTempSearch.assignAll(hasil);
                    } else {
                      listTempSearch.value = [];
                    }
                  } else {
                    _refreshList();
                  }
                },
              ),
              const SizedBox(height: 8),
              // history search
              for (final hs in historySearch.value.val)
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text(hs['name'].toString()),
                  onTap: () {
                    searchController.text = hs['name'].toString();
                    listTempSearch.assignAll(value
                        .where((element) =>
                            element['name'].toString().toLowerCase().contains(hs['name'].toString().toLowerCase()))
                        .toList());
                  },
                ),
              const SizedBox(height: 8),
              Obx(
                () => Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 2,
                  runSpacing: 2,
                  children: [
                    for (var item in listTempSearch)
                      InkWell(
                        onTap: () {
                          CashierFun.addQty(item);
                          if (!historySearch.value.val.contains(item)) {
                            historySearch.value.val.add(item);
                            historySearch.refresh();
                          }
                          _refreshList();
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          width: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                                imageUrl: (item['Images']?['url'] ?? ""),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: TextStyle(fontSize: 9),
                                      maxLines: 2,
                                    ),
                                    Text(
                                      item['price'].toString(),
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
    );
  }

  @override
  Widget build(BuildContext context) {
    _onload();
    return Padding(
      padding: const EdgeInsets.all(12),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(onPressed: () => _dialogSearch(context), icon: const Icon(Icons.search)),
      ),
    );
  }
}
