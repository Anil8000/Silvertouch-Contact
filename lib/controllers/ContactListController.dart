import 'package:get/get.dart';

class ContactListController extends GetxController{
  var contactList = [];
  String filterTitle = "Select Category";

  void updateContactList(var contactList){
    this.contactList = contactList;
    update();
  }

  void updateFilterTitle(String filterTitle){
    this.filterTitle = filterTitle;
    update();
  }


}