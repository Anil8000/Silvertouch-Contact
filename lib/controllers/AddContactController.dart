import 'package:get/get.dart';

class AddContactController extends GetxController{
  var img;
  var base64Image;
  List<String> categoryList = [];

  void setUploadImage(var imgPath){
    img = imgPath;
    update();
  }

  void setBase64Image(var base64Image){
    this.base64Image = base64Image;
    update();
  }

  void updateCategoryList(var categoryList){
    this.categoryList = categoryList;
    update();
  }



}