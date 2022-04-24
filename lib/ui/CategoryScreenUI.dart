// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:silvertouch_contach/utils/AppString.dart';
import 'package:silvertouch_contach/utils/FieldValidator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:silvertouch_contach/utils/AppColors.dart';
import 'package:silvertouch_contach/widgets/CommonDrawer.dart';
import 'package:silvertouch_contach/widgets/RoundedButton.dart';
import 'package:silvertouch_contach/widgets/TextFormInputField.dart';

class CategoryScreenUI extends StatefulWidget {
  const CategoryScreenUI({Key? key}) : super(key: key);

  @override
  State<CategoryScreenUI> createState() => _CategoryScreenUIState();
}

class _CategoryScreenUIState extends State<CategoryScreenUI> {

  final key = GlobalKey<FormState>();
  TextEditingController categoryController = TextEditingController();
  TextEditingController editCategoryController = TextEditingController();

  late Database database;
  List<Map> list= [];


  @override
  void initState() {
    super.initState();
    createDB();
  }

  createDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE category (id INTEGER PRIMARY KEY, category_name TEXT)');
          //await db.execute('CREATE TABLE contacts (id INTEGER PRIMARY KEY,image LONGTEXT, fname TEXT,lname TEXT, ph_number TEXT, email TEXT,category TEXT)');
        },);

    getData();

  }

  getData() async {
    list = await database.rawQuery('SELECT * FROM category');
    setState(() {
    });
  }

  @override
  Future<void> dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              SizedBox(height: 30,),


              Form(
                key: key,
                child: TextFormInputField(
                  hintText: "Add Category",
                  controller: categoryController,
                  validator: (value) {
                    return FieldValidator.validateValueIsEmpty(value!.toString());
                  },

                ),
              ),

              SizedBox(height: 20,),

              RoundedButton(
                text: "Save",
                onTap: () {

                  if(key.currentState!.validate()){
                    storeData();
                  }
                },
              ),

              SizedBox(height: 30,),


              list.isEmpty
                ? Center(child: Text("No Data Found!",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black38),))
                : Expanded(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.listColor.withOpacity(0.3),
                        border: Border.all(width: 1,color: Colors.deepOrange.withOpacity(0.1))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${list[index]['category_name']}",style: TextStyle(color: Colors.deepOrange),),

                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {

                                      editCategoryController.text = list[index]["category_name"];

                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context)=>
                                              editDialog(context,list[index]["id"].toString(),list[index]["category_name"])
                                      );
                                    },
                                    child: Icon(FontAwesomeIcons.edit,size: 19,)
                                  ),

                                  SizedBox(width: 20,),

                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context)=> deleteDialog(context,list[index]["id"].toString(),list[index]["category_name"])
                                      );
                                    },
                                    child: Icon(Icons.delete)
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )

            ],
          ),
        ),
      )
    );
  }


  Widget deleteDialog(BuildContext context,String id,String name) {
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
                                deleteData(id,name);
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
  Widget editDialog(BuildContext context,String id,String name) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: 300,
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
                            "Update",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize:20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormInputField(
                          controller: editCategoryController,
                          validator: (v){
                            return FieldValidator.validateValueIsEmpty(v!);
                          },
                        ),
                      ),

                      new Container(

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
                                editData(id,editCategoryController.text);
                                Get.back();
                              },
                              child: Container(
                                height: 44,
                                padding: EdgeInsets.only(
                                    top: 12,
                                    bottom: 12),
                                child: Center(
                                  child: new Text(
                                    'Save',
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



  storeData() async {
    if(categoryController.text.trim().isNotEmpty){
      await database.transaction((txn) async {
        int id1 = await txn.rawInsert(
            'INSERT INTO category(category_name) VALUES("${categoryController.text}")');
        print('inserted1: $id1');
      });

      categoryController.clear();
      setState(() {

      });
      getData();
    }
  }

  deleteData(String id, String name) async {
    await database.rawDelete('DELETE FROM category WHERE id = "$id"');
    getData();
  }

  editData(String id, String newCategory) async {
    await database.rawUpdate('UPDATE category SET category_name = "$newCategory" WHERE id = "$id"');
    getData();
  }

}
