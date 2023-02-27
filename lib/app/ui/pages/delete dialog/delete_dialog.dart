import 'package:expense_tracker/app/controllers/common_controller.dart';
import 'package:expense_tracker/app/ui/utils/shareprefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';

class DeleteDialog extends StatefulWidget {
  int selIndex;
  DeleteDialog({Key? key, required this.selIndex}) : super(key: key);

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  CommonController commonController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: size.width * 0.8,
            height: size.height * 0.25,
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
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.12,
                    color: Colors.grey[500],
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.12,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                                "Are you sure you want to delete this entry?",
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 25,
                                    letterSpacing: 2,
                                    color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
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
                          int result =
                              commonController.deleteEntry(widget.selIndex);
                          if (result == 1) {
                            final snackBar = SnackBar(
                              content:
                                  const Text('Entry Deleted Successfully!'),
                              action: SnackBarAction(
                                label: 'Ok',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        color: Colors.black,
                        child: Text(
                          'Yes',
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
