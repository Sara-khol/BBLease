

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';



  String number = '0529528746';//set the number here
  Future call=_callNumber();
   _callNumber() async{
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }


