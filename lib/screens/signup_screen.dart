import 'package:authenticationtutorial/screens/login_screen.dart';
import 'package:authenticationtutorial/screens/models/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  void _showSuccessfulMessage(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("From Startup Projects"),
              content: Text(msg),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new LoginScreen()));
                    },
                    child: Text("Okay"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup Here"),
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
                        return "Enter Email";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 17,
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () async {
                    var message = "Your Registration was successful";
                    if (!_formkey.currentState!.validate()) {
                      return;
                    }
                    _formkey.currentState!.save();
                    try {
                      await Provider.of<Authentication>(context, listen: false)
                          .signUp(
                              _emailController.text, _passwordController.text);
                      _showSuccessfulMessage(message);
                    } catch (error) {
                      throw error;
                    }
                  },
                  child: Text("Signup"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
