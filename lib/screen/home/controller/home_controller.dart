
import 'package:get/get.dart';
import 'package:user_ecommerce/screen/home/modal/home_modal.dart';

class HomeController extends GetxController{


  RxMap data={}.obs;


 Rx<String>? dropDropDown;
  RxList<String> category = <String>[
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
  ].obs;

  var select = "5".obs;
}


List<HomeModal> itemsList = <HomeModal>[

].obs;

void addData(HomeModal h1)
{
  itemsList.add(h1);
}