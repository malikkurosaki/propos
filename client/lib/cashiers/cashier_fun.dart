import 'package:client/utils/g_val.dart';
import 'package:client/utils/util_value.dart';

class CashierFun {

  CashierFun.addQty(Map<String, dynamic> item) {
    final idx = GVal.listOrders.value.val.indexWhere((element) => element["id"] == item["id"]);
    if (idx == -1) {
      item['qty'] = 1;
      item['note'] = "";
      GVal.listOrders.value.val.add(item);
    } else {
      GVal.listOrders.value.val[idx]['qty'] = GVal.listOrders.value.val[idx]['qty'] + 1;
    }

    UtilValue.lastClick.value = item;
    GVal.listOrders.value.val = List.from(GVal.listOrders.value.val);
    GVal.listOrders.refresh();
  }
}