import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../landspace_widget.dart';
import '../../../services/api_service.dart';
import '../../Dialogs/buttom_dialogs.dart';
import '../dialogs.dart';

class ReportAccident extends StatefulWidget {
  const ReportAccident({super.key});

  @override
  State<ReportAccident> createState() => _ReportAccidentState();
}

class _ReportAccidentState extends State<ReportAccident> {
  final TextEditingController _name=TextEditingController();
  final TextEditingController _phone=TextEditingController();
  final TextEditingController _email=TextEditingController();
  final TextEditingController _text=TextEditingController();

  XFile? image;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return LandSpaceWidget(mainWidget: buildContent(orientation),imageProperties:ImageProperties('image5.png', 1000.w,'תמונת פעולות'));
        }
        return buildContent(orientation);
      }),
    );
  }

  buildContent(o) {
    return SingleChildScrollView(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,left: 30.w,right: 30.w),
          child: Column(
            children: [
              SizedBox(height: 35.h,),
              if(o==Orientation.portrait)Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(onPressed: () =>Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios))),
              SizedBox(height: 41.h,),
              Text('דווח על תקלה',style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              SizedBox(height: 36.h,),
              Text('נתקלת בבעיה בהפעלת הרכב?\nבעיה באפליקציה?\nלכל שאלה אנחנו כאן :)',
                style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
              SizedBox(height: 39.h,),
              TextFormField(
                keyboardType: TextInputType.name,
                cursorColor: blackColorApp,
                decoration: getInputDecoration('שם מלא',332.w,suffixIcon:const Icon(Icons.account_circle_outlined)),
                style:
                TextStyle(color: blackColorApp, fontSize: 18 .sp),
                controller: _name,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'זהו שדה חובה';
                  return null;
                },
              ),
              SizedBox(height: 13.h,),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      cursorColor: blackColorApp,
                      decoration: getInputDecoration('טלפון',159.w,suffixIcon:const Icon(Icons.phone_outlined)),
                      style:
                      TextStyle(color: blackColorApp, fontSize: 18.sp),
                      controller: _phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'זהו שדה חובה';
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 13.w,),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: blackColorApp,
                      decoration: getInputDecoration('אימייל',160.w,suffixIcon:const Icon(Icons.email_outlined)),
                      style:
                      TextStyle(color: blackColorApp, fontSize: 18.sp),
                      controller: _email,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'זהו שדה חובה';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 13.h,),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                cursorColor: blackColorApp,
                decoration: getInputDecoration('ההודעה שלך',332.w),
                style: TextStyle(color: blackColorApp, fontSize: 18.sp),
                controller: _text,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'זהו שדה חובה';
                  return null;
                },
              ),
              SizedBox(height: 14.h,),
              SizedBox(
                height: 48.h,
                width: 332.w,
                child: FloatingActionButton(
                    backgroundColor: const Color(0xFF03AEB9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
                    onPressed: () =>imageSource(context),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        children: [
                          Icon(Icons.image,size: 24.h,color: Colors.white),
                          Expanded(
                            child: Center(
                              child: Text(
                                  image==null?'צרף תמונה':image!.name.length>=15?'${image!.name.substring(0,15)}...':image!.name,
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white)
                              ),
                            ),
                          ),
                          if( image!=null)   Image.asset('assets/icons/done.png',color: Colors.white,),
                        ],
                      ),
                    )
                ),
              ),
              SizedBox(height: 30.h,),
              SizedBox(
                width: 242.w,
                child: Text('נציגנו יקבלו את פנייתך ויענו לך בתוך 72 שעות מזמן הפניה.\n\nבמקרה חירום בהזמנה פעילה בלבד! נא לחייג ל 0000* שלוחה 0 ',
                    style: TextStyle(fontSize: 13.sp),textAlign: TextAlign.center),
              ),
              SizedBox(height: 15.h,),
              SizedBox(
                height: 48.h,
                width: 332.w,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: turquoiseColorApp,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () async {

                      showLoading(context);

                      ApiService().reportAccident( image, _text.text, _email.text, _phone.text, _name.text,(res) {
                        Navigator.pop(context);
                        displayMessageWithTitle(context,
                            title: '!תודה על פנייתך',
                            message: 'נציגנו יחזרו אליך בתוך 72 שעת מזמן הפניה',
                            textButton: 'חזור למסך הראשי',
                            onClose: () {
                              Navigator.pop(context);

                            });
                      },);
                    },
                    child: Text(
                      'צרו איתי קשר',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    )
                ),
              ),
              SizedBox(height: 20.h,),
            ],
          ),
        ),
      ),
    );
  }

  getInputDecoration1(String text,double width, {Widget? suffixIcon}) {
    return InputDecoration(
      constraints: BoxConstraints(maxWidth: width),
      isDense: true,
      labelText: text,
      labelStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w300,
        color: blackColorApp,
        fontFamily: 'PLONI',
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: blackColorApp,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: blackColorApp,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: blackColorApp,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 20.h),
      suffixIcon: suffixIcon,
    );
  }

  Future imageSource(context){
    return showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        isDismissible: true,
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
                    padding: EdgeInsets.only(right: 15.w,top: 12.h),
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
                          Text(
                            'צירוף תמונה',
                            style: TextStyle(
                                fontSize: 23.sp,
                                fontWeight: FontWeight.w700,
                                color: pinkColorApp),
                          ),
                          SizedBox(height: 80.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: !kIsWeb,
                                child: SizedBox(
                                  height: 48.h,
                                  width: 160.w,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: turquoiseColorApp,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        pickImage(ImageSource.camera);
                                      },
                                      child: Text('מצלמה',
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal))),
                                ),
                              ),
                           if(!kIsWeb)   SizedBox(width: 13.w),
                              Container(
                                height: 48.h,
                                width: 160.w,
                                padding: EdgeInsets.zero,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: turquoiseColorApp,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      pickImage(ImageSource.gallery);
                                    },
                                    child: Text('גלריה',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal)
                                    )),
                              ),
                            ],
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

  Future pickImage(ImageSource imageSource) async{
    final img = await ImagePicker().pickImage(source: imageSource);
    setState(() {
      image=img;
    });
  }
}
