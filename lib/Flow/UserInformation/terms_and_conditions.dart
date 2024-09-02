//import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:bblease/utils/my_colors.dart' as colors;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../customWidgets/appBarB.dart';

import '../../landspace_widget.dart';
import '../../models/class_user.dart';
import '../Rental/Actions/cancel_order_dialogs.dart';

class Terms extends StatefulWidget {
  const Terms({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {

  String lorem='''לורם איפסום דולור סיט אמט, קונסקטורר אדיפיסינג אלית גולר מונפרר סוברט לורם שבצק יהול, לכנוץ בעריר גק ליץ, ושבעגט ליבם סולגק. בראיט ולחת צורק מונחף, בגורמי מגמש. תרבנך וסתעד לכנו סתשם השמה - לתכי מורגם בורק? לתיג ישבעס.

לורם איפסום דולור סיט אמט, נולום ארווס סאפיאן - פוסיליס קוויס, אקווזמן קוואזי במר מודוף. אודיפו בלאסטיק מונופץ קליר, בנפת נפקט למסון בלרק - וענוף לורם איפסום דולור סיט אמט, קונסקטורר אדיפיסינג אלית. סת אלמנקום ניסי נון ניבאה. דס איאקוליס וולופטה דיאם.

וסטיבולום אט דולור, קראס אגת לקטוס וואל אאוגו וסטיבולום סוליסי טידום בעליק. קולהע צופעט למרקוח איבן איף, ברומץ כלרשט מיחוצים. קלאצי סחטיר בלובק. תצטנפל בלינדו למרקל אס לכימפו, דול, צוט ומעיוט - לפתיעם ברשג - ולתיעם גדדיש. קוויז דומור ליאמום בלינך רוגצה. לפמעט''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.landscape)
          return LandSpaceWidget(mainWidget: buildContent(),imageProperties:ImageProperties('image5.png', 1000.w,'תמונת תקנון'));
        return buildContent();
      }),


    );
  }

  buildContent() {
    return Padding(
      padding: EdgeInsets.only(
          left: 24.w, right: 24.w, top: 32.h, bottom: 20.h),
      child: Column(
        children: [

          SizedBox(height: 80.h,),
          Text(
            'תקנון ותנאי שימוש',
            style: TextStyle(
              color: Color(0xFF0F1511),
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h,),
          Expanded(
              child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(lorem * 3,textDirection: TextDirection.rtl,),
                  )
              )
          ),
          Visibility(
            visible: widget.index == 2,
            child: Container(
              margin: EdgeInsets.only(top: 10.h),
              width: 332.w,
              height: 48.h,
              child: FloatingActionButton.extended(
                label: Text(widget.index == 1 ? 'חזרה' : 'חתימה',
                  style: TextStyle(letterSpacing: 0.1,
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),),
                heroTag: "btn2",
                backgroundColor: colors.turquoiseColorApp,
                onPressed: () {
                  print('widget.index ${widget.index}');
                  if (widget.index == 2)
                    signCancelOrderDialog(context, 'טופס אישור תנאים',
                        'קראתי ואני מאשר/ת את התנאים');

                  // Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
