// ignore_for_file: prefer_if_null_operators, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silvertouch_contach/utils/AppColors.dart';
import 'package:silvertouch_contach/utils/AppString.dart';

class TextFormInputField extends StatelessWidget {

  final TextEditingController? controller;
  final String? hintText;
  final IconData? iconSuffix;
  final IconData? iconPrefix;
  final TextInputType? keyboardType;
  final int? maxLength;
  final GestureTapCallback? onPressedSuffix;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final FocusNode? focusNode;
  ValueChanged<String>? onChanged;

  TextFormInputField({ this.hintText,
      this.controller,
     this.iconSuffix,
     this.iconPrefix,
     this.onPressedSuffix,
     this.keyboardType,
      this.maxLength,
     this.validator,
     this.onChanged,
     this.onSaved,
     this.focusNode});

  @override
  Widget build(BuildContext context,) {
    return Stack(

      children: [
        Container(
          width: Get.width,
          height:Get.height/14,
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextFormField(
            cursorColor: AppColors.primaryColor,
            style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold),
            validator: validator==null?null:validator,
            onSaved: onSaved==null?null:onSaved,

            onChanged: onChanged==null?null:onChanged,
            controller: controller==null?null:controller,
            focusNode: focusNode==null?null:focusNode,
            keyboardType: keyboardType==null?TextInputType.text : keyboardType,
            maxLength: maxLength==null?null:maxLength,
            decoration:  InputDecoration(
              fillColor: Colors.transparent,
              border: InputBorder.none,
              hintText: hintText,
              contentPadding:  EdgeInsets.symmetric(vertical: 10.0,horizontal:8.0),
              hintStyle: TextStyle(color: Colors.black87), filled: true,
              disabledBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor,width: 1),),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor,width: 1),),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor,width: 1),),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor,width: 1),),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor,width: 1),),
              prefixIcon: iconPrefix==null? null: Icon(iconPrefix,color: AppColors.primaryColor),
              suffixIcon:  iconSuffix==null? null: InkWell(
                  onTap: onPressedSuffix,
                  child: Icon(iconSuffix,color: AppColors.primaryColor)),
            ),



          ),
        ),

      ],
    );
  }
}







