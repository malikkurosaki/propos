import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'utils/util_pref.dart';
import 'utils/util_routers.dart';
import 'package:get/get.dart';

final listWellcome = [
  {
    "title": "Go Online",
    "sub": "Temukan Aplikasi Kasir Premium yang membawa bisnis Anda Go-Online",
  },
  {
    "title": "Kemudahan Maksimal",
    "sub": "Satu-satunya Aplikasi Kasir yang memberikan dukungan kemudahan yang maksimal untuk semua pemilik toko",
  },
  {
    "title": "Fiture Lengkap",
    "sub":
        "aplikasi kasir dengan fitur terlengkap di kelasnya. Komitmen kami untuk menghadirkan keuntungan dan manfaat yang maksimal,",
  }
];

final listColor = [
  Colors.cyan[200],
  Colors.green[200],
  Colors.yellow[200],
];

final listIcon = [
  Icons.online_prediction,
  Icons.smart_toy_outlined,
  Icons.all_inclusive_outlined,
];

class WellcomePage extends StatelessWidget {
  const WellcomePage({Key? key}) : super(key: key);

  _onload()async{
    await 0.1.delay();
    UtilPref.wellcomeSet(false);
    UtilRoutes.root().goOff();
  }

  @override
  Widget build(BuildContext context) {
    _onload();
    return ResponsiveBuilder(
      builder: (a, b) => SafeArea(
        child: Center(
          child: Text("loading"),
        )
        // Stack(
        //   children: [
        //     SizedBox(
        //       width: double.infinity,
        //       height: double.infinity,
        //       child: Image.asset('assets/images/bg2.jpg', fit: BoxFit.cover),
        //     ),
        //     SizedBox.expand(
        //         child: BackdropFilter(
        //       filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        //       child: Container(
        //         color: Colors.black.withOpacity(0.5),
        //       ),
        //     )),
        //     Positioned.fill(
        //       child: BackdropFilter(
        //         filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        //         child: Container(
        //           color: Colors.black.withOpacity(0.1),
        //         ),
        //       ),
        //     ),
        //     PageView(
        //       children: [
        //         for (var i = 0; i < listWellcome.length; i++)
        //           Container(
        //             decoration: BoxDecoration(
        //               gradient: LinearGradient(
        //                 colors: [
        //                   listColor[i]!,
        //                   Colors.black.withOpacity(0.5),
        //                 ],
        //                 begin: Alignment.topCenter,
        //                 end: Alignment.bottomCenter,
        //               ),
        //             ),
        //             child: Center(
        //               child: Container(
        //                 constraints: BoxConstraints(maxWidth: 500),
        //                 child: Column(
        //                   children: [
        //                     Flexible(
        //                       child: Column(
        //                         children: [
        //                           SizedBox(
        //                             height: 50,
        //                           ),
        //                           Icon(
        //                             listIcon[i],
        //                             size: 100,
        //                             color: Colors.white,
        //                           ),
        //                           SizedBox(
        //                             height: 50,
        //                           ),
        //                           Padding(
        //                             padding: const EdgeInsets.all(24),
        //                             child: Text(
        //                               listWellcome[i]["title"].toString(),
        //                               style: TextStyle(fontSize: 30, color: Colors.white),
        //                             ),
        //                           ),
        //                           SizedBox(
        //                             height: 10,
        //                           ),
        //                           Padding(
        //                             padding: const EdgeInsets.all(24),
        //                             child: Text(
        //                               listWellcome[i]["sub"].toString(),
        //                               textAlign: TextAlign.center,
        //                               style: TextStyle(fontSize: 20, color: Colors.white),
        //                             ),
        //                           ),
        //                           SizedBox(
        //                             height: 50,
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                     Visibility(
        //                         visible: i == listWellcome.length - 1,
        //                         child: Container(
        //                           padding: EdgeInsets.all(10),
        //                           child: MaterialButton(
        //                             color: Colors.cyan,
        //                             onPressed: () {
        //                               UtilPref.wellcomeSet(false);
        //                               UtilRoutes.root().goOff();
        //                             },
        //                             child: Container(
        //                               width: double.infinity,
        //                               padding: EdgeInsets.all(14),
        //                               child: Center(
        //                                 child: Text(
        //                                   'NEXT',
        //                                   style: TextStyle(color: Colors.white, fontSize: 18),
        //                                 ),
        //                               ),
        //                             ),
        //                           ),
        //                         ))
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //       ],
        //     ),
        //     Align(
        //       alignment: Alignment.bottomLeft,
        //       child: Row(
        //         children: [
        //           for(final a in [1,2,3])
        //             Container(
        //               margin: EdgeInsets.all(10),
        //               decoration: BoxDecoration(
        //                 color: Colors.white,
        //                 borderRadius: BorderRadius.circular(10),
        //               ),
        //               child: Container(
        //                 width: 10,
        //                 height: 10,
        //                 decoration: BoxDecoration(
        //                   color: a == 1? Colors.cyan: Colors.white,
        //                   borderRadius: BorderRadius.circular(10),
        //                 ),
        //               ),
        //             ),
        //         ],
        //       ),
        //     )
        //   ],
        // ),
      ),
    );
  }
}
