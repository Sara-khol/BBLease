import 'dart:async';

import 'package:bblease/Flow/registration/sucsses_registration.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../landspace_widget.dart';
import '../../models/class_user.dart';
import '../../services/api_service.dart';
import '../../utils/my_colors.dart';
import '../my_shared_preferences.dart';
// #enddocregion platform_imports

class PaymentWebView extends StatefulWidget {
  final String url;
  final int index;

  const PaymentWebView({super.key, required this.url, required this.index});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  // late final WebViewController _controller;

  late InAppWebViewController _webViewController;
  String url = "";
  double progress = 0;
  bool startCheckStatus = false;
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

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
          body: orientation == Orientation.landscape
              ? LandSpaceWidget(
                  mainWidget: buildContent(orientation),
                  imageProperties: ImageProperties('l_register3.png', 618.w,'תמונת הרשמה שלב 3'),showAppBar: false,)
              : buildContent(orientation));
    });
  }

  setStatusForWeb() async
  {
      await Future.delayed(const Duration(seconds: 7));
      getStatus();
  }

  buildContent(Orientation o) {
    return SafeArea(
      child: Column(children: <Widget>[
        SizedBox(height: 24.h,),
        Padding(
          padding:  EdgeInsets.only(right: 23.w),
          child: Align(
              alignment: Alignment.topRight,
              child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios))),
        ),
        SizedBox(
          height: 25.h,
        ),
        Icon(
          Icons.account_circle_outlined,
          color: turquoiseColorApp,
          size: 60.w,
          weight: 100,
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'פרטי אשראי',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: blackColorApp,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 34.h,
        ),
        /*Container(
            padding: EdgeInsets.only(top: 15.h),
            child: progress < 1.0
                ? LinearProgressIndicator(
                    value: progress,
                    color: pinkColorApp,
                    backgroundColor: pinkColorApp.withOpacity(0.2),
                  )
                : Container()),*/
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  //width:o==Orientation.portrait? 370.w:550.w,
                  // height:o==Orientation.portrait? 455.h:650.h,
                //  height: 455.h,
                  margin: const EdgeInsets.all(10.0),
                  //decoration: BoxDecoration(border: Border.all(color: turquoiseColorApp)),
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                    // initialUrl: "https://flutter.dev/",
                    // initialOptions: InAppWebViewGroupOptions(
                    //     crossPlatform: InAppWebViewOptions(
                    //       debuggingEnabled: true,
                    //     )
                    // ),
                    onWebViewCreated: (InAppWebViewController controller) {
                      _webViewController = controller;
                    },
                    onReceivedServerTrustAuthRequest:
                        (InAppWebViewController controller,
                            URLAuthenticationChallenge challenge) async {
                      return ServerTrustAuthResponse(
                          action: ServerTrustAuthResponseAction.PROCEED);
                    },
                    onProgressChanged: (InAppWebViewController controller, int progress) async {
                        this.progress = progress / 100;
                        if (this.progress == 1 && !startCheckStatus) {
                          startCheckStatus = true;
                          await Future.delayed(const Duration(seconds: 3));
                          getStatus();
                      }
                        if (mounted) {
                          setState(() {});
                        }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 100.h,
                child: Center(
                  child: Text(
                    '!נא להכניס אשראי על שמך בלבד',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
        // ButtonBar(
        //   alignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     ElevatedButton(
        //       child: Icon(Icons.arrow_back),
        //       onPressed: () {
        //         if (_webViewController != null) {
        //           _webViewController.goBack();
        //         }
        //       },
        //     ),
        //     ElevatedButton(
        //       child: Icon(Icons.arrow_forward),
        //       onPressed: () {
        //         if (_webViewController != null) {
        //           _webViewController.goForward();
        //         }
        //       },
        //     ),
        //     ElevatedButton(
        //       child: Icon(Icons.refresh),
        //       onPressed: () {
        //         if (_webViewController != null) {
        //           _webViewController.reload();
        //         }
        //       },
        //     ),
        //   ],
        // ),
        // SizedBox(
        //   height: 20.h,
        // ),
        // Container(
        //   width: 160.w,
        //   height: 48.h,
        //   margin: EdgeInsets.only(bottom: 40.h),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.all(Radius.circular(25)),
        //     color: turquoiseColorApp,
        //   ),
        //   child: TextButton(
        //     child: Text('אישור',
        //         style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 22.sp,
        //             fontWeight: FontWeight.normal)),
        //     onPressed: () {
        //       getStatus();
        //     },
        //   ),
        // ),
      ]),
    );
  }

  getStatus() async {
    await ApiService().getStatusPayment(User().phoneNumber, (res) async {
      print('get status payment');
      print(res);
      if (res) {
        if (widget.index == 2) {
          Navigator.pop(context);
        }
        else {
          MySharedPreferences().setLastUsage();
          MySharedPreferences().setUserId(User().userId);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const SucssesRegistrationForm()),
              (route) => false);
        }
      } else {
        if (_isMounted) {
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
