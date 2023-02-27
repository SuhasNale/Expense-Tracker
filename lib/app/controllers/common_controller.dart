import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../ui/utils/constants.dart';
import '../ui/utils/shareprefs.dart';

class CommonController extends GetxController {
  // Color? incomeColor = Colors.green[600];
  // Color expColor = Colors.red;

  var time = DateTime.now();
  var date;
  int index = -1.obs;
  int editIndex = -1.obs;
  var expType = 'Income'.obs;
  var categoryType = ''.obs;
  var selExpCategory = <dynamic>[].obs;
  var filteredExpCategory = <dynamic>[].obs;
  var newExpList = <dynamic>[].obs;
  var income = 0.obs;
  var totalIncome = 0.obs;
  var expense = 0.obs;
  var totalExpense = 0.obs;
  var balance = 0.obs;
  var isEdit = false.obs;

  // static var totalBalance = 0;
  var iconData;

  Rx<TextEditingController> amountController = TextEditingController().obs;

  filterDataCategories() {
    filteredExpCategory.value = [];
    for (int i = 0; i < selExpCategory.length; i++) {
      print("Comparing category is:" +
          ExpenseConst.expCategory[int.parse(selExpCategory[i][1])][2]
              .toString() +
          " with " +
          expType.value);
      if (ExpenseConst.expCategory[int.parse(selExpCategory[i][1])][2] ==
          expType.value) {
        print("inside IF");
        filteredExpCategory.add(selExpCategory[i]);
        print(filteredExpCategory.length.toString() + " is length");
      }
    }
  }

  entryInit() {
    time = DateTime.now();
    date = DateFormat('d MMM y').format(time);
    filterDataCategories();

    if (editIndex != -1) {
      // ExpenseConst.expType = ExpenseConst.newExpList[widget.editIndex][0];
      // ExpenseConst.categoryType =
      //     ExpenseConst.newExpList[widget.editIndex][1];
      // amountController.text = ExpenseConst.newExpList[widget.editIndex][3];
    } else {
      amountController.value.text = '';
    }
  }

  createEntry() {
    time = DateTime.now();
    date = DateFormat('d MMM y').format(time);
    if (amountController.value.text.toString() == "") {
      return 0;
    }
    if (categoryType.value.toString() == "") {
      return -1;
    }
    if (isEdit.value) {
      // if (ExpenseConst.editIndex != -1) {
      // ExpenseConst.newExpList[widget.editIndex][0] = ExpenseConst.expType;
      // ExpenseConst.newExpList[widget.editIndex][1] =
      //     ExpenseConst.categoryType;
      newExpList[editIndex][3] = amountController.value.text;
      debugPrint("New Expense List after update is " + newExpList.toString());
      // }
    } else {
      if (expType == 'Income') {
        income.value = int.parse(amountController.value.text);
        balance = balance + income.value;
        totalIncome = totalIncome + income.value;
        debugPrint('Balance after Income is ' + balance.value.toString());
        debugPrint('Income after New Entry is ' + totalIncome.value.toString());
      } else {
        expense.value = int.parse(amountController.value.text);
        balance = balance - expense.value;
        totalExpense = totalExpense + expense.value;
        debugPrint('Balance after Expense is ' + balance.value.toString());
        debugPrint(
            'Income after New Entry is ' + totalExpense.value.toString());
      }
      //************ADDING DATA IN LIST *********/
      newExpList.add([
        expType.value,
        categoryType.value,
        iconData, // ICON
        amountController.value.text,
        // DateFormat().format(time),s
        date,
      ]);
      debugPrint("New Expense List " + newExpList.toString());
      SharePrefs.saveAmountList(newExpList.value);

      newExpList.value = [];
      newExpList.value = SharePrefs.getAmtData();
      amountController.value.text = "";
    }
    editIndex = -1;

    // debugPrint("New Expense List " + newExpList.toString());
    // Navigator.of(context).pop();
    //amountController.close();
    isEdit.value = true;
    return 1;
  }

  deleteEntry(index) {
    if (newExpList[index][0] == 'Income') {
      balance = balance - int.parse(newExpList[index][3]);

      totalIncome = totalIncome - int.parse(newExpList[index][3]);

      debugPrint("Updated Balance is: " + balance.toString());

      debugPrint("Updated Income is: " + income.toString());
    } else {
      balance.value = int.parse(newExpList[index][3]) + balance.value;

      totalExpense = totalExpense - int.parse(newExpList[index][3]);

      debugPrint("Updated Balance is: " + balance.toString());

      debugPrint("Updated Expense is: " + totalExpense.toString());
    }

    debugPrint("Deleted Entry is: " + newExpList[index].toString());

    newExpList.removeAt(index);
    SharePrefs.saveAmountList(newExpList.value);

    debugPrint("New Expense List " + newExpList.toString());
    // return 1;
    // Navigator.of(context).pop();
    Get.back();
  }

  homeInit() {
    SharePrefs.initSharedPreferences().then((value) {
      print("shared pref initialized");
      newExpList.value = [];
      selExpCategory.value = [];
      selExpCategory.value = SharePrefs.getData();
      newExpList.value = SharePrefs.getAmtData();
      print("data fetched is:" + newExpList.length.toString());

      for (int i = 0; i < newExpList.length; i++) {
        if (newExpList[i][0] == "Expense") {
          totalExpense += int.parse(newExpList[i][3]);
        } else {
          totalIncome += int.parse(newExpList[i][3]);
        }
      }
      balance = totalIncome - totalExpense.value;
    });
  }
}
