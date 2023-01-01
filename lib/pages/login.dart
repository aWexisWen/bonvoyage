import 'package:bonvoyage/pages/ticket_form_page.dart';
import 'package:bonvoyage/pages/register.dart';
import 'package:bonvoyage/common_widgets/formField.dart';
import 'package:flutter/material.dart';
import 'package:bonvoyage/models/users.dart';
import 'package:bonvoyage/services/database_service.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final conUsername = TextEditingController();
  final conPassword = TextEditingController();
  final DatabaseServices _databaseService = DatabaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Signup'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
           key: _formKey,
          child: Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40.0),
                    Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30.0),
                    ),
                    SizedBox(height: 0.5),
                    Image.asset(
                      "assets/logo.png",
                      // scale: 2.0,
        
                      height: 200.0,
                      width: 500.0,
                    ),
                    getTextFormField(
                        controller: conUsername,
                        hintname: 'Username',
                        icon: Icons.person),
                    SizedBox(height: 5.0),
                    getTextFormField(
                      controller: conPassword,
                      hintname: 'Password',
                      icon: Icons.lock,
                      isObscureText: true,
                    ),
                    Container(
                      margin: EdgeInsets.all(30.0),
                      width: double.infinity,
                      child: TextButton(
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          User user = User(
                              username: conUsername.text,
                              password: conPassword.text);
                          _databaseService.userLogin(user, context);
                        },
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Does not have an account?'),
                          TextButton(
                            style: TextButton.styleFrom(primary: Colors.blue),
                            child: Text('Signup'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Signupform()));
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
