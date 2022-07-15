import 'g_val.dart';
import 'util_http.dart';

class UtilComp{
  
  String gambar(Map pro) => pro['Images']['url'].toString().contains("http")
      ? pro['Images']['url'].toString().toString()
      : UtilHttp.hostImage + '/' + GVal.user.value.val['id'] + '/' + pro['Images']['url'].toString();
}