import 'package:expense_tracker/app/ui/pages/add%20category/add_category.dart';
import 'package:expense_tracker/app/ui/pages/home/home_page.dart';
import 'package:expense_tracker/app/ui/pages/settings/settings.dart';
import 'package:get/get.dart';
import '../ui/pages/track/track.dart';

var routes = [
  GetPage(name: '/', page: () => HomePage()),
  GetPage(name: '/settings', page: () => Settings()),
  GetPage(name: '/addCategory', page: () => AddCategory()),
  GetPage(name: '/track', page: () => Track()),
];
