import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeSubInfo extends StatelessWidget {
  const HomeSubInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        color: Colors.blueGrey[100],
        child: Container(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              Text(
                "Dapatkan penghasilan tambahan dengan menjadi partner Afiliasi Propos".toUpperCase(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey),
              ),
              const Text(
                """
Dapatkan penghasilan hingga Rp 1 juta per customer hanya dengan mempromosikan Propos
kepada siapa pun yang Anda kenal.
""",
                style: TextStyle(color: Colors.grey),
              ),
              const Divider(
                thickness: 2,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(8),
                color: Colors.blueGrey[50],
                child: const Text(
                    "Pasangkan banner Propos di situs Anda pada posisi yang mudah terlihat dengan turut membawa kode unik partner Anda."),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(8),
                color: Colors.blueGrey[50],
                child: const Text(
                    "Bagikan informasi produk Propos melalui sosial media seperti Facebook, Instagram dan lain-lain dengan menyertakan kode unik partner Anda."),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(8),
                color: Colors.blueGrey[50],
                child: const Text(
                    "Bagikan link beserta kode unik partner Anda kepada teman-teman melalui chat di BBM, Whatsapp, Line, dsb."),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(8),
                color: Colors.blueGrey[50],
                child: const Text("Sebarkan promosi Propos beserta link Anda kepada kontak email Anda."),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(8),
                color: Colors.blueGrey[50],
                child: const Text(
                    "Bagikan kepada tim Propos calon pengguna yang Anda kenal berupa nama, no contact dan kebutuhan. Tim kami akan menghubungi mereka dan mendaftarkannya ke dalam akun partner Anda."),
              )
            ],
          ),
        ),
      ),
    );
  }
}
