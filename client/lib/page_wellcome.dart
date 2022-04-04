import 'package:client/util_pref.dart';
import 'package:client/util_routers.dart';
import 'package:flutter/material.dart';

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

class PageWellcome extends StatelessWidget {
  const PageWellcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Container(
              color: Colors.grey[100],
              child: Column(
                children: [
                  Flexible(
                    child: PageView(
                      children: [
                        for (var i = 0; i < listWellcome.length; i++)
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  listColor[i]!,
                                  Colors.pink.withOpacity(0.5),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Column(
                              children: [
                                Flexible(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Icon(
                                        listIcon[i],
                                        size: 100,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(24),
                                        child: Text(
                                          listWellcome[i]["title"].toString(),
                                          style: TextStyle(fontSize: 30, color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(24),
                                        child: Text(
                                          listWellcome[i]["sub"].toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 20, color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: i == listWellcome.length - 1,
                                    child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: MaterialButton(
                                    onPressed: () {
                                      UtilPref.wellcomeSet(false);
                                      UtilRoutes.root().goOff();
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(14),
                                      child: Center(
                                        child: Text(
                                          'NEXT',
                                          style: TextStyle(color: Colors.white, fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
