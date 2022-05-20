import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/util_pref.dart';

class CompSelectOutlet extends StatelessWidget {
  CompSelectOutlet({ Key? key, required this.onSelect }) : super(key: key);
  final Function(Map) onSelect;
  final listOutlet = [].obs;

  _onLoad(){
    listOutlet.add({
      "id": null,
      "name": "All Outlet",
    });

    listOutlet.addAll(UtilPref.outlets);
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<Map>(
        decoration: InputDecoration(
            labelText: "Outlet",
            hintText: "Choose Outlet",
            fillColor: Colors.grey[100],
            filled: true,
            border: const OutlineInputBorder(borderSide: BorderSide.none)),
        items: [
          for (final out in listOutlet)
            DropdownMenuItem(
                value: out,
                child: Text(
                  out['name'],
                ))
        ],
        onChanged: (value) {
          onSelect(value!);
        },
      ),
    );
  }
}