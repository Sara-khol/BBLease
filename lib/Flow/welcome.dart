import 'package:bblease/Flow/Rental/active_rent.dart';
import 'package:bblease/Flow/UserInformation/ordersHistory.dart';
import 'package:bblease/Flow/registration/license_front.dart';
import 'package:bblease/Flow/registration/personal_details_form.dart';
import 'package:bblease/Flow/registration/tel_to_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/car.dart';
import '../Flow/Rental//search_car.dart';
import '../services/api_service.dart';
import 'Rental/dialogs.dart';
import 'Rental/map.dart';

class WelcomeForm extends StatefulWidget {
  const WelcomeForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WelcomeFormState();
  }

class _WelcomeFormState extends State<WelcomeForm>{


 @override
  void initState() {
       super.initState();
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           // SizedBox(height: 56.h),
            Text("Welcome to Bibilease",style: TextStyle(color: Color.fromRGBO(251, 37, 118, 1),fontWeight: FontWeight.w700,fontSize: 30.sp,),),
            SizedBox(height: 36.h),
            Image.asset('assets/images/BB.png',width: 392.w, fit: BoxFit.cover,),
            SizedBox(height: 48.h),
            Container(
              height: 48.h,
              width: 332.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(0, 222, 222, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 0.0,
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OrdersHistory()));
                    //departurePoint(context);

                  },
                  child: Text('הרשמה (משתמש חדש)',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),)),
            ),
            SizedBox(height: 12.h),
            Container(
              height: 48.h,
              width: 332.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(251, 37, 118, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 0.0,
                  ),
                  onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TelToRegistrationForm()));
                  },
                  child:  Text('ביצוע הזמנה למשתמש קיים',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),)),
            ),
          ],
        ),
      ),

   );
  }
}



