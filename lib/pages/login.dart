import 'package:bonvoyage/pages/register.dart';
import 'package:bonvoyage/common_widgets/formField.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final conUsername = TextEditingController();
  final conPassword = TextEditingController();
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
                      hintname: 'Username123',
                      icon: Icons.person),
                  SizedBox(height: 5.0),
                  getTextFormField(
                    controller: conPassword,
                    hintname: 'Password123',
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
                      onPressed: () {},
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
    );
  }
}
