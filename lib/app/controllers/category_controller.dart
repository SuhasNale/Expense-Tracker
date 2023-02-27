import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ui/utils/constants.dart';
import '../ui/utils/shareprefs.dart';
import 'common_controller.dart';

class CategoryController extends GetxController {
  var isEdit = false.obs;
  int editSelectedIndex = -1.obs;
  List sharePrefList = [].obs;
  TextEditingController categoryTextController = TextEditingController();
  CommonController commonController = Get.find();

  //*********** SELECT THE CONTENT ON EDIT TAP **************/
  editSelectionFunction() {
    for (int i = 0; i < ExpenseConst.expCategory.length; i++) {
      if (ExpenseConst.expCategory[i][0] ==
          commonController.selExpCategory[editSelectedIndex][1]) {
        //SELECT
        commonController.index = i;
        categoryTextController.text = commonController.selExpCategory[i][0];
        break;
      }
    }
  }

  createCategory() {
    debugPrint('Inside Create Method with edited value' + isEdit.toString());

    if (isEdit == false) {
      print(categoryTextController.text +
          "->" +
          commonController.index.toString());
      if (categoryTextController.text != "" && commonController.index != -1) {
        bool isDuplicate = false;
        for (int i = 0; i < commonController.selExpCategory.length; i++) {
          print("comparing " +
              ExpenseConst.expCategory[
                  int.parse(commonController.selExpCategory[i][1])][1] +
              " with " +
              ExpenseConst.expCategory[commonController.index][1]);
          if (ExpenseConst.expCategory[
                  int.parse(commonController.selExpCategory[i][1])][1] ==
              ExpenseConst.expCategory[commonController.index][1]) {
            isDuplicate = true;
            break;
          }
        }
        if (isDuplicate) {
          debugPrint("in duplicate");

          return 0;
        } else {
          print("in not duplicate");

          /*ExpenseConst.selExpCategory.add([
              categoryTextController.text,
              ExpenseConst.expCategory[ExpenseConst.index][0],
            ]);*/

          commonController.selExpCategory.add(
              [categoryTextController.text, commonController.index.toString()]);
          categoryTextController.clear();

          commonController.index = -1;
          update();

          //*********** FOR SNACKBARS ********/
          // return 1;
        }
      } else {
        //*********** FOR SNACKBARS ********/
        // return 2;
      }
    } else {
      bool isDuplicate = false;
      if (commonController.index != -1) {
        for (int i = 0; i < commonController.selExpCategory.length; i++) {
          if (commonController.selExpCategory[i][1] ==
              ExpenseConst.expCategory[commonController.index][0]) {
            isDuplicate = true;
            break;
          }
        }
      } else {
        for (int i = 0; i < commonController.selExpCategory.length; i++) {
          if (commonController.selExpCategory[i][1] ==
              commonController.selExpCategory[editSelectedIndex][1]) {
            isDuplicate = true;
            break;
          }
        }
      }

      if (isDuplicate) {
        //*********** FOR SNACKBARS ********/
        return 0;
      } else {
        commonController.selExpCategory[editSelectedIndex][0] =
            categoryTextController.text;
        commonController.selExpCategory[editSelectedIndex][1] =
            commonController.index;
        isEdit.value = false;
        editSelectedIndex = -1;
        commonController.index = -1;
      }
    }
    debugPrint(
        "Select Category List " + commonController.selExpCategory.toString());

    // ********** SHARED PREFERENCE *******/
    SharePrefs.saveDataList(commonController.selExpCategory);

    sharePrefList = [];
    sharePrefList = SharePrefs.getData();
    update();
  }

  deleteCategory(index) {
    commonController.selExpCategory.removeAt(index);

    // SharePrefs.saveDataList(ExpenseConst.selExpCategory);
  }
}
