import 'package:flutter/material.dart';
import 'package:gsg_firebase/backend/server.dart';
import 'package:gsg_firebase/ui/widgets/customTextField.dart';

class LoginPage extends StatelessWidget {
  String email;
  String password;

  saveEmail(String email) {
    this.email = email;
  }

  savePassword(String password) {
    this.password = password;
  }

  nullValidation(String value) {
    if (value == '') {
      return 'required field';
    }
  }

  GlobalKey<FormState> formKey = GlobalKey();
  saveForm() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      loginToMyAPP(
        this.email,
        this.password,
      );
    } else {
      return;
    }
  }

  String roleName;
  setRoleName(String value) {
    this.roleName = value;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  signOut();
                })
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    labelText: 'Email',
                    saveFun: saveEmail,
                    validationFun: nullValidation,
                  ),
                  CustomTextField(
                    labelText: 'Password',
                    saveFun: savePassword,
                    validationFun: nullValidation,
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text('LOGIN'),
                        onPressed: () async {
                          saveForm();
                        }),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
