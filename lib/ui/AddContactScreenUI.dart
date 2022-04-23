// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:silvertouch_contach/controllers/BasicsController.dart';
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

  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [

              topContainer(),
              bottomContainer(),

            ],
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

                      print("pickedFile  ::  $pickedFile");

                      controller.setUploadImage(pickedFile!.path.toString());
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
              return FieldValidator.validateValueIsEmpty(v!);
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
                  value: dropdownvalue,
                  elevation: 0,
                  underline: Container(),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
            ),
          ),



          SizedBox(height: 10,),


          InkWell(
            onTap: () {
              if(_formKey.currentState!.validate()){

              }
              clearData();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15,bottom: 12,left: 8,right: 8),
              child: RoundedButton(
                text: "Save",
                onTap: () {

                },
              ),
            ),
          ),

          SizedBox(height: 20,),


        ],
      ),
    );
  }


  clearData(){
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneNumberController.clear();
  }



}
