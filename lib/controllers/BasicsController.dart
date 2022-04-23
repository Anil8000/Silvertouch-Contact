import 'package:get/get.dart';

class AddContactController extends GetxController{
  var img;

  void setUploadImage(var imgPath){
    img = imgPath;
    //print("$img");
    update();
  }



}