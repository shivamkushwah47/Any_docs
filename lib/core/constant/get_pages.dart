import 'package:any_docs/core/constant/url_constant.dart';
import 'package:any_docs/feature/home_page/binding/home_binding.dart';
import 'package:any_docs/feature/home_page/view/home_view.dart';
import 'package:get/get.dart';

List<GetPage> getPages = [
  GetPage(
      name: RouteConstant.homePage,
      page: () => HomePageView(),
      binding: HomePageBinding()),
];
