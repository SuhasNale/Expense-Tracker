import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'S E T T I N G S',
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
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.04,
            ),
            GestureDetector(
              onTap: (() {
                Get.toNamed('addCategory');
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: ((context) => AddCategory())));
              }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.post_add_rounded),
                  Text(
                    'ADD CATEGORY',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 20,
                      letterSpacing: 5,
                      wordSpacing: 1,
                    ),
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
            Divider(
              color: Colors.black45,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
          ],
        ),
      ),
    );
  }
}
