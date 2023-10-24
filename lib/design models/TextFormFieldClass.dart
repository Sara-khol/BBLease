import 'package:flutter/material.dart';

import '../models/class_user.dart';

class TextFormFieldClass extends StatelessWidget {
  const TextFormFieldClass({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      cursorColor: Colors.black,
      decoration: InputDecoration(

        labelText: "שם פרטי",
        labelStyle:  TextStyle(fontSize: 18,
          fontWeight: FontWeight.w300,
          color:  Color.fromRGBO(15, 17, 21, 1),
          fontFamily: 'PLONI', ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
          color: Color.fromRGBO(15, 17, 21, 1),
        ),
        ),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
          color: Color.fromRGBO(15, 17, 21, 1),
        ),
        ),

        //  hintText: 'שם פרטי',

        hintStyle: TextStyle(fontSize: 18,
          fontWeight: FontWeight.w300,
          color:  Color.fromRGBO(15, 17, 21, 1),
          fontFamily: 'PLONI', ),

        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),

      ),
      style: const TextStyle(color: Color.fromRGBO(15, 17, 21, 1),),
    //  controller: _firstName,
      validator: (value) {
        if (value == null || value.isEmpty)
          return 'זהו שדה חובה';
      },
    //  onEditingComplete: () => User().firstName=_firstName.text,


    );
  }
}