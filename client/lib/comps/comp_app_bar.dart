import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/util_routers.dart';

class CompAppBar extends StatelessWidget {
  const CompAppBar({Key? key, this.title = "masukkan nama title", this.surfix, this.onBack}) : super(key: key);
  final String? title;
  final Widget? surfix;
  // final bool? isback;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: BackButton(
              onPressed: () => onBack == null? Get.back(): onBack!()
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              title ?? "",
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
          ),
          Expanded(child: surfix.toString() == "null" ? Container() : surfix!),
        ],
      ),
    );
  }
}
