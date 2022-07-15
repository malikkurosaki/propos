import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class UtilValue {
  static final storage = GetStorage();
  static final wellcome = (storage.read('wellcome') ?? true).toString().obs;
  // static final user = Map.from(storage.read('user') ?? {}).obs;
  // static final listMenu = List<Map<String, dynamic>>.from(storage.read('listMenu') ?? []).obs;
  static final isGrid = (storage.read('isGrid') ?? true).toString().obs;
  // static final listorder = List<Map<String, dynamic>>.from(storage.read('listorder') ?? []).obs;
  static final search = (storage.read('search') ?? '').toString().obs;
  static final lastClick = Map.from(storage.read('lastclick') ?? {}).obs;
  static final listFavorite = List<Map<String, dynamic>>.from(storage.read('listFavorite') ?? []).obs;
  static final showFavorite = ((storage.read('showFavorite') ?? false).toString() == "true").obs;
  // static final billId = (storage.read('billId') ?? const Uuid().v4()).toString().obs;
  static wellcomeSet(bool value) {
    wellcome.value = value.toString();
    storage.write('wellcome', value);
  }

  // static final bills = List<Map<String, dynamic>>.from(storage.read('bills') ?? []).obs;
  static final listBill = List<Map<String, dynamic>>.from(storage.read('listBill') ?? []).obs;
  static final isCategoryOpen = (storage.read('isCategoryOpen') ?? true).toString().obs;
  // static final pax = int.parse((storage.read('pax') ?? 1).toString()).obs;
  static final aspek = double.parse((storage.read('aspek') ?? 10 / 18).toString()).obs;
  static final listHistorySearch = List<Map<String, dynamic>>.from(storage.read('listHistorySearch') ?? []).obs;
  static final listSaveOrder = List<Map<String, dynamic>>.from(storage.read('listSaveOrder') ?? []).obs;
  // static final customer = Map.from(storage.read('customer') ?? {}).obs;
  // static final customers = List.from(storage.read("listCustomer") ?? []).obs;
  // static final savedOrder = Map.from(storage.read('savedOrder') ?? {}).obs;
  // token
  static final token = (storage.read('token') ?? '').toString().obs;

  // outlets
  // static final outlets = List.from(storage.read('listOutlet') ?? []).obs;

  // categories
  // static final categories = List.from(storage.read('listCategory') ?? []).obs;

  // product
  // static final products = List.from(storage.read('products') ?? []).obs;

  //
  static final deviceInfo = Map.from(storage.read('deviceInfo') ?? {}).obs;

  // index productpage
  static final indexProductPage = int.parse((storage.read('indexProductPage') ?? 0).toString()).obs;

  // index outletPage
  static final indexOutletPage = int.parse((storage.read('indexOutletPage') ?? 0).toString()).obs;

  // outlet
  // static final outlet = Map.from(storage.read('outlet') ?? {}).obs;

  // payment method masters
  static final paymentMethodMasters = List.from(storage.read('paymentMethodMasters') ?? []).obs;

  // payment methods
  // static final paymentMethods = List.from(storage.read('paymentMethods') ?? []).obs;
  
  

  // ------------ TAMBAHAN ------------

  // clear
  static clear() {
    storage.erase();
  }

  // ------------ JURANG PEMISAH ------------
  
  // static userSet({Map<String, dynamic>? value}) async {
  //   if (value != null) {
  //     user.value = value;
  //     storage.write('user', value);
  //   } else {
  //     storage.write('user', Map.from(user));
  //   }
  // }

  // static listMenuSet({List<Map<String, dynamic>>? value}) async {
  //   if (value != null) {
  //     listMenu.value = value;
  //     storage.write('listMenu', value);
  //   } else {
  //     storage.write('listMenu', List.from(listMenu));
  //   }
  // }

  static isGridSet({bool? value}) async {
    if (value != null) {
      isGrid.value = value.toString();
      storage.write('isGrid', value);
    } else {
      storage.write('isGrid', isGrid.value);
    }
  }

  // static listorderSet({List<Map<String, dynamic>>? value}) async {
  //   if (value != null) {
  //     listorder.value = value;
  //     storage.write('listorder', value);
  //   } else {
  //     storage.write('listorder', List.from(listorder));
  //   }
  // }

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

  // static billIdSet({String? value}) async {
  //   if (value != null) {
  //     billId.value = value;
  //     storage.write('billId', value);
  //   } else {
  //     storage.write('billId', billId.value);
  //   }
  // }

  // static billsSet({List<Map<String, dynamic>>? value}) async {
  //   if (value != null) {
  //     bills.value = value;
  //     storage.write('bills', value);
  //   } else {
  //     storage.write('bills', List.from(bills));
  //   }
  // }

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

  // static paxSet({int? value}) async {
  //   if (value != null) {
  //     pax.value = value;
  //     storage.write('pax', value);
  //   } else {
  //     storage.write('pax', pax.value);
  //   }
  // }

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

  // static customerSet({Map<String, dynamic>? value}) async {
  //   if (value != null) {
  //     customer.value = value;
  //     storage.write('customer', value);
  //   } else {
  //     storage.write('customer', Map.from(customer));
  //   }
  // }

  // static listCustomerSet({List<Map<String, dynamic>>? value}) async {
  //   if (value != null) {
  //     customers.value = value;
  //     storage.write('listCustomer', value);
  //   } else {
  //     storage.write('listCustomer', List.from(customers));
  //   }
  // }

  // static savedOrderSet({Map<String, dynamic>? value}) async {
  //   if (value != null) {
  //     savedOrder.value = value;
  //     storage.write('savedOrder', value);
  //   } else {
  //     storage.write('savedOrder', Map.from(savedOrder));
  //   }
  // }

  // token
  static tokenSet({String? value}) async {
    if (value != null) {
      token.value = value;
      storage.write('token', value);
    } else {
      storage.write('token', token.value);
    }
  }

  // outlets
  // static outletsSet({List<Map<String, dynamic>>? value}) async {
  //   if (value != null) {
  //     outlets.value = value;
  //     storage.write('listOutlet', value);
  //   } else {
  //     storage.write('listOutlet', List.from(outlets));
  //   }
  // }

  // categories
  // static listCategorySet({List<Map<String, dynamic>>? value}) async {
  //   if (value != null) {
  //     categories.value = value;
  //     storage.write('listCategory', value);
  //   } else {
  //     storage.write('listCategory', List.from(categories));
  //   }
  // }

  // product
  // static productsSet({List<Map<String, dynamic>>? value}) async {
  //   if (value != null) {
  //     products.value = value;
  //     storage.write('products', value);
  //   } else {
  //     storage.write('products', List.from(products));
  //   }
  // }

  // device info
  static deviceInfoSet({Map<String, dynamic>? value}) async {
    if (value != null) {
      deviceInfo.value = value;
      storage.write('deviceInfo', value);
    } else {
      storage.write('deviceInfo', Map.from(deviceInfo));
    }
  }

  // index productPage
  static indexProductPageSet({int? value}) async {
    if (value != null) {
      indexProductPage.value = value;
      storage.write('indexProductPage', value);
    } else {
      storage.write('indexProductPage', indexProductPage.value);
    }
  }

  // index outletPage
  static indexOutletPageSet({int? value}) async {
    if (value != null) {
      indexOutletPage.value = value;
      storage.write('indexOutletPage', value);
    } else {
      storage.write('indexOutletPage', indexOutletPage.value);
    }
  }

  // outlet: {}
  // static outletSet({Map<String, dynamic>? value}) async {
  //   if (value != null) {
  //     outlet.value = value;
  //     storage.write('outlet', value);
  //   } else {
  //     storage.write('outlet', Map.from(outlet));
  //   }
  // }

  // payment method masters
  static paymentMethodMastersSet({List<Map<String, dynamic>>? value}) async {
    if (value != null) {
      paymentMethodMasters.value = value;
      storage.write('paymentMethodMasters', value);
    } else {
      storage.write('paymentMethodMasters', List.from(paymentMethodMasters));
    }
  }

  // payment methods
  // static paymentMethodsSet({List<Map<String, dynamic>>? value}) async {
  //   if (value != null) {
  //     paymentMethods.value = value;
  //     storage.write('paymentMethods', value);
  //   } else {
  //     storage.write('paymentMethods', List.from(paymentMethods));
  //   }
  // }
}
