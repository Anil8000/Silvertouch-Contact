import 'package:get/get.dart';

class DashboardController extends GetxController{
  int bottomSelectedIndex=1;
  int drawerSelectedIndex=0;
  int selectedPageViewIndex=1;
  String appBarTitle= "Home";

  void updateBottomSelectedIndex(int index){
    bottomSelectedIndex=index;
    update();
  }

void updateDrawerSelectedIndex(int index){
  drawerSelectedIndex=index;
  //print("drawer=="+drawerSelectedIndex.toString());

  if(index == 0){
    appBarTitle = "Home";
  }
  else if(index == 1){
    appBarTitle = "Buy VOLTNOTE";
  }
  else if(index == 2){
    appBarTitle = "History";
  }
  else if(index == 3){
    appBarTitle = "Settings";
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




