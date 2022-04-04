import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
class UtilPref{
  static final storage = GetStorage();
  static final wellcome = (storage.read('wellcome')??true).toString().obs;
  static final user = Map.from(storage.read('user') ?? {}).obs;
  static final listMenu = List<Map<String, dynamic>>.from(storage.read('listMenu') ?? []).obs;
  static final isGrid = (storage.read('isGrid')??true).toString().obs;
  static final listorder = List<Map<String, dynamic>>.from(storage.read('listorder') ?? []).obs;
  

  static wellcomeSet(bool value){
    storage.write('wellcome', value);
    wellcome.value = value.toString();
  }

  static userSet(Map<String, dynamic> value)async{
    await storage.write('user', value);
    user.value = value;
  }

  static listMenuSet(List<Map<String, dynamic>> value)async{
    await storage.write('listMenu', value);
    listMenu.value = value;
  }

  static isGridSet(bool value)async{
    await storage.write('isGrid', value);
    isGrid.value = value.toString();
  }

  static listorderSet(List<Map<String, dynamic>> value)async{
    await storage.write('listorder', value);
    listorder.value = value;
  }


}