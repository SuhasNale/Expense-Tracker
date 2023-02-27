import 'package:expense_tracker/app/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/common_controller.dart';
import '../../utils/constants.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final ScrollController scrollController = ScrollController();
  CategoryController categoryController = Get.find();
  CommonController commonController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text(
            'C A T E G O R I E S',
            style: GoogleFonts.bebasNeue(
                fontSize: 25,
                letterSpacing: 2,
                wordSpacing: 1,
                color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[300],
          elevation: 0.2,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                TextField(
                  maxLines: null,
                  controller: categoryController.categoryTextController,
                  textCapitalization: TextCapitalization.values.first,
                  style: GoogleFonts.bebasNeue(
                    fontSize: 25,
                    letterSpacing: 2,
                    // color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Eg. Food, Travel ...',
                    hintStyle: GoogleFonts.bebasNeue(
                      fontSize: 25,
                      letterSpacing: 1,
                      // color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),

                //********** GRID VIEW OF ICONS ***************/
                Container(
                  height: size.height * 0.25,
                  // color: Colors.amber[100],
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Scrollbar(
                    controller: scrollController,
                    child: GridView.count(
                      primary: false,
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 4,
                      children: List.generate(ExpenseConst.expCategory.length,
                          (index) {
                        return SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  commonController.index = index;
                                  categoryController
                                          .categoryTextController.text =
                                      ExpenseConst.expCategory[index][1];
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: commonController.index == index
                                      ? Colors.grey[400]
                                      : Colors.transparent,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: ExpenseConst.expCategory[index][0],
                                    ),
                                    Text(ExpenseConst.expCategory[index][1]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                //******* BUTTONS ******/
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //******** SAVE BUTTON ******/
                    MaterialButton(
                      onPressed: () {
                        int result = categoryController.createCategory();
                        if (result == 0) {
                          final snackBar = SnackBar(
                            content: const Text('Entry Exists'),
                            action: SnackBarAction(
                              label: 'Ok',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );

                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (result == 1) {
                          final snackBar = SnackBar(
                            content: const Text('Entry Added Successfully!'),
                            action: SnackBarAction(
                              label: 'Ok',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );

                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (result == 2) {
                          final snackBar = SnackBar(
                            content: const Text(
                                'Please Select category or type category name'),
                            action: SnackBarAction(
                              label: 'Ok',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );

                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      color: Colors.black,
                      child: Text(
                        categoryController.isEdit.value ? 'Update' : 'Save',
                        style: GoogleFonts.bebasNeue(
                            fontSize: 25,
                            letterSpacing: 2,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),

                //************* SHOW CREATED CATEGORY ************/
                commonController.selExpCategory.length != 0
                    ? Container(
                        height: size.height * 0.3,
                        width: size.width,
                        child: Scrollbar(
                          controller: scrollController,
                          radius: Radius.circular(20),
                          thumbVisibility: true,
                          thickness: 5,
                          child: GetBuilder<CommonController>(
                              builder: (controller) {
                            return ListView.builder(
                              primary: false,
                              physics: BouncingScrollPhysics(),
                              itemCount: controller.selExpCategory.length,
                              itemBuilder: (context, index) {
                                return Slidable(
                                  startActionPane: ActionPane(
                                      motion: StretchMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            setState(() {
                                              categoryController.isEdit.value =
                                                  true;
                                              categoryController
                                                  .editSelectedIndex = index;
                                              //ExpenseConst.index = index;
                                            });
                                            categoryController
                                                .editSelectionFunction();
                                            //createCategory();
                                          },
                                          icon: Icons.edit,
                                          backgroundColor:
                                              Colors.green.shade400,
                                        )
                                      ]),
                                  endActionPane: ActionPane(
                                      motion: StretchMotion(),
                                      children: [
                                        SlidableAction(
                                          // onPressed: deleteFunction(index),
                                          onPressed: ((context) {
                                            categoryController
                                                .deleteCategory(index);
                                          }),
                                          icon: Icons.delete,
                                          backgroundColor: Colors.red.shade300,
                                          // borderRadius: BorderRadius.circular(12),
                                        )
                                      ]),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          controller.selExpCategory[index][0],
                                          style: GoogleFonts.bebasNeue(
                                              fontSize: 25,
                                              letterSpacing: 2,
                                              color: Colors.black54),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.02,
                                        ),
                                        SizedBox(
                                          child: ExpenseConst.expCategory[
                                              int.parse(controller
                                                      .selExpCategory[index]
                                                  [1])][0],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      )
                    : Container(
                        child: Text(
                          'Create a category',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 25,
                              letterSpacing: 2,
                              color: Colors.black54),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
