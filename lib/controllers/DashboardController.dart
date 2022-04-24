import 'package:get/get.dart';

class DashboardController extends GetxController{
  int drawerSelectedIndex=0;
  String appBarTitle= "Create and Store category";


void updateDrawerSelectedIndex(int index){
  drawerSelectedIndex=index;
  //print("drawer=="+drawerSelectedIndex.toString());

  if(index == 0){
    appBarTitle = "Create and Store category";
  }
  else if(index == 1){
    appBarTitle = "Add Contact";
  }
  else if(index == 2){
    appBarTitle = "Contact List";
  }
  else{
    appBarTitle = "";
  }
    update();
  }



  void updateAppBarTitle(String title){
    appBarTitle=title;
    //print("appBarTitle="+appBarTitle.toString());
    update();
  }


}




