// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:silvertouch_contach/utils/AppColors.dart';
import 'package:silvertouch_contach/utils/AppString.dart';

class ContactListScreenUI extends StatefulWidget {
  const ContactListScreenUI({Key? key}) : super(key: key);

  @override
  State<ContactListScreenUI> createState() => _ContactListScreenUIState();
}

class _ContactListScreenUIState extends State<ContactListScreenUI> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: 12,
            itemBuilder: (context, index) {
              return Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(radius: 28,),

                          SizedBox(width: 15,),

                          Text("Name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.black54),),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.edit,size: 20,),

                          SizedBox(width: 10,),

                          Icon(Icons.delete),
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
}
