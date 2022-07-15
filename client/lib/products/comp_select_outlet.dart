import 'package:client/utils/g_val.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/util_value.dart';

class CompSelectOutlet extends StatelessWidget {
  CompSelectOutlet({Key? key, required this.onSelect}) : super(key: key);
  final Function(Map) onSelect;
  final listOutlet = [].obs;
  final _value = {}.obs;
  final _muncul = false.obs;

  _onLoad() {
    listOutlet.add(
      {
        "id": null,
        "name": "All Outlet",
      },
    );

    listOutlet.addAll(GVal.outlets.value.val);
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();

    return Obx(
      () => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ink(
              color: Colors.white,
              child: ListTile(
                trailing: const Icon(Icons.arrow_drop_down),
                onTap: () => _muncul.value = !_muncul.value,
                title: Text(_value["name"] ?? "Select Outlet"),
              ),
            ),
            Visibility(
              visible: _muncul.value,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final out in listOutlet)
                    Ink(
                      color: _value["id"] == out["id"] ? Colors.grey.shade200 : Colors.white,
                      child: ListTile(
                        title: Text(
                          out['name'],
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        onTap: () {
                          _value.value = out;
                          onSelect(out);
                          _muncul.value = false;
                        },
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
