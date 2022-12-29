import 'package:bonvoyage/pages/login.dart';
import 'package:flutter/material.dart';

import '../common_widgets/formField.dart';
import 'package:bonvoyage/models/users.dart';
import 'package:bonvoyage/services/database_service.dart';

class Signupform extends StatefulWidget {
  const Signupform({Key? key}) : super(key: key);

  @override
  _SignupformState createState() => _SignupformState();
}

class _SignupformState extends State<Signupform> {
  final conFirstName = TextEditingController();
  final conLastName = TextEditingController();
  final conUsername = TextEditingController();
  final conPassword = TextEditingController();
  final conMobileNum = TextEditingController();
  final DatabaseServices _databaseService = DatabaseServices();

  Future<void> _onSave() async {
    await _databaseService.registerUser(
      User(
          f_name: conFirstName.text,
          l_name: conLastName.text,
          username: conUsername.text,
          password: conPassword.text,
          mobilehp: conMobileNum.text),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Signup'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: 40.0),
                  // Text(
                  //   'Login',
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.black,
                  //       fontSize: 30.0),
                  // ),
                  SizedBox(height: 0.5),
                  Image.asset(
                    "assets/logo.png",
                    // scale: 2.0,

                    height: 200.0,
                    width: 500.0,
                  ),
                  getTextFormField(
                      controller: conFirstName,
                      hintname: 'First Name',
                      inputType: TextInputType.name,
                      icon: Icons.person_outline_rounded),
                  SizedBox(height: 5.0),
                  getTextFormField(
                    controller: conLastName,
                    hintname: 'Last Name',
                    inputType: TextInputType.name,
                    icon: Icons.person_pin_outlined,
                  ),
                  SizedBox(height: 5.0),

                  getTextFormField(
                      controller: conUsername,
                      hintname: 'Username',
                      icon: Icons.person,
                      inputType: TextInputType.name),

                  SizedBox(height: 5.0),
                  getTextFormField(
                    controller: conPassword,
                    hintname: 'Password',
                    icon: Icons.lock,
                    isObscureText: true,
                  ),
                  SizedBox(height: 5.0),
                  getTextFormField(
                    controller: conMobileNum,
                    hintname: 'Mobile Number',
                    icon: Icons.phone,
                  ),
                  SizedBox(height: 5.0),

                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: TextButton(
                      child: Text(
                        'Signup',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _onSave,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?'),
                        TextButton(
                          style: TextButton.styleFrom(primary: Colors.blue),
                          child: Text('Sign In'),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => LoginForm()),
                                (Route<dynamic> route) => false);
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
