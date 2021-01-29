import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/backend/server.dart';
import 'package:gsg_firebase/ui/widgets/customTextField.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: App(),
    );
  }
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error'),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return SplachScreen();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  String email;
  String password;
  String name;
  String city;
  String phoneNumber;

  saveEmail(String email) {
    this.email = email;
  }

  saveName(String name) {
    this.name = name;
  }

  savePassword(String password) {
    this.password = password;
  }

  saveCity(String city) {
    this.city = city;
  }

  savephone(String phone) {
    this.phoneNumber = phone;
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
      loginToMyAPP(this.email, this.password);

      // saveUser({
      //   'email': this.email,
      //   'password': this.password,
      //   'name': this.name,
      //   'city': this.city,
      //   'phone': this.phoneNumber
      // });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formKey,
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
            // CustomTextField(
            //   labelText: 'Name',
            //   saveFun: saveName,
            //   validationFun: nullValidation,
            // ),
            // CustomTextField(
            //   labelText: 'City',
            //   saveFun: saveCity,
            //   validationFun: nullValidation,
            // ),
            // CustomTextField(
            //   labelText: 'Phone',
            //   saveFun: savephone,
            //   validationFun: nullValidation,
            // ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text('REGISTER'),
                  onPressed: () async {
                    saveForm();
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text('you are authorized user'),
      ),
    );
  }
}

class SplachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value) {
      if (getUserId() != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return MainPage();
          },
        ));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ));
      }
    });
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }
}
