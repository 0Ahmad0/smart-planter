import 'package:get/get.dart';

class ListController extends GetxController{

  var list = [].obs;
  var listTemp = [].obs;

  addTemp()=>listTemp.add('1');
  add()=> list.add('1');
  clear()=> list.clear();


  List get getList => list;
  List get getListTemp => listTemp;
}