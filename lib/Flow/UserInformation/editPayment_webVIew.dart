import 'dart:async';

import 'package:bblease/Flow/Dialogs/buttom_dialogs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../landspace_widget.dart';
import '../../models/class_user.dart';
import '../../services/api_service.dart';
import '../../utils/common_funcs.dart';
import '../../utils/my_colors.dart';
// #enddocregion platform_imports

class EditPaymentWebView extends StatefulWidget {
  final String url;
  final bool fromProfile;

  const EditPaymentWebView({super.key, required this.url,  this.fromProfile=true});

  @override
  State<EditPaymentWebView> createState() => _EditPaymentWebViewState();
}

class _EditPaymentWebViewState extends State<EditPaymentWebView> {
  // late final WebViewController _controller;

  late InAppWebViewController _webViewController;
  String url = "";
  double progress = 0;
  bool startCheckStatus=false;
  late bool _isMounted ;


  @override
  void initState() {
    super.initState();
    _isMounted=true;
    if(kIsWeb)
    {
      setStatusForWeb();
    }
  }

  setStatusForWeb() async
  {
    await Future.delayed(const Duration(seconds: 7));
   getStatus();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:LandSpaceWidget(mainWidget: buildContent(context), imageProperties:
      ImageProperties('l_register3.png', 1000.w,'תמונת פרטי רכב')));
  }

  buildContent(context) {
    return SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(children: <Widget>[
              SizedBox(height: 24.h,),
              Padding(
                padding:  EdgeInsets.only(right: 23.w),
                child: CommonFuncs().getBackButton(context),
              ),
              SizedBox(
                height: 5.h,
              ),
              Icon(
                Icons.account_circle_outlined,
                color: turquoiseColorApp,
                size: 60.w,
                weight: 100,
              ),
              SizedBox(
                height: 8.h,
              ), Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                   widget.fromProfile? 'פרופיל אישי':'פרטי אשראי',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: blackColorApp,
                      fontFamily: 'PLONI',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35.h,),
            if(widget.fromProfile)  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Image.asset('assets/icons/f7_creditcard.png'),
                    Text('  אמצעי תשלום',style: TextStyle(color: pinkColorApp, fontSize: 20.sp, fontWeight: FontWeight.normal,)),
                  ]
              ),
            if(widget.fromProfile)  SizedBox(
                height: 33.h,
              ),
              Expanded(
                child: Center(
                  child: Container(
                    width: 370.w,
                    height: 455.h,
                    margin: const EdgeInsets.all(10.0),
                    child: InAppWebView(
                      initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                      onWebViewCreated: (InAppWebViewController controller) {
                        _webViewController = controller;
                      },
                      onReceivedServerTrustAuthRequest:
                          (InAppWebViewController controller,
                          URLAuthenticationChallenge challenge) async {
                        return ServerTrustAuthResponse(
                            action: ServerTrustAuthResponseAction.PROCEED);
                      },
                      onProgressChanged:
                          (InAppWebViewController controller, int progress) async {
                        {
                          this.progress = progress / 100;
                          if(this.progress==1 && !startCheckStatus)
                          {
                            startCheckStatus=true;
                            await Future.delayed(const Duration(seconds: 3));
                            getStatus();
                            // Timer(const Duration(seconds: 3), () {getStatus();});
                          }
                          if(mounted) {
                            setState(() {});
                          }
                        }
                      },

                    ),
                  ),
                ),
              ),
            ]),
        ));
  }

  getStatus() async
  {
    await ApiService().getStatusPaymentAfterUpdate(User().phoneNumber, (res) async {
      debugPrint(res.toString());
      if(res)
        {
          if (!mounted) return; // prevents using invalid context
         displayMessage(context,message: 'הפרטים עודכנו בהצלחה',onClose: () =>  Navigator.pop(context),);
          Navigator.pop(context);
        }
     else
       {
         if(_isMounted) {
           await Future.delayed(const Duration(seconds: 3));
           getStatus();
         }
       }
    });
  }



  @override
  void dispose() {
    _isMounted=false;
    super.dispose();
  }
}
