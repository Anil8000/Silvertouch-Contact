// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:silvertouch_contach/utils/AppColors.dart';
import 'package:silvertouch_contach/utils/AppString.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ContactListScreenUI extends StatefulWidget {
  const ContactListScreenUI({Key? key}) : super(key: key);

  @override
  State<ContactListScreenUI> createState() => _ContactListScreenUIState();
}

class _ContactListScreenUIState extends State<ContactListScreenUI> {

  late Database database;
  var items = [];

  @override
  void initState() {
    super.initState();
    createDB();
    setState(() {
    });
  }


  createDB() async {
    database = await openDatabase('demo1.db');
    getContactData();
    //deleteData();
  }

  deleteData(String id) async {
    await database.rawDelete('DELETE FROM cont WHERE id = $id');
    getContactData();
  }

  getContactData() async {
    items.clear();
    List<Map> list = await database.rawQuery('SELECT * FROM cont');
    print("list  ::  $list");
    print("list  ::  ${list.length}");

    if(list.isNotEmpty){
      for(int i=0 ;i<list.length; i++){
        items.add(ContactData(id: list[i]['id'].toString(), image: utf8.decode(base64.decode(list[i]['image'])) ,fname: list[i]['fname'].toString(),lname: list[i]['lname'].toString()));
      }
    }

    /*for(int i=0 ;i<list.length; i++){
      print("IDDD  ::  ${items[i].id.toString()}");
    }*/


    setState(() {});
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child:

          items.isEmpty
              ? Center(child: Text("No Data Found!",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black38),))
              : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
              return Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(radius: 28,
                          backgroundImage: FileImage(File(items[index].image)),),

                          SizedBox(width: 15,),

                          Text("${items[index].fname} ${items[index].lname}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.black54),),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {

                            },
                            child: Icon(FontAwesomeIcons.edit,size: 20,)
                          ),

                          SizedBox(width: 10,),

                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context)=> deleteDialog(context,items[index].id.toString(),)
                              );
                            },
                            child: Icon(Icons.delete)),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Divider(height: 1,color: AppColors.primaryColor,endIndent: 10,indent: 10,),
                  SizedBox(height: 10,),

                ],
              );
            },
          ),
        ),
      ),
    );
  }


  Widget deleteDialog(BuildContext context,String id) {
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
                            "Delete",
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
                            "Are you sure you want to Delete",
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
                                deleteData(id);
                                Get.back();
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
                          new Container(
                            width: 3,
                            height: 40,
                            color: AppColors.primaryColor,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.back();

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




  editData(String id, String newCategory) async {
    //await database.rawUpdate('UPDATE cont SET category_name = "$newCategory" AND WHERE id = "$id"');
    getContactData();
  }

}


class ContactData{
  var image;
  String? id;
  String? fname;
  String? lname;

  ContactData({this.id,this.image, this.fname,this.lname});
}



///pending task

///add contact to system Contact
///edit contact
///search
///filter