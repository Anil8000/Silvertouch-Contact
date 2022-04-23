// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CommonDrawer(),
        appBar: AppBar(title: Text("Create and Store category"),),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              SizedBox(height: 30,),


              TextFormInputField(
                hintText: "Add Category",
                controller: categoryController,

              ),

              SizedBox(height: 20,),

              RoundedButton(
                text: "Save",
                onTap: () {

                },
              ),

              SizedBox(height: 30,),


              Expanded(
                child: ListView.builder(
                  itemCount: 5,
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
                            Text("Category $index",style: TextStyle(color: Colors.deepOrange),),

                              Row(
                                children: [
                                  Icon(Icons.mode_edit_outline_sharp),
                                  SizedBox(width: 5,),
                                  Icon(Icons.delete),
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
}
