import 'package:flutter/material.dart';

import '../utils/util_routers.dart';

class CompAppBar extends StatelessWidget {
  const CompAppBar({Key? key, this.title, this.surfix}) : super(key: key);
  final String? title;
  final Widget? surfix;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: BackButton(
              onPressed: () => UtilRoutes.home().go(),
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
          Expanded(
            child: surfix.toString() == "null" 
            ? Container() : surfix!),
        ],
      ),
    );
  }
}
