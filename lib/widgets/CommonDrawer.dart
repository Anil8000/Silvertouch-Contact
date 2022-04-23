// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silvertouch_contach/controllers/DashboardController.dart';
import 'package:silvertouch_contach/utils/AppColors.dart';

class CommonDrawer extends StatefulWidget {
  const CommonDrawer({Key? key}) : super(key: key);

  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {

  DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.drawerBGColor,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[


                    _createDrawerItem(icon: Icons.account_balance_wallet,
                        text: 'Add Category',
                        onTap: (){
                          Get.back();
                          dashboardController.updateDrawerSelectedIndex(0);
                        }),


                    Divider(height: 1.0,color: AppColors.primaryColor.withOpacity(0.5),),

                    _createDrawerItem(icon: Icons.list_alt_rounded,
                        text: 'Add Contact',
                        onTap: (){
                          Get.back();
                          dashboardController.updateDrawerSelectedIndex(1);
                          // Get.to(HistoryFragmentUI());
                        }),

                    Divider(height: 1.0,color: AppColors.primaryColor.withOpacity(0.5),),

                    _createDrawerItem(icon: Icons.settings, text: 'Contact List',
                        onTap: (){
                          Get.back();
                          dashboardController.updateDrawerSelectedIndex(2);
                          // Get.to(SettingFragmentUI());
                        }),

                    Divider(height: 1.0,color: AppColors.primaryColor.withOpacity(0.5),),

                  ]),
            ),

          ],
        ),
      ),
    );
  }


  static Widget _createDrawerItem(
      {required IconData icon, required String text, required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(text,style: TextStyle(
              fontSize:20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),),
          )
        ],
      ),
      onTap: onTap,
    );
  }

}
