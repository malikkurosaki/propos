import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class UtilPref {
  static final storage = GetStorage();
  static final wellcome = (storage.read('wellcome') ?? true).toString().obs;
  static final user = Map.from(storage.read('user') ?? {}).obs;
  static final listMenu = List<Map<String, dynamic>>.from(storage.read('listMenu') ?? []).obs;
  static final isGrid = (storage.read('isGrid') ?? true).toString().obs;
  static final listorder = List<Map<String, dynamic>>.from(storage.read('listorder') ?? []).obs;
  static final search = (storage.read('search') ?? '').toString().obs;
  static final lastClick = Map.from(storage.read('lastclick') ?? {}).obs;
  static final listFavorite = List<Map<String, dynamic>>.from(storage.read('listFavorite') ?? []).obs;
  static final showFavorite = ((storage.read('showFavorite') ?? false).toString() == "true").obs;
  static final billId = (storage.read('billId') ??
          () {
            final id = Uuid().v4();
            storage.write('billId', id);
            return id;
          }())
      .toString()
      .obs;

  static wellcomeSet(bool value) {
    wellcome.value = value.toString();
    storage.write('wellcome', value);
  }

  static final bills = List<Map<String, dynamic>>.from(storage.read('bills') ?? []).obs;
  static final listBill = List<Map<String, dynamic>>.from(storage.read('listBill') ?? []).obs;
  static final isCategoryOpen = (storage.read('isCategoryOpen') ?? true).toString().obs;
  static final pax = int.parse((storage.read('pax') ?? 1).toString()).obs;
  static final aspek = double.parse((storage.read('aspek') ?? 10 / 16).toString()).obs;

  static userSet(Map<String, dynamic> value) async {
    user.value = value;
    storage.write('user', value);
  }

  static listMenuSet(List<Map<String, dynamic>> value) async {
    storage.write('listMenu', value);
    listMenu.value = value;
  }

  static isGridSet(bool value) async {
    isGrid.value = value.toString();
    storage.write('isGrid', value);
  }

  static listorderSet(List<Map<String, dynamic>> value) async {
    listorder.value = value;
    storage.write('listorder', value);
  }

  static searchSet(String value) async {
    search.value = value;
    storage.write('search', value);
  }

  static lastClickSet(Map value) async {
    lastClick.value = value;
    storage.write('lastClick', value);
  }

  static listFavoriteSet(List<Map<String, dynamic>> value) async {
    listFavorite.value = value;
    storage.write('listFavorite', value);
  }

  static showFavoriteSet(bool value) async {
    showFavorite.value = value;
    storage.write('showFavorite', value);
  }

  static billIdSet(String value) async {
    if (value == "") {
      final id = Uuid().v4();
      storage.write('billId', id);
    } else {
      storage.write('billId', value);
    }

    billId.value = storage.read('billId');
  }

  static billsSet(List<Map<String, dynamic>> value) async {
    bills.value = value;
    storage.write('bills', value);
  }

  static listBillSet(List<Map<String, dynamic>> value) async {
    listBill.value = value;
    storage.write('listBill', value);
  }

  static isCategoryOpenSet(bool value) async {
    isCategoryOpen.value = value.toString();
    storage.write('isCategoryOpen', value);
  }

  static paxSet(int value) async {
    pax.value = value;
    storage.write('pax', value);
  }

  static aspekSet(double value) async {
    aspek.value = value;
    storage.write('aspek', value);
  }
}
