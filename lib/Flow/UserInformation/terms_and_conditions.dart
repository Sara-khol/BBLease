//import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:bblease/utils/my_colors.dart' as colors;
import 'package:bblease/utils/common_funcs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../landspace_widget.dart';
import '../Rental/Actions/cancel_order_dialogs.dart';

class Terms extends StatefulWidget {
  const Terms({super.key, required this.index});
  final int index;

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {

  final String termsText = '''
תנאי שימוש באפליקציה / אתר
שירות השכרת רכב בשירות עצמי

1. כללי והסכמה
1.1 השימוש באפליקציה ו/או באתר (להלן: “האפליקציה”) כפוף לתנאי שימוש אלו ולכל דין.
1.2 שימוש באפליקציה, רישום, הזמנה או סימון תיבת הסכמה – מהווים אישור מלא, מחייב ובלתי חוזר לתנאים אלה.
1.3 אם אינך מסכים לתנאים – אינך רשאי לעשות שימוש באפליקציה.

2. שימוש באפליקציה
2.1 האפליקציה נועדה להזמנת רכבים, פתיחה, נעילה, ניהול השכרה, תשלומים וקבלת הודעות.
2.2 השימוש מותר אך ורק לשימוש אישי, פרטי וחוקי.
2.3 אין לעשות שימוש מסחרי, להעביר גישה לאחר, או לפעול בניגוד לייעוד האפליקציה.

3. רישום וחשבון משתמש
3.1 השימוש מותנה ברישום, מסירת פרטים נכונים ועדכניים, ואישור תנאי השימוש.
3.2 המשתמש אחראי לשמירת פרטי ההתחברות שלו ולכל פעולה שתבוצע באמצעות חשבונו.
3.3 החברה רשאית לחסום, להשעות או למחוק חשבון משתמש בכל מקרה של הפרה או חשד לשימוש בלתי תקין.

4. זמינות ותקינות השירות
4.1 האפליקציה ניתנת לשימוש כפי שהיא (AS IS).
4.2 ייתכנו תקלות, השבתות, עיכובים או חוסר זמינות – ולא תהיה למשתמש כל טענה בגין כך.
4.3 החברה אינה מתחייבת לזמינות רציפה או חפה מתקלות.

5. תשלומים וחיובים
5.1 השימוש בשירות כרוך בתשלום בהתאם למסלול שנבחר.
5.2 החברה רשאית לחייב את אמצעי התשלום של המשתמש בגין כל שימוש, הארכה, קנס, נזק או חיוב נלווה.
5.3 חיובים יכולים להתבצע גם לאחר סיום השימוש בפועל.
5.4 מחירים, מסלולים ותעריפים ניתנים לשינוי מעת לעת.

6. אחריות והגבלת אחריות
6.1 השימוש באפליקציה ובשירות הוא באחריות המשתמש בלבד.
6.2 החברה לא תישא באחריות לנזקים ישירים או עקיפים, לרבות אובדן רווח, זמן או עוגמת נפש.
6.3 החברה אינה אחראית לנזקים הנובעים משימוש שגוי, תקלה במכשיר המשתמש או חיבור אינטרנט.

7. קניין רוחני
7.1 כל זכויות הקניין הרוחני באפליקציה, בעיצוב, בתוכן ובקוד – שייכות לחברה בלבד.
7.2 אין להעתיק, לשכפל, להפיץ או לעשות שימוש כלשהו בתוכן ללא אישור מראש ובכתב.

8. פרטיות ושימוש במידע
8.1 החברה רשאית לאסוף מידע טכני, נתוני שימוש ומידע תפעולי לצורך הפעלת השירות.
8.2 המידע ישמש לתפעול, אבטחה, גבייה, שיפור השירות ועמידה בדרישות הדין.
8.3 המשתמש מסכים לקבל הודעות שירות, התראות ועדכונים באמצעים דיגיטליים.

9. הפסקת שימוש
9.1 המשתמש רשאי להפסיק שימוש באפליקציה בכל עת.
9.2 החברה רשאית להפסיק או להגביל שימוש באפליקציה או בשירות, לפי שיקול דעתה.
9.3 הפסקת שימוש אינה גורעת מחובות כספיים או התחייבויות קודמות.

10. שינויים בתנאי השימוש
10.1 החברה רשאית לעדכן תנאי שימוש אלו מעת לעת.
10.2 הנוסח המעודכן יחייב ממועד פרסומו באפליקציה או באתר.
10.3 המשך שימוש לאחר עדכון מהווה הסכמה לתנאים החדשים.

11. סמכות שיפוט ודין
11.1 הדין החל: דין מדינת ישראל.
11.2 סמכות שיפוט ייחודית: בתי המשפט המוסמכים במחוז ירושלים.

12. שונות
12.1 אי אכיפה של זכות לא תיחשב כויתור.
12.2 סעיף שיימצא בלתי תקף – לא יפגע ביתר התנאים.
12.3 תנאים אלה מהווים את ההסכם המלא לעניין השימוש באפליקציה.
''';

  final String rentalAgreement = '''
הסכם השכרת רכב

בין: בי.בי. רינט ליס (2021) בע"מ  
לבין: השוכר

1. מבוא והגדרות  
חוזה זה מסדיר את תנאי ההתקשרות בין החברה לבין השוכר לצורך שימוש בשירותי השכרת רכב.

2. תנאי זכאות ושימוש  
השימוש ברכב מותר לשוכר בלבד, בהתאם לתנאי ההסכם והדין.

3. שימוש ברכב  
השוכר מתחייב לנהוג ברכב בזהירות ולפעול בהתאם להוראות החוק.

4. תקופת השימוש והחזרת הרכב  
הרכב יוחזר במועד ובמצב תקין.

5. מצב הרכב  
על השוכר לדווח על כל תקלה או נזק באופן מיידי.

6. חניה וקנסות  
כל קנס או עבירה באחריות השוכר.

7. תאונה וגניבה  
יש לדווח מידית לחברה ולמשטרה.

8. ביטוח ואחריות  
הכיסוי הביטוחי כפוף לתנאי ההסכם.

9. תשלומים  
החברה רשאית לחייב בהתאם לשימוש.

10. מערכת ניטור  
הרכב כולל מערכת מעקב לצרכי תפעול.

11. סיום התקשרות  
החברה רשאית להפסיק את השירות בכל עת.

12. שונות  
הדין החל – מדינת ישראל.

13. הצהרת השוכר  
אני מאשר כי קראתי והסכמתי לתנאים.
''';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  LandSpaceWidget(mainWidget: buildContent(),imageProperties:ImageProperties('image5.png', 1000.w,'תמונת תקנון'),showAppBar: widget.index==3)
    );
  }

  buildContent() {
    return Padding(
      padding: EdgeInsets.only(
          left: 24.w, right: 24.w, top: 32.h, bottom: 20.h),
      child: Column(
        children: [
          CommonFuncs().getBackButton(context),
         // SizedBox(height: 40.h),
          Text(
            'תקנון ותנאי שימוש',
            style: TextStyle(
              color: const Color(0xFF0F1511),
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h,),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: SelectableText(
                  widget.index==2?rentalAgreement:termsText,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16.sp,
                    height: 1.7,
                    color: const Color(0xFF0F1511),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.index == 2,
            child: Container(
              margin: EdgeInsets.only(top: 10.h),
              width: 332.w,
              height: 48.h,
              child: FloatingActionButton.extended(
                label: Text(widget.index == 1 ||widget.index == 3 ? 'חזרה' : 'חתימה',
                  style: TextStyle(letterSpacing: 0.1,
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),),
                heroTag: "btn2",
                backgroundColor: colors.turquoiseColorApp,
                onPressed: () {
                  print('widget.index ${widget.index}');
                  if (widget.index == 2) {
                    signCancelOrderDialog(context, 'טופס אישור תנאים',
                        'קראתי ואני מאשר/ת את התנאים');
                  }

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
