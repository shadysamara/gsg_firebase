import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  Function validationFun;
  Function saveFun;
  String labelText;
  CustomTextField({this.labelText, this.saveFun, this.validationFun});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        TextFormField(
          validator: (value) => validationFun(value),
          decoration: InputDecoration(
              labelText: labelText,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
          onSaved: (value) {
            saveFun(value);
          },
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
