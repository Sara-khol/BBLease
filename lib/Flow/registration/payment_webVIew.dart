import 'dart:async';

import 'package:bblease/Flow/registration/sucsses_registration.dart';
import 'package:bblease/Flow/registration/wait_for_approve_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../landspace_widget.dart';
import '../../models/class_user.dart';
import '../../services/api_service.dart';
import '../../utils/my_colors.dart';
import '../Dialogs/buttom_dialogs.dart';
import '../my_shared_preferences.dart';
// #enddocregion platform_imports

class PaymentWebView extends StatefulWidget {
  final String url;

  const PaymentWebView({super.key, required this.url});

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
                  mainWidget: buildContent(),
                  imageProperties: ImageProperties('l_register3.png', 618.w,'תמונת הרשמה שלב 3'),showAppBar: false,)
              : buildContent());
    });
  }

  setStatusForWeb() async
  {
      await Future.delayed(const Duration(seconds: 7));
        getStatus();
  }

  buildContent() {
    return SafeArea(
      child: Column(children: <Widget>[
        SizedBox(height: 24.h,),
       /* Padding(
          padding:  EdgeInsets.only(right: 23.w),
          child: Align(
              alignment: Alignment.topRight,
              child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios))),
        ),
        SizedBox(
          height: 25.h,
        ),*/
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
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  //decoration: BoxDecoration(border: Border.all(color: turquoiseColorApp)),
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
              )],
          ),
        )
      ]),
    );
  }

  getStatus() async {
    await ApiService().getStatusPayment(User().phoneNumber, (res) async {
      debugPrint('get status payment');
      debugPrint(res.toString());
      if (res) {
          MySharedPreferences().setLastUsage();
          MySharedPreferences().setUserId(User().userId);
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const SucssesRegistrationForm()),
        //     (route) => false);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const WAitForApproveScreen()),
              (route) => false);
        }
     else {
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
