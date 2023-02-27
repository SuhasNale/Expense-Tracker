import 'package:expense_tracker/app/controllers/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/category_controller.dart';
import '../../utils/constants.dart';
import '../../utils/shareprefs.dart';
import '../delete dialog/delete_dialog.dart';
import '../drawer/drawer.dart';
import 'widgets/entry_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CommonController commonController = Get.put(CommonController());
  CategoryController categoryController = Get.put(CategoryController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commonController.homeInit();
  }

  createEntry(index) {
    Get.dialog(EntryDialog(editIndex: index));
  }

  deleteEntry(index) {
    Get.dialog(DeleteDialog(selIndex: index));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            'E X P E N S E S',
            style: GoogleFonts.bebasNeue(fontSize: 30, letterSpacing: 2),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  commonController.isEdit.value = false;
                  createEntry(commonController.index);
                },
                icon: const Icon(Icons.add))
          ],
          centerTitle: true,
          backgroundColor: Colors.grey[900],
        ),
        backgroundColor: Colors.grey[300],
        drawer: createDrawer(context),
        body: Column(
          children: [
            SizedBox(
              height: size.height * .02,
            ),
            //********** DASHBOARD ON TOP *****/
            SizedBox(
              height: size.height * .3,
              width: size.width * .9,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    height: size.height * 0.3,
                    width: size.width * 1,
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 35, 35, 35),
                            blurRadius: 10,
                            spreadRadius: 1.0),
                      ],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                        // Radius.elliptical(100, 20),
                      ),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        colors: [
                          Color.fromARGB(255, 197, 197, 197),
                          Color.fromARGB(255, 131, 131, 131)
                        ],
                      ),
                    ),

                    // height: MediaQuery.of(context).size.height * 0.5,

                    child: Column(children: [
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'B A L A N C E',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bebasNeue(
                            fontSize: 30,
                            letterSpacing: 2,
                            color: Colors.white70),
                      ),
                      Text(
                        // '20,000',
                        commonController.balance.toString(),
                        // commonController.newExpList[1][6].toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bebasNeue(
                            fontSize: 50,
                            letterSpacing: 2,
                            color: Colors.black54),
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          //*********** INCOME WIDGET ********/
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.green,
                            size: 30,
                          ),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Column(
                            children: [
                              Text(
                                'Income',
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 15,
                                    letterSpacing: 1,
                                    color: Colors.white70),
                              ),
                              Text(
                                // '4,000',
                                commonController.totalIncome.toString(),
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 15,
                                    letterSpacing: 1,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: size.width * 0.40,
                          ),
                          //*********** EXPENSE WIDGET ********/
                          Icon(
                            Icons.arrow_downward,
                            color: Colors.red,
                            size: 30,
                          ),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Column(
                            children: [
                              Text(
                                'Expense',
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 15,
                                    letterSpacing: 1,
                                    color: Colors.white70),
                              ),
                              Text(
                                // '1,000',
                                commonController.totalExpense.toString(),
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 15,
                                    letterSpacing: 1,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
                  )
                ],
              ),
            ),

            SizedBox(
              height: size.height * .02,
            ),

            // //********** LIST TILES BELOW GRID *****/
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                thickness: 10,
                child: ListView.builder(
                  // shrinkWrap: true,
                  // scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: commonController.newExpList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 5, 8, 8),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                            // Radius.elliptical(100, 20),
                          ),
                        ),
                        // width: MediaQuery.of(context).size.width * 0.5,
                        // height: MediaQuery.of(context).size.height * 0.15,
                        child: Card(
                          color: Colors.transparent,
                          // color: Colors.white,
                          child: ExpansionTile(
                            title: Container(
                              child: Row(
                                children: [
                                  //********** ICON *********/
                                  SizedBox(
                                    height: 50,
                                    child: ExpenseConst.expCategory[int.parse(
                                        commonController.newExpList[index]
                                            [2])][0],
                                  ),
                                  SizedBox(
                                    width: size.width * 0.03,
                                  ),
                                  Text(
                                    // "Category",
                                    commonController.newExpList[index][1],
                                    style: GoogleFonts.bebasNeue(
                                        fontSize: 25,
                                        letterSpacing: 2,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),

                            subtitle: Text(
                              // "02 Nov, 2022",
                              (commonController.newExpList[index][4])
                                  .toString(),
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 15,
                                  letterSpacing: 2,
                                  color: Colors.grey[300]),
                            ),

                            //********* ADD BOOL FOR GREEN OR RED DEPENDING ON CREDIT OR DEBIT *********/
                            trailing: Text(
                              // "10,000",
                              commonController.newExpList[index][3],
                              style: GoogleFonts.bebasNeue(
                                fontSize: 30,
                                letterSpacing: 2,
                                // color: Colors.green
                                color: commonController.newExpList[index][0] ==
                                        'Income'
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButton.icon(
                                      label: Text(
                                        'Edit',
                                        style: GoogleFonts.bebasNeue(
                                            fontSize: 15,
                                            letterSpacing: 2,
                                            color: Colors.green),
                                      ),
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {
                                        commonController.isEdit.value = true;
                                        createEntry(index);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: TextButton.icon(
                                      label: Text(
                                        'Delete',
                                        style: GoogleFonts.bebasNeue(
                                            fontSize: 15,
                                            letterSpacing: 2,
                                            color: Colors.red),
                                      ),
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        deleteEntry(index);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
