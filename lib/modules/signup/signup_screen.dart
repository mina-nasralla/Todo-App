// ignore_for_file: avoid_print, camel_case_types

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/modules/login/login_screen.dart';

class signupScreen extends StatefulWidget {
  const signupScreen({Key? key}) : super(key: key);

  @override
  State<signupScreen> createState() => signupScreenState();
}

class signupScreenState extends State<signupScreen>
    with TickerProviderStateMixin {
  late final TextEditingController _passTextController =
  TextEditingController(text: '');
  late final TextEditingController _emailTextController =
  TextEditingController(text: '');
  late final TextEditingController _nameTextController =
  TextEditingController(text: '');

  bool x = true;
  final loginformkey = GlobalKey<FormState>();

  void submitlogin() {
    final isValid = loginformkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      print('form v');
    } else {
      print('not');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          //Image(image: image)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                SizedBox(height: size.height * 0.1),
                const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 35,
                    color: Color(0xff1b1b57),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                //Email field
                Form(
                  key: loginformkey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field required';
                          }
                          return null;
                        },
                        controller: _nameTextController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.blueAccent,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Color(0xff1b1b57),
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Full name',
                          hintStyle: TextStyle(
                            fontSize: 20,
                            color: Color(0xff1b1b57),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff1b1b57)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff1b1b57)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty ||
                              !value.contains('@') ||
                              !value.contains('.com')) {
                            return 'please enter a valid Email address';
                          }
                          return null;
                        },
                        controller: _emailTextController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.blueAccent,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Color(0xff1b1b57),
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          hintText: ' Email',
                          hintStyle: TextStyle(
                            fontSize: 20,
                            color: Color(0xff1b1b57),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff1b1b57)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff1b1b57)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      //Password field
                      TextFormField(
                        obscureText: x,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field required';
                          }
                          return null;
                        },
                        controller: _passTextController,
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: Colors.blueAccent,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Color(0xff1b1b57),
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            child: Icon(
                              x ? Icons.visibility_off : Icons.visibility,
                              color: const Color(0xff1b1b57),
                            ),
                            onTap: () {
                              setState(() {
                                x = !x;
                              });
                            },
                          ),
                          hintText: ' Password',
                          hintStyle: const TextStyle(
                            fontSize: 20,
                            color: Color(0xff1b1b57),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff1b1b57)),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff1b1b57)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forget your password ?',
                            style: TextStyle(
                                color: Color(0xff1b1b57),
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                fontStyle: FontStyle.italic),
                          )),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                MaterialButton(
                  elevation: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: const Color(0xffc0c0e5),
                  onPressed: () {
                    submitlogin();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 17),
                        child: Text(
                          'Sign up',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff1b1b57),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.add_card_sharp)
                    ],
                  ),
                ),

                const SizedBox(height: 25),
                RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: 'Already have an account ?',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff1b1b57),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(text: '     '),
                      TextSpan(
                        text: 'Sign in ',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  const loginScreen())),

                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 17,
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ])),
                SizedBox(height: size.height * .05),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
