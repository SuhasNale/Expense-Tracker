import 'package:flutter/material.dart';

class ExpenseConst {

  static final List expCategory = [
    [
      Icon(
        Icons.currency_rupee_sharp,
        color: Colors.green[600],
      ),
      'Salary',
      "Income"
    ],
    [
      Icon(
        Icons.lock_person_outlined,
        color: Colors.green[600],
      ),
      'FD',
      "Income"
    ],
    [
      Icon(
        Icons.group_add_outlined,
        color: Colors.green[600],
      ),
      'Commission',
      "Income"
    ],
    [
      Icon(
        Icons.fastfood_outlined,
        color: Colors.red,
      ),
      'Food',
      "Expense"
    ],
    [
      Icon(
        Icons.shopping_cart_checkout,
        color: Colors.red,
      ),
      'Grocery',
      "Expense"
    ],
    [
      Icon(
        Icons.tram_outlined,
        color: Colors.red,
      ),
      'Travel',
      "Expense"
    ],
    [
      Icon(
        Icons.school_outlined,
        color: Colors.red,
      ),
      'Education',
      "Expense"
    ],
    [
      Icon(
        Icons.medical_services_outlined,
        color: Colors.red,
      ),
      'Medical',
      "Expense"
    ],
    [
      Icon(
        Icons.money_outlined,
        color: Colors.red,
      ),
      'Investments',
      "Expense"
    ],
    [
      Icon(
        Icons.shopping_bag_outlined,
        color: Colors.red,
      ),
      'Shopping',
      "Expense"
    ],
    [
      Icon(
        Icons.card_giftcard_rounded,
        color: Colors.red,
      ),
      'Others',
      "Expense"
    ],
    // [Icon(Icons.shopping_bag_outlined), 'Others'],
    // [Icon(Icons.shopping_bag_outlined), 'Others'],
  ];
}
