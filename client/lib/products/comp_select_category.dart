import 'package:client/utils/g_val.dart';
import 'package:client/utils/util_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/util_routers.dart';

class CompSelectCategory extends StatelessWidget {
  CompSelectCategory({Key? key, required this.onSelect}) : super(key: key);
  final Function(Map) onSelect;
  final _listCategory = [].obs;
  final _value = {}.obs;
  final _visible = false.obs;


  _onLoad(){
    _listCategory.assignAll(GVal.categories.value.val);
  }
  @override
  Widget build(BuildContext context) {
    _onLoad();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => _listCategory.isEmpty
            ? const ListTile(
                title: Text("No Category Please Create Category"),
              )
            : Ink(
              color: Colors.white,
              child: Column(
                  children: [
                    ListTile(
                      onTap: () => _visible.value = !_visible.value,
                      title: Text(_value['name'] ?? "Select Category"),
                      trailing: const Icon(Icons.arrow_drop_down),
                    ),
                    Visibility(
                      visible: _visible.value,
                      child: Column(
                        children: [
                          for (final cat in _listCategory)
                            Ink(
                              color: _value['id'] == cat['id'] ? Colors.blue : Colors.white,
                              child: ListTile(
                                title: Text(cat['name'], style: TextStyle(
                                  color: Colors.grey.shade300,
                                ),),
                                onTap: () {
                                  _value.value = cat;
                                  onSelect(cat);
                                  _visible.value = false;
                                },
                              ),
                            )
                        ],
                      ),
                    )
                  ],
                ),
            ),
      ),
    );

    // UtilValue.categories.isEmpty
    //     ? Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Center(
    //           child: MaterialButton(
    //             color: Colors.blue,
    //             onPressed: () => UtilRoutes.categoryPage().go(),
    //             child: const Text(
    //               'Category Is Empty , Create One?',
    //               style: TextStyle(color: Colors.white),
    //             ),
    //           ),
    //         ),
    //       )
    //     :  Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child:
    //   DropdownButtonFormField<Map>(
    //     decoration: const InputDecoration(
    //         labelText: "Category",
    //         hintText: "Choose Category",
    //         fillColor: Colors.white,
    //         filled: true,
    //         border: OutlineInputBorder(borderSide: BorderSide.none)),
    //     items: [
    //       for (final cat in UtilValue.categories)
    //         DropdownMenuItem(
    //           value: cat,
    //           child: Text(
    //             cat['name'].toString(),
    //           ),
    //         )
    //     ],
    //     onChanged: (value) {
    //       onSelect(value!);
    //     },
    //   ),
    // );
  }
}
