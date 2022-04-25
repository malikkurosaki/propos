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
  static final billId = (storage.read('billId') ?? Uuid().v4()).toString().obs;
  static wellcomeSet(bool value) {
    wellcome.value = value.toString();
    storage.write('wellcome', value);
  }

  static final bills = List<Map<String, dynamic>>.from(storage.read('bills') ?? []).obs;
  static final listBill = List<Map<String, dynamic>>.from(storage.read('listBill') ?? []).obs;
  static final isCategoryOpen = (storage.read('isCategoryOpen') ?? true).toString().obs;
  static final pax = int.parse((storage.read('pax') ?? 1).toString()).obs;
  static final aspek = double.parse((storage.read('aspek') ?? 10 / 16).toString()).obs;
  static final listHistorySearch = List<Map<String, dynamic>>.from(storage.read('listHistorySearch') ?? []).obs;
  static final listSaveOrder = List<Map<String, dynamic>>.from(storage.read('listSaveOrder') ?? []).obs;
  static final customer = Map.from(storage.read('customer') ?? {}).obs;
  static final listCustomer = List.from(storage.read("listCustomer") ?? []).obs;
  static final savedOrder = Map.from(storage.read('savedOrder') ?? {}).obs;

  static userSet({Map<String, dynamic>? value}) async {
    if (value != null) {
      user.value = value;
      storage.write('user', value);
    } else {
      storage.write('user', Map.from(user));
    }
  }

  static listMenuSet({List<Map<String, dynamic>>? value}) async {
    if (value != null) {
      listMenu.value = value;
      storage.write('listMenu', value);
    } else {
      storage.write('listMenu', List.from(listMenu));
    }
  }

  static isGridSet({bool? value}) async {
    if (value != null) {
      isGrid.value = value.toString();
      storage.write('isGrid', value);
    } else {
      storage.write('isGrid', isGrid.value);
    }
  }

  static listorderSet({List<Map<String, dynamic>>? value}) async {
    if (value != null) {
      listorder.value = value;
      storage.write('listorder', value);
    } else {
      storage.write('listorder', List.from(listorder));
    }
  }

  static searchSet({String? value}) async {
    if (value != null) {
      search.value = value;
      storage.write('search', value);
    } else {
      storage.write('search', search.value);
    }
  }

  static lastClickSet({Map? value}) async {
    if (value != null) {
      lastClick.value = value;
      storage.write('lastclick', value);
    } else {
      storage.write('lastclick', Map.from(lastClick));
    }
  }

  static listFavoriteSet({List<Map<String, dynamic>>? value}) async {
    if (value != null) {
      listFavorite.value = value;
      storage.write('listFavorite', value);
    } else {
      storage.write('listFavorite', List.from(listFavorite));
    }
  }

  static showFavoriteSet({bool? value}) async {
    if (value != null) {
      showFavorite.value = value;
      storage.write('showFavorite', value);
    } else {
      storage.write('showFavorite', showFavorite.value);
    }
  }

  static billIdSet({String? value}) async {
    if(value != null){
      billId.value = value;
      storage.write('billId', value);
    }else{
      storage.write('billId', billId.value);
    }
  }

  static billsSet({List<Map<String, dynamic>>? value}) async {
    if (value != null) {
      bills.value = value;
      storage.write('bills', value);
    } else {
      storage.write('bills', List.from(bills));
    }
  }

  static listBillSet({List<Map<String, dynamic>>? value}) async {
    if (value != null) {
      listBill.value = value;
      storage.write('listBill', value);
    } else {
      storage.write('listBill', List.from(listBill));
    }
  }

  static isCategoryOpenSet({bool? value}) async {
    if (value != null) {
      isCategoryOpen.value = value.toString();
      storage.write('isCategoryOpen', value);
    } else {
      storage.write('isCategoryOpen', isCategoryOpen.value);
    }
  }

  static paxSet({int? value}) async {
    if (value != null) {
      pax.value = value;
      storage.write('pax', value);
    } else {
      storage.write('pax', pax.value);
    }
  }

  static aspekSet({double? value}) async {
    if (value != null) {
      aspek.value = value;
      storage.write('aspek', value);
    } else {
      storage.write('aspek', aspek.value);
    }
  }

  static listHistorySearchSet({List<Map<String, dynamic>>? value}) async {
    if (value != null) {
      listHistorySearch.value = value;
      storage.write('listHistorySearch', value);
    } else {
      storage.write('listHistorySearch', List.from(listHistorySearch));
    }
  }

  static listSaveOrderSet({List<Map<String, dynamic>>? value}) async {
    if (value != null) {
      listSaveOrder.value = value;
      storage.write('listSaveOrder', value);
    } else {
      storage.write('listSaveOrder', List.from(listSaveOrder));
    }
  }

  static customerSet({Map<String, dynamic>? value}) async {
    if (value != null) {
      customer.value = value;
      storage.write('customer', value);
    } else {
      storage.write('customer', Map.from(customer));
    }
  }

  static listCustomerSet({List<Map<String, dynamic>>? value}) async {
    if (value != null) {
      listCustomer.value = value;
      storage.write('listCustomer', value);
    } else {
      storage.write('listCustomer', List.from(listCustomer));
    }
  }

  static savedOrderSet({Map<String, dynamic>? value}) async {
    if (value != null) {
      savedOrder.value = value;
      storage.write('savedOrder', value);
    } else {
      storage.write('savedOrder', Map.from(savedOrder));
    }
  }
}
