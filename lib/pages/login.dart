import 'package:bonvoyage/pages/ticket_form_page.dart';
import 'package:bonvoyage/pages/register.dart';
import 'package:bonvoyage/common_widgets/formField.dart';
import 'package:flutter/material.dart';
import 'package:bonvoyage/models/users.dart';
import 'package:bonvoyage/services/database_service.dart';

import '../common_widgets/buttons.dart';

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
        elevation: 0,
        backgroundColor: Colors.pink,
        title: Text('BON VOYAGE', style: TextStyle(fontFamily: 'Righteous')),
        centerTitle: true,
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                    child: ButtonGradient(
                      label: 'Login',
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
                        User user = User(
                            username: conUsername.text,
                            password: conPassword.text);
                        _databaseService.userLogin(user, context);
                      },
                    ),
                    // child: TextButton(
                    //   child: Text(
                    //     'Login',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    //   onPressed: () {
                    //     User user = User(
                    //         username: conUsername.text,
                    //         password: conPassword.text);
                    //     _databaseService.userLogin(user, context);
                    //   },
                    // ),
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
                          style: TextButton.styleFrom(primary: Colors.pink),
                          child: Text('Sign Up'),
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
    );
  }
}
