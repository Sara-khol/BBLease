import 'package:bblease/class_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;


class LicenseDetails extends StatefulWidget {
  const LicenseDetails({Key? key}) : super(key: key);

  @override
  State<LicenseDetails> createState() => _LicenseDetailsState();
}

class _LicenseDetailsState extends State<LicenseDetails> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _licenseId=TextEditingController();
  TextEditingController _expDate=TextEditingController();
  TextEditingController _issDate=TextEditingController();
  TextEditingController _degree=TextEditingController();

  late DateTime exp;
  late DateTime iss;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('פרטי רשיון'),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'מספר רשיון נהיגה',
                ),
                style: const TextStyle(color: Colors.blueAccent),
                controller: _licenseId,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'זהו שדה חובה';
                },
                onEditingComplete: () => User().firstName=_licenseId.text,
              ),
              SizedBox(height: 16.h,),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'תוקף',
                ),
                style: const TextStyle(color: Colors.blueAccent),
                controller: _licenseId,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'זהו שדה חובה';
                },
                onTap: () async {
                  DateTime? date= await showDatePicker(context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100));
                  if(date!=null)
                    setState(() {
                      _expDate.text=intl.DateFormat('dd-mm-yyyy').format(date);
                      exp=date;
                    });
                },
                onEditingComplete: () => User().licenseExpDate=exp,
              ),
              SizedBox(height: 16.h,),

              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'תאריך הנפקה',
                ),
                style: const TextStyle(color: Colors.blueAccent),
                controller: _licenseId,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'זהו שדה חובה';
                },
                onTap: () async {
                  DateTime? date= await showDatePicker(context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now());
                  if(date!=null)
                    setState(() {
                      _issDate.text=intl.DateFormat('dd-mm-yyyy').format(date);
                      iss=date;
                    });
                },
                onEditingComplete: () => User().licenseIssDate=iss,
              ),
              SizedBox(height: 16.h,),

              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'דרגת רשיון',
                ),
                style: const TextStyle(color: Colors.blueAccent),
                controller: _licenseId,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'זהו שדה חובה';
                },
                onEditingComplete: () => User().licenseDegree=_degree.text,
              ),
              SizedBox(height: 60.h,),
              Row(
                children: [
                  Text('נהג חדש'),
                  Checkbox(value: User().isNewDriver, onChanged: (value) => User().isNewDriver=value!),
                  Radio(value: User().isNewDriver,
                      groupValue: User().isNewDriver,
                      onChanged: (value) => User().isNewDriver=value!)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
