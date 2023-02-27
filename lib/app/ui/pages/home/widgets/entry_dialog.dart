import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:intl/intl.dart';
import '../../../../controllers/common_controller.dart';
import '../../../utils/constants.dart';
import '../../../utils/shareprefs.dart';

class EntryDialog extends StatefulWidget {
  int editIndex;
  EntryDialog({Key? key, required this.editIndex}) : super(key: key);

  @override
  State<EntryDialog> createState() => _EntryDialogState();
}

class _EntryDialogState extends State<EntryDialog> {
  CommonController commonController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commonController.filterDataCategories();
  }

  @override
  Widget build(BuildContext context) {
// d MMMy
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: size.width * 0.8,
            height: size.height * 0.5,
            decoration: BoxDecoration(
                color: Colors.grey[700],
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(111, 69, 96, 108),
                    blurRadius: 3,
                  )
                ],
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                  // Radius.elliptical(100, 20),
                ),
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [
                      Color.fromARGB(143, 185, 185, 185),
                      Color.fromARGB(139, 126, 122, 122)
                    ])),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LiteRollingSwitch(
                    value: true,
                    textOn: "  Income",
                    textSize: 18,
                    textOnColor: Colors.white,
                    textOff: "Expense",
                    colorOn: Colors.green,
                    colorOff: Colors.redAccent,
                    iconOn: Icons.arrow_downward,
                    iconOff: Icons.arrow_upward,
                    onChanged: (bool status) {
                      status
                          ? commonController.expType.value = 'Income'
                          : commonController.expType.value = 'Expense';

                      commonController.filterDataCategories();

                      debugPrint("Expense Cateroy is " +
                          commonController.expType.value);
                    },
                    onSwipe: () {},
                    onDoubleTap: () {},
                    onTap: () {},
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Container(
                    height: size.height * 0.22,
                    color: Colors.grey[500],
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        //************* DROP DOWN MENU **************/
                        Obx(
                          () => DropdownButtonFormField<List>(
                            dropdownColor: Colors.grey[200],
                            decoration: const InputDecoration(
                              fillColor: Colors.red,
                              prefixIcon: Icon(
                                Icons.swipe_right,
                                color: Colors.white,
                              ),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                              size: 30,
                            ),
                            style: GoogleFonts.bebasNeue(
                                fontSize: 20,
                                letterSpacing: 2,
                                color: Colors.black),
                            hint: Text(
                              'Choose Category',
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 20,
                                  letterSpacing: 2,
                                  color: Colors.white),
                            ),
                            items: commonController.filteredExpCategory.value
                                .map((value) => DropdownMenuItem<List>(
                                      value: value,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            value[0],
                                            style: GoogleFonts.bebasNeue(
                                                fontSize: 20,
                                                letterSpacing: 2,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.2,
                                            child: ExpenseConst.expCategory[
                                                int.parse(value[1])][0],
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              print("selected value is" +
                                  value![0] +
                                  " " +
                                  value![1]);
                              commonController.categoryType.value = value![0];
                              commonController.iconData = value[1];

                              print("selected Category is  " +
                                  commonController.categoryType.value
                                      .toString());

                              print("selected Icon is " +
                                  commonController.iconData.toString());
                            },
                          ),
                        ),

                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            maxLines: null,
                            controller: commonController.amountController.value,
                            style: GoogleFonts.bebasNeue(
                                fontSize: 25,
                                letterSpacing: 2,
                                color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Enter Amount',
                              hintStyle: GoogleFonts.bebasNeue(
                                  fontSize: 20,
                                  letterSpacing: 2,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                      // child: ExpenseConst.selExpCategory[0],
                      ),
                  //******* BUTTONS ******/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //******** SAVE BUTTON ******/
                      MaterialButton(
                        onPressed: () {
                          int result = commonController.createEntry();
                          if (result == -1) {
                            final snackBar = SnackBar(
                              content: Text('Select Category of ' +
                                  commonController.expType.value.toString()),
                              action: SnackBarAction(
                                label: 'Ok',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (result == 0) {
                            final snackBar = SnackBar(
                              content: const Text("Amount Can't be Blank!"),
                              action: SnackBarAction(
                                label: 'Ok',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            Get.back();
                          }
                        },
                        color: Colors.black,
                        child: Text(
                          commonController.isEdit.value ? 'Update' : 'Save',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 25,
                              letterSpacing: 2,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      // //******** CANCEL BUTTON ******/
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.black,
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 25,
                              letterSpacing: 2,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
