import 'dart:typed_data';
import 'package:bblease/Flow/Rental/Actions/cancelation_complete.dart';
import 'package:bblease/Flow/Rental/dialogs.dart';
import 'package:bblease/services/api_service.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signature/signature.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../../models/class_user.dart';
import 'cancel_order.dart';

Future cancelOrderDialog(context,rent){
  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      isDismissible: true,
      barrierColor: Colors.black12.withOpacity(0.1),
      elevation: 2,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      context: context,
      builder: (context) {
        return Directionality(
            textDirection: TextDirection.rtl,
            child: Wrap(
              children: [
                Container(
                  height: 28.h,
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w, ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(height: 7.h,),
                        Text(
                          'ביטול הזמנה',
                          style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                              color: pinkColorApp),
                        ),
                        Container(height: 45.h),
                        Text('האם הינך בטוח שברצונך לבטל הזמנה זו? ',style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal,),textDirection: TextDirection.rtl,),
                        Container(height: 32.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 48.h,
                              width: 160.w,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: turquoiseColorApp,
                                    padding: EdgeInsets.symmetric(horizontal: 18.w ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  onPressed: () {
                                    //rentalTerm(context);
                                  },
                                  child: Text('חזור להזמנות',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                        //height: 2.3
                                      ))),
                            ),
                            SizedBox(width: 13.w),

                            SizedBox(
                              height: 48.h,
                              width: 160.w,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: turquoiseColorApp,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  onPressed: () =>Navigator.push(context, MaterialPageRoute(builder:(context) => CancelOrder(rent: rent),)),
                                  child: Text('כן, המשך',
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                        //height: 2.3
                                      ))),
                            ),
                          ],
                        ),
                        Container(height: 22.h),
                      ]
                  ),
                ),
              ],
            )
        );
      }
  );
}

signCancelOrderDialog(context,String headline,String text,[orderId]) {

  final SignatureController controller = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

   showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
       backgroundColor: Colors.white,
       //barrierColor: Colors.black12.withOpacity(0.1),
      elevation: 2,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25)),),
      context: context,
      builder: (context) {
        return Directionality(
            textDirection: TextDirection.rtl,
            child: Wrap(
              children: [
                Container(
                  height: 28.h,
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w, ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '$headline  ',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.error_outline,color: pinkColorApp,)
                          ],
                        ),
                        SizedBox(height: 41.h),
                        Text(text,style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.normal,),textDirection: TextDirection.rtl,),
                        Container(
                            decoration: const BoxDecoration(border: Border(bottom: BorderSide(
                                color: Colors.black,
                                width: 1
                            ))),
                            height: 70.h,
                            width: 200,
                            child: Signature(
                              backgroundColor: Colors.transparent,
                              controller: controller,

                            )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  controller.clear();
                                },
                                child: Text('ניקוי חתימה',
                                  style: TextStyle(
                                      fontSize: 14.sp,color:
                                  turquoiseColorApp,
                                      decoration: TextDecoration.underline,
                                      decorationColor: turquoiseColorApp),)
                            ),
                            SizedBox(width: 55.w,)
                          ],
                        ),
                        SizedBox(
                          height: 48.h,
                          width: 332.w,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: turquoiseColorApp,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              onPressed: () async {
                                if (controller.isEmpty) {
                                  debugPrint('Signature is empty');
                                  return;
                                }

                                final signature = await controller.toPngBytes();

                                if (signature == null || signature.isEmpty) {
                                  debugPrint('Exported signature is empty');
                                  return;
                                }

                                debugPrint('signature length: ${signature.length}');
                                debugPrint('first bytes: ${signature.take(20).toList()}');

                                if (headline == "טופס אישור תנאים") {
                                  // final dir = await getTemporaryDirectory();
                                  // final file = File('${dir.path}/signature_test.png');
                                  // await file.writeAsBytes(signature);

                                 // debugPrint('saved path: ${file.path}');
                                //  debugPrint('saved length: ${await file.length()}');

                                  User().signature = signature;

                                 if (!context.mounted) return;
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                } else {
                                  showLoading(context);

                                  ApiService().signatureUpload(signature, orderId, () {
                                    Navigator.pop(context);
                                    debugPrint('onSuccess');
                                    controller.dispose();

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const CancelationComplete(),
                                      ),
                                    );
                                  });
                                }
                              },
                              child: Text('אישור',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      //height: 2.3
                                  )
                              )),
                        ),
                        SizedBox(height: 22.h),
                      ]
                  ),
                ),
              ],
            )
        );
      }
  );
}

Future<Uint8List?> exportSignature(SignatureController controller) async {
  final signature = await controller.toPngBytes();
  return signature;
}
/*
 Future<Image?> exportSignature(SignatureController controller) async {
  final SignatureController exportController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
    points: controller.points
  );
  final signature=await exportController.toImage();
  exportController.dispose();
  return signature;
}
*/
