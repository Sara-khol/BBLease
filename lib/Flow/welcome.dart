
import 'package:bblease/Flow/UserInformation/ordersHistory.dart';
import 'package:bblease/Flow/navigation.dart';
import 'package:bblease/Flow/registration/tel_to_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class WelcomeForm extends StatelessWidget {
  const WelcomeForm({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body:
      Center(
        child: Column(
         // shrinkWrap: true,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           SizedBox(height: 56.h),
            Text("Welcome to Bibilease",style: TextStyle(color: Color.fromRGBO(251, 37, 118, 1),fontWeight: FontWeight.w700,fontSize: 30.sp,),),
            SizedBox(height: 36.h),
            Expanded(child: Image.asset('assets/images/BB.png',width: 392.w, fit: BoxFit.contain)),
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
                   /* Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OrdersHistory()));*/
                    //departurePoint(context);

                  },
                  child: Text('צפו בסרטון ההדרכה שלנו',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),)),
            ),
            SizedBox(height: 12.h),
            Container(
              height: 48.h,
              width: 332.w,
              margin: EdgeInsets.only(bottom: 35.h),
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
                          MaterialPageRoute(builder: (context) => const Navigation()));
                  },
                  child:  Text('הבא',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),)),
            ),
          ],
        ),
      ),

   );
  }
}



