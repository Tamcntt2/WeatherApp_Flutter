import 'package:flutter/material.dart';
import 'package:weather_app/screens/login/login_screen.dart';

import '../../values/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff484B5B), Color(0xff2C2D35)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign Up',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'First Name',
                              hintStyle: TextStyle(
                                  color: AppColors.lightGrey,
                                  fontStyle: FontStyle.italic),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.5, color: Colors.redAccent),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.5, color: Colors.redAccent),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              )),
                        ),
                      ),
                      Container(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'Last Name',
                              hintStyle: TextStyle(
                                  color: AppColors.lightGrey,
                                  fontStyle: FontStyle.italic),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.5, color: Colors.redAccent),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.5, color: Colors.redAccent),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 15,
                  ),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                            color: AppColors.lightGrey,
                            fontStyle: FontStyle.italic),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.5, color: Colors.redAccent),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.5, color: Colors.redAccent),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        )),
                  ),
                  Container(
                    height: 15,
                  ),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        hintStyle: TextStyle(
                            color: AppColors.lightGrey,
                            fontStyle: FontStyle.italic),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.5, color: Colors.redAccent),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        suffixIconColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.5, color: Colors.redAccent),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        )),
                  ),
                  Container(height: 15),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    obscureText: _obscureText2,
                    decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText2
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscureText2 = !_obscureText2;
                            });
                          },
                        ),
                        hintStyle: TextStyle(
                            color: AppColors.lightGrey,
                            fontStyle: FontStyle.italic),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.5, color: Colors.redAccent),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        suffixIconColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.5, color: Colors.redAccent),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        )),
                  ),
                  Container(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _isChecked,
                        side: BorderSide(color: Colors.white),
                        activeColor: Colors.redAccent,
                        checkColor: Colors.white,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        },
                      ),
                      Text(
                        'I Agree with privacy and policy',
                        style: TextStyle(color: AppColors.lightGrey),
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an accout?',
                        style: TextStyle(color: AppColors.lightGrey),
                      ),
                      TextButton(
                        child: Text(
                          'Sign in',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                              (route) => false);
                        },
                      )
                    ],
                  ),
                ],
              )
            ]),
      ),
    ));
  }
}
