// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:silvertouch_contach/controllers/AddContactController.dart';
import 'package:silvertouch_contach/utils/AppColors.dart';
import 'package:silvertouch_contach/utils/FieldValidator.dart';
import 'package:silvertouch_contach/widgets/RoundedButton.dart';
import 'package:silvertouch_contach/widgets/TextFormInputField.dart';

class AddContactScreenUI extends StatefulWidget {
  const AddContactScreenUI({Key? key}) : super(key: key);

  @override
  State<AddContactScreenUI> createState() => _AddContactScreenUIState();
}

class _AddContactScreenUIState extends State<AddContactScreenUI> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  AddContactController addContactController = Get.put(AddContactController());

  String dropdownvalue = 'Select Category';
  late Database database1;
  late Database database2;
  var items = [];


  @override
  void initState() {
    super.initState();
    tempSetData();
    createDB();
  }

  tempSetData(){
    firstNameController.text = "aa";
    lastNameController.text = "aa";
    emailController.text = "aa@gmail.com";
    phoneNumberController.text = "8000808080";
    dropdownvalue = "aaa";
  }


  createDB() async {
    database1 = await openDatabase('demo.db');


    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo1.db');

    database2 = await openDatabase(path,version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE cont (id INTEGER PRIMARY KEY,image LONGTEXT,fname TEXT,lname TEXT,ph_number TEXT,email TEXT,category TEXT)');
      },);


    /*var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE contact (id INTEGER PRIMARY KEY,image TEXT, fname TEXT,lname TEXT, ph_number TEXT, email TEXT,category TEXT)');
        });
*/

    getCategoryData();
  }

  getCategoryData() async {
    List<Map> list = await database1.rawQuery('SELECT * FROM category');

    for(int i=0 ;i<list.length; i++){
      items.add(list[i]['category_name']);
    }


    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            child: Column(
              children: [

                topContainer(),
                bottomContainer(),

              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget topContainer(){
    return Column(
      children: [
        SizedBox(height: 20,),

        GetBuilder(
          init: AddContactController(),
          builder: (AddContactController controller) {
            return Container(
              child: controller.img == null
                  ?InkWell(
                    onTap: () async {
                      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                      controller.setUploadImage(pickedFile!.path.toString());


                      var imageBytes = utf8.encode(pickedFile.path);
                      String base64Image = base64.encode(imageBytes);

                      controller.setBase64Image(base64Image);
                      //printWrapped("base64Image  ::  $base64Image");

                    },
                    child: Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.transparent,
                        child: Icon(Icons.account_circle_sharp,size: 170,color: AppColors.primaryColor,),
                      ),
                    ),
                  )
                  :Column(
                  children: [

                  CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.transparent,
                      backgroundImage: FileImage(File(controller.img),)
                  ),

                  InkWell(
                    onTap: () async {
                      final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
                      controller.setUploadImage(pickedFile!.path);


                      var imageBytes = utf8.encode(pickedFile.path);
                      String base64Image = base64.encode(imageBytes);

                      controller.setBase64Image(base64Image);
                      //printWrapped("base64Image  ::  $base64Image");
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryAssent,
                        child: Icon(Icons.edit,color: Colors.white,),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            );
          },
        ),

        SizedBox(height: 20,),

      ],
    );
  }


  Widget bottomContainer(){
    return Form(
      key: _formKey,
      child: Column(
        children: [

          TextFormInputField(
            hintText: "First Name",
            controller: firstNameController,
            validator: (v){
              return FieldValidator.validateValueIsEmpty(v!);
            },
          ),

          SizedBox(height: 5,),

          TextFormInputField(
            hintText: "Last Name",
            controller: lastNameController,
            validator: (v){
              return FieldValidator.validateValueIsEmpty(v!);
            },
          ),

          SizedBox(height: 5,),

          TextFormInputField(
            hintText: "Phone Number",
            controller: phoneNumberController,
            keyboardType: TextInputType.number,
            maxLength: 10,
            validator: (v){
              return FieldValidator.validateValueIsEmpty(v!);
            },
          ),

          SizedBox(height: 5,),

          TextFormInputField(
            hintText: "Email",
            controller: emailController,
            validator: (v){
              return FieldValidator.validateEmail(v!);
            },
          ),


          SizedBox(height: 10,),


          Padding(
            padding: const EdgeInsets.only(left: 5.0,right: 5.0),
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor,width: 1),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                child: DropdownButton(
                  hint: Text(dropdownvalue,style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold),),
                  elevation: 20,
                  underline: Container(),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownvalue = newValue!.toString();
                    });
                  },
                ),
              ),
            ),
          ),



          SizedBox(height: 10,),


          Padding(
            padding: const EdgeInsets.only(top: 15,bottom: 12,left: 8,right: 8),
            child: RoundedButton(
              text: "Save",
              onTap: () {
                if(_formKey.currentState!.validate()){
                  if(dropdownvalue == "Select Category"){
                    Fluttertoast.showToast(msg: "Please Select Category");
                  }
                  else{
                    if(addContactController.img == null){
                      Fluttertoast.showToast(msg: "Please Select Image.");
                    }
                    else{
                      saveContact();
                    }

                  }

                }
                //clearData();
              },
            ),
          ),

          SizedBox(height: 20,),


        ],
      ),
    );
  }

  saveContact() async {
      await database2.transaction((txn) async {
        int id1 = await txn.rawInsert(
            'INSERT INTO cont(image,fname,lname,ph_number,email,category) VALUES("${addContactController.base64Image}","${firstNameController.text}","${lastNameController.text}","${phoneNumberController.text}","${emailController.text}","$dropdownvalue")');
        print('inserted1: $id1');
      });

      //clearData();
      setState(() {});
  }

  clearData(){
    addContactController.base64Image = "";
    dropdownvalue = "Select Category";
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneNumberController.clear();
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

}
