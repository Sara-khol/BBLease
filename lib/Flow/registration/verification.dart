import 'package:bblease/Flow/registration/personal_details_form.dart';
import 'package:bblease/models/class_user.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../landspace_widget.dart';
import '../../services/api_service.dart';
import '../Dialogs/buttom_dialogs.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {

  uploadImages() async{
    print('uploadImages()');
    await ApiService().fileUpload(() {
      print('files successfully uploaded');

      Navigator.push(context,
            MaterialPageRoute(builder: (context) => PersonalDetailsForm(),));
        }
    );
  }

  faceDetection(){
    ApiService().faceRecognition(User().phoneNumber, (res) async {
      print('face recognition result: $res');
      if(res==false) {
        await displayErrorInValidation(context);
      }
      uploadImages();
    });
  }

  @override
  void initState() {
    faceDetection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: OrientationBuilder(builder: (c,o){
        return o==Orientation.landscape?
        LandSpaceWidget(mainWidget: buildContent(), imageProperties: ImageProperties('image5.png', 1000.w,'תמונת ביצוע פעולות')) :buildContent();
      },) ,
    );
  }

  buildContent(){
    return Center(
      child: SizedBox(
        width: 250.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //SizedBox(height: 120.h,),
            Text('התצלום נשלח לבדיקה',style: TextStyle(fontSize: 32.sp,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl,textAlign: TextAlign.center,),
            SizedBox(height: 50.h,),
            Text('המערכת בסריקה',style: TextStyle(fontSize: 28.sp,fontWeight: FontWeight.bold),),
            SizedBox(height: 30.h,),
            Text('תהליך זה עלול להימשך כמה דקות אנא התאזר בסבלנות תודה',style: TextStyle(fontSize: 22.sp),textDirection: TextDirection.rtl,textAlign: TextAlign.center,),
            SizedBox(height: 30.h,),
            CircularProgressIndicator(color: pinkColorApp,)
            //Image(image: XFileImage(User().regImages[2]!)),
          ],
        ),
      ),
    );
  }
}
