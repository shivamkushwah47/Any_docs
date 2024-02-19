import 'package:any_docs/feature/home_page/controller/home_controller.dart';
import 'package:get/get.dart';

class HomePageBinding extends Bindings{
  @override
  void dependencies() {
   Get.put(HomePageController());
  }

}