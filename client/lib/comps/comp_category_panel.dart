import 'package:carousel_slider/carousel_controller.dart';
import 'package:client/comps/comp_app_bar.dart';
import 'package:client/utils/g_val.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';

class CompCategoryHorizontal extends StatelessWidget {
  CompCategoryHorizontal({Key? key, required this.onChange, required this.value}) : super(key: key);
  final Function(Map value) onChange;
  final Map value;
  final _listCategory = [].obs;
  final _chosed = {}.obs;

  _onLoad() async {
    _listCategory.add({"id": null, "name": "All Category"});
    _listCategory.addAll(List.from(GVal.categories.value.val));

    if (value.isNotEmpty) {
      _chosed.assignAll(value);
    }

    _listCategory.refresh();
  }

  _popSelect(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context) => BottomSheet(
        onClosing: () {},
        builder: (context) => Container(
          color: Colors.grey.shade100,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              CompAppBar(
                title: "Select Category",
              ),
              Flexible(
                child: Obx(
                  () => GridView.extent(
                    controller: ScrollController(),
                    maxCrossAxisExtent: GVal.categories.value.val.length > 4 ? 100 : 200,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: [
                      for (final category in _listCategory)
                        MaterialButton(
                          color: _chosed['id'] == category['id'] ? Colors.blue : Colors.grey.shade100,
                          onPressed: () {
                            // GVal.category.value.val = category;
                            // GVal.category.refresh();
                            _chosed.assignAll(Map.from(category));
                            onChange(category);
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            alignment: Alignment.center,
                            child: Text(
                              category['name'].toString(),
                              style: TextStyle(
                                color: _chosed['id'] == category['id'] ? Colors.white : Colors.black,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();

    return Obx(() => ListTile(
          title: Text( _chosed['name'] ?? "All Category"),
          trailing: IconButton(
            icon: Icon(Icons.arrow_drop_down),
            onPressed: () {
              _popSelect(context);
            },
          ),
          onTap: () {
            _popSelect(context);
          },
        ));

    // MaterialButton(
    //   color: Colors.blue,
    //   onPressed: () {
    //     showBottomSheet(
    //       context: context,
    //       builder: (context) => BottomSheet(
    //         onClosing: () {},
    //         builder: (context) => Container(
    //           color: Colors.grey.shade100,
    //           padding: EdgeInsets.all(16),
    //           child: Column(
    //             children: [
    //               CompAppBar(
    //                 title: "Select Category",
    //               ),
    //               Flexible(
    //                 child: Obx(
    //                   () => GridView.extent(
    //                     controller: ScrollController(),
    //                     maxCrossAxisExtent: GVal.categories.value.val.length > 4 ? 100 : 200,
    //                     mainAxisSpacing: 16,
    //                     crossAxisSpacing: 16,
    //                     children: [
    //                       for (final category in _listCategory)
    //                         MaterialButton(
    //                           color: _chosed['id'] == category['id'] ? Colors.blue : Colors.grey.shade100,
    //                           onPressed: () {
    //                             // GVal.category.value.val = category;
    //                             // GVal.category.refresh();
    //                             _chosed.assignAll(Map.from(category));
    //                             onChange(category);
    //                             Get.back();
    //                           },
    //                           child: Container(
    //                             padding: const EdgeInsets.all(12),
    //                             alignment: Alignment.center,
    //                             child: Text(
    //                               category['name'].toString(),
    //                               style: TextStyle(
    //                                 color: _chosed['id'] == category['id'] ? Colors.white : Colors.black,
    //                                 fontSize: 24,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                     ],
    //                   ),
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    //   child: Container(
    //     width: 150,
    //     child: Row(
    //       mainAxisSize: MainAxisSize.min,
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text(
    //           _chosed['name'] ?? "Select Category",
    //           overflow: TextOverflow.ellipsis,
    //           style: TextStyle(color: Colors.white),
    //         ),
    //         Icon(
    //           Icons.arrow_drop_down,
    //           color: Colors.white,
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    // ListView(
    //   scrollDirection: Axis.horizontal,
    //   children: [
    //     Text("ini Ada dimana")
    //   ],
    // );
  }
}
