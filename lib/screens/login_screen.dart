import 'package:authenticationtutorial/screens/home_screen.dart';
import 'package:authenticationtutorial/screens/models/authentication.dart';
import 'package:authenticationtutorial/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("From Startup Projects"),
              content: Text(msg),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Okay"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Here"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new SignupScreen()));
              },
              icon: Icon(Icons.login_sharp))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: "Enter Email"),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Enter Email";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 13,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(hintText: "Enter Password"),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Enter Password";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 17,
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () async {
                    if (!_formkey.currentState!.validate()) {
                      return;
                    }
                    _formkey.currentState!.save();
                    try {
                      await Provider.of<Authentication>(context, listen: false)
                          .logIn(
                              _emailController.text, _passwordController.text);
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new HomeScreen()));
                    } catch (error) {
                      var errorMessage =
                          "Authentication failed!please try again later";
                      _showErrorDialog(errorMessage);
                    }
                  },
                  child: Text("Login"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
