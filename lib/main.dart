import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gsg_firebase/backend/server.dart';
import 'package:gsg_firebase/ui/pages/loginpage.dart';
import 'package:gsg_firebase/ui/widgets/customTextField.dart';
import 'package:gsg_firebase/utilities/styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetMaterialApp(
      home: MaterialApp(
        home: App(),
        theme: ThemeData(
            textTheme: TextTheme(
          body1: profileStyle.copyWith(fontWeight: FontWeight.w700),
        )),
      ),
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
          return LoginPage();
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

      saveUser({
        'email': this.email,
        'password': this.password,
        'name': this.name,
        'city': this.city,
        'phone': this.phoneNumber,
        'role': this.roleName
      });
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
                  UserType(setRoleName),
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
                  CustomTextField(
                    labelText: 'Name',
                    saveFun: saveName,
                    validationFun: nullValidation,
                  ),
                  CustomTextField(
                    labelText: 'City',
                    saveFun: saveCity,
                    validationFun: nullValidation,
                  ),
                  CustomTextField(
                    labelText: 'Phone',
                    saveFun: savephone,
                    validationFun: nullValidation,
                  ),
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
          ),
        ));
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('main'),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                signOut();
              })
        ],
      ),
      body: Center(
        child: Text('you are authorized user'),
      ),
    );
  }
}

class SplachScreen extends StatefulWidget {
  @override
  _SplachScreenState createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  fetchData() {
    String userId = getUserId();
    if (userId != null) {
      fetchUserData(userId);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

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

class UserType extends StatefulWidget {
  Function fun;
  UserType(this.fun);
  @override
  _UserTypeState createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  String groupValue;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Expanded(
            child: RadioListTile(
          title: Text('Mershant'),
          value: 'mershant',
          groupValue: groupValue,
          onChanged: (value) {
            this.groupValue = value;
            setState(() {
              widget.fun(value);
            });
          },
        )),
        Expanded(
            child: RadioListTile(
          title: Text('Customer'),
          value: 'customer',
          groupValue: groupValue,
          onChanged: (value) {
            this.groupValue = value;
            setState(() {
              widget.fun(value);
            });
          },
        ))
      ],
    );
  }
}
