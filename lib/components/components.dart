import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../modules/LoginScreen.dart';
import '../network/local.dart';

Widget defaultTextFiled({
  required TextEditingController MyController,
  required IconData myPrefixIcon,
  IconData? mySuffixIconBtn,
  IconData? mySuffixIcon,
  required final validation,
  required String labelTxt,
  required BorderRadius radius,
  required TextInputType txtType,
  final ontap,
  final  String? suftxt,
  final onChange,
  bool isPassword = true,
  final suffixPressed
}) =>
    TextFormField(
      obscureText: isPassword,
      onChanged: onChange,
      keyboardType: txtType,
      onTap: ontap,
      validator: validation,
      controller: MyController,
      decoration: InputDecoration(
        fillColor: Color(0xFFefefef),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: radius,
        ),
        prefixIcon: Icon(
          myPrefixIcon,
          color: Colors.black,
          size: 17,
        ),
        suffixIcon: IconButton(
          onPressed: suffixPressed ,
          icon:Icon(
            mySuffixIconBtn,
            color: Colors.black,
            size: 18,
          ),

        ),
        suffixText: suftxt,
        labelText: labelTxt,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );


Widget defaultButton({
  required final fun,
  String? Txt,
  Color? color,

})=> MaterialButton(
  disabledColor: Colors.grey,
  minWidth: double.infinity,
  padding: EdgeInsets.all(10.0),
  height: 45,
  onPressed: fun,
  color: color,
  child: Text(Txt!.toUpperCase(),
    style: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
  textColor: Colors.white,
);

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => widget),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
        (Route)=>false
);

Widget myDivider() => Container(
  height: 2,
  color: Colors.grey[300],
  width: double.infinity,
);

enum ToastStates {SUCCESS ,ERROR , WARNING}

Color? ChooseToastState(ToastStates states){

  Color color;
  switch(states){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;

    case ToastStates.ERROR:
      color = Colors.red;
      break;

    case ToastStates.WARNING:
      color = Colors.deepOrangeAccent;
      break;
  }
  return color;
}

void ShowToast({
  required String msg,
  required ToastStates states
})=>Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: ChooseToastState(states),
    textColor: Colors.white,
    fontSize: 15.0
);

void SignOut(context)=>OutlineButton(
  onPressed: (){
    CashHelper.removeData(key: 'uId').then((value){
      navigateAndFinish(context, AppLoginScreen());
    }).catchError((error){
      print(error.toString());
    });
  },
  child: Text('LOG OUT'),
);


