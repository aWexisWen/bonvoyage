import 'package:bonvoyage/pages/login.dart';
import 'package:flutter/material.dart';

import '../common_widgets/buttons.dart';
import '../common_widgets/formField.dart';
import 'package:bonvoyage/models/users.dart';
import 'package:bonvoyage/services/database_service.dart';

class Signupform extends StatefulWidget {
  const Signupform({Key? key}) : super(key: key);

  @override
  _SignupformState createState() => _SignupformState();
}

class _SignupformState extends State<Signupform> {
  final _formKey = new GlobalKey<FormState>();

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
        title: Text('Create your account'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color.fromARGB(255, 251, 64, 217),
                  Color.fromARGB(255, 243, 64, 64),
                ]),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                      icon: Icons.person_outline_rounded,
                      validator: (String? val) {
                        if (val == null) {
                          return "Value cannot be empty";
                        }
                        return null;
                      },
                    ),
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
                      child: ButtonGradient(
                          label: 'Sign Uppp',
                          textStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          borderRadius: 50,
                          gradientColor: const [
                            Color.fromARGB(255, 251, 64, 217),
                            Color.fromARGB(255, 243, 64, 64),
                          ],
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _onSave();
                              //SaveData
                            } else {
                              print("Validation Error");
                            }
                          }),
                      // child: TextButton(
                      //     child: const Text(
                      //       'Signup',
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //     onPressed: () {
                      //       if (_formKey.currentState!.validate()) {
                      //         _onSave();
                      //         //SaveData
                      //       } else {
                      //         print("Validation Error");
                      //       }
                      //     }),
                      decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account?'),
                          TextButton(
                            style: TextButton.styleFrom(primary: Colors.pink),
                            child: Text('Sign In'),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginForm()),
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
      ),
    );
  }
}
