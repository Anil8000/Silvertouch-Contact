// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:silvertouch_contach/controllers/DashboardController.dart';
import 'package:silvertouch_contach/ui/CategoryScreenUI.dart';
import 'package:silvertouch_contach/utils/AppString.dart';
import 'package:silvertouch_contach/widgets/CommonDrawer.dart';

class MainScreenUI extends StatefulWidget {
  @override
  _MainScreenUIState createState() => _MainScreenUIState();
}

class _MainScreenUIState extends State<MainScreenUI> {
  String title="Home";
  int selectedDrawerIndex=0;

  Future<bool> _onWillPop() {
    showDialog(
        context: context,
        builder: (BuildContext context)=> exitAppConfirmationDialog()
    );
    return Future<bool>.value(true);
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DashboardController(),

        builder: (DashboardController dashController){
      return SafeArea(
        child: Scaffold(
          drawer: CommonDrawer(),
          appBar: new AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(dashController.appBarTitle,
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.w600,fontSize: 18.0),),
            backgroundColor: AppColors.primaryColor,
          ),
          body: WillPopScope(

              onWillPop: _onWillPop,
              child:_getDrawerItemWidget(dashController.drawerSelectedIndex,dashController)),
        ),
      );
    });
  }



  _getDrawerItemWidget(int pos,DashboardController dashboardController) {
    switch (pos) {
      case 0:
        return CategoryScreenUI();
      case 1:
        return Container();
      case 2:
        return Container();
    }

  }
  Widget exitAppConfirmationDialog() {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: 220,
          child: Center(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              color: Colors.white,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(

                  border: Border.all(color: AppColors.primaryColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),

                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new  Container(

                        padding: EdgeInsets.only(
                          bottom: 12,
                          top: 12,
                          left:12,
                        ),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                            color:AppColors.primaryColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16),
                                topLeft: Radius.circular(16))),
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            AppString.appName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize:20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),



                      Center(
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(12),
                          child: new Text(
                            "Are you sure you want to exit application?",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                fontSize: 16, color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                      new Container(
                        margin: EdgeInsets.only(top: 16),
                        height:3,
                        color: AppColors.primaryColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.back(canPop: true);

                              },
                              child: Container(
                                height: 44,
                                padding: EdgeInsets.only(
                                    top: 12,
                                    bottom:12),
                                child: Center(
                                  child: new Text(
                                    'No',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:AppColors.primaryColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          new Container(
                            width: 3,
                            height: 40,
                            color: AppColors.primaryColor,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                SystemNavigator.pop();
                              },
                              child: Container(
                                height: 44,
                                padding: EdgeInsets.only(
                                    top: 12,
                                    bottom: 12),
                                child: Center(
                                  child: new Text(
                                    'Yes',
                                    style: TextStyle(
                                        fontSize:16,
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
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
        ));
  }
}
