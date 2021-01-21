import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/server.dart';

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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          onChanged: (value) {
            this.email = value;
          },
        ),
        TextField(
          onChanged: (value) {
            this.password = value;
          },
        ),
        RaisedButton(
            child: Text('REGISTER'),
            onPressed: () async {
              String id = await registerUsingEmailAndPassword(email, password);
              if (id != null) {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return MainPage();
                  },
                ));
              } else {}
            }),
        RaisedButton(
            child: Text('LOGIN'),
            onPressed: () async {
              String id = await loginUsingEmailAndPassword(email, password);
              if (id != null) {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return MainPage();
                  },
                ));
              } else {
                print('error');
              }
            }),
        RaisedButton(
            child: Text('SIGNOUT'),
            onPressed: () async {
              signOut();
            })
      ],
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
