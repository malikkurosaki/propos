import 'package:client/comps/comp_app_bar.dart';
import 'package:client/utils/g_val.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'comp_calculator.dart';

class CompSelectPax extends StatelessWidget {
  const CompSelectPax({Key? key}) : super(key: key);

  _dialogPax(BuildContext context) async {
    showBottomSheet(
      context: context,
      builder: (context) => BottomSheet(
        onClosing: () {},
        builder: (context) => Container(
          color: Colors.grey.shade100,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              CompAppBar(title: 'PAX'),
              Flexible(
                child: CompCalculator(
                  defaultValue: GVal.pax.value.val.toString(),
                  onChange: (p0) {
                    GVal.pax.value.val = int.parse(p0);
                    GVal.pax.refresh();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    alignment: Alignment.center,
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    // Get.dialog(
    //   Dialog(
    //     child: ResponsiveBuilder(
    //       builder: (context, sizingInformation) => SizedBox(
    //         width: sizingInformation.isMobile ? Get.width - 80 : Get.width * 0.3,
    //         height: sizingInformation.isMobile ? Get.width - 80 : Get.width * 0.4,
    //         child:
    //         Column(
    //           children: [
    //             Flexible(
    //               child: CompCalculator(
    //                 defaultValue: GVal.pax.value.val.toString(),
    //                 onChange: (p0) {
    //                   GVal.pax.value.val = int.parse(p0);
    //                   GVal.pax.refresh();
    //                 },
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: MaterialButton(
    //                 color: Colors.blue,
    //                 onPressed: () {
    //                   Get.back();
    //                 },
    //                 child: Container(
    //                   padding: const EdgeInsets.all(12),
    //                   alignment: Alignment.center,
    //                   child: const Text(
    //                     "OK",
    //                     style: TextStyle(color: Colors.white),
    //                   ),
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _dialogPax(context),
      leading: Icon(Icons.person, ),
      title: Text(
        GVal.pax.value.val.toString(),
      ),
      subtitle: Text(
        'pax',
      ),
      trailing: Icon(
        Icons.arrow_drop_down
      ),

    );
    // Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: InkWell(
    //     onTap: () => _dialogPax(context),
    //     child: Chip(
    //       avatar: const CircleAvatar(
    //         backgroundColor: Colors.cyan,
    //         child: Icon(
    //           Icons.groups,
    //           color: Colors.white,
    //         ),
    //       ),
    //       label: Container(
    //         padding: const EdgeInsets.all(8),
    //         width: double.infinity,
    //         child: 
    //         Obx(
    //           () => Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text("pax"),
    //               Text(
    //                 GVal.pax.value.val.toString(),
    //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey.shade600),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       backgroundColor: Colors.grey[200],
    //     ),
    //   ),
    // );
  }
}
