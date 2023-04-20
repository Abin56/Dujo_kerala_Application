
import 'package:flutter/material.dart';

import '../../../fonts/fonts.dart';

class SigninTextFormfield extends StatelessWidget {
   SigninTextFormfield({
    super.key,
    // required this.textEditingController, 
     required this.labelText, 
     //required this.function,
     required this.icon,
  });
 // final TextEditingController textEditingController;
  final String labelText;
  //final String? Function(String? fieldContent) function;
        IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: TextFormField(
      // validator: function,
       //controller: textEditingController,
       decoration: InputDecoration(
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
         icon:  Icon(icon,
           color: Color.fromARGB(221, 13, 94, 243),
         ),
         labelText:labelText,hintStyle: DGoogleFonts.subhintTextStyle
       ),
        ),
    );
  }
}