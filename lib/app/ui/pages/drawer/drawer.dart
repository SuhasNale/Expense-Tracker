import 'package:expense_tracker/app/ui/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../settings/settings.dart';
import '../track/track.dart';

createDrawer(BuildContext context) {
  //********** SAFE AREA FOR NOTIFICATION BAR *********/
  var myDrawer = SafeArea(
      child: Container(
    // padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
    height: MediaQuery.of(context).size.height * 1,
    child: Drawer(
      backgroundColor: Colors.grey[300],
      child: Column(
        children: [
          const DrawerHeader(
              child: Icon(
            Icons.wallet,
            size: 50,
          )),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(
              'D A S H B O A R D',
              style: GoogleFonts.bebasNeue(fontSize: 20, letterSpacing: 2),
            ),
            onTap: () {
              Get.toNamed('/');
              Get.back();
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: ((context) => const HomePage())));
            },
          ),
          Divider(
            color: Colors.black45,
            thickness: 1,
            indent: 20,
            endIndent: 80,
          ),
          ListTile(
            leading: const Icon(Icons.track_changes_sharp),
            title: Text(
              'T R A C K',
              style: GoogleFonts.bebasNeue(fontSize: 20, letterSpacing: 2),
            ),
            onTap: () {
              Get.toNamed('/track');
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: ((context) => const Track())));
            },
          ),
          Divider(
            color: Colors.black45,
            thickness: 1,
            indent: 20,
            endIndent: 80,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(
              'S E T T I N G S',
              style: GoogleFonts.bebasNeue(fontSize: 20, letterSpacing: 2),
            ),
            onTap: () {
              Get.toNamed('/settings');
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: ((context) => const Settings())));
            },
          ),
          Divider(
            color: Colors.black45,
            thickness: 1,
            indent: 20,
            endIndent: 80,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(
              'L O G O U T',
              style: GoogleFonts.bebasNeue(fontSize: 20, letterSpacing: 2),
            ),
            onTap: () {
              //Get.back();
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    ),
  ));
  return myDrawer;
}
