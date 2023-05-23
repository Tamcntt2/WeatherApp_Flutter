import 'package:flutter/material.dart';
import 'package:weather_app/screens/drawer/register.dart';
import 'package:weather_app/values/app_assets.dart';

import '../../values/app_colors.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
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
                'Log In',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
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
                  Container(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                            'Remember me',
                            style: TextStyle(color: AppColors.lightGrey),
                          ),
                        ],
                      ),
                      Text(
                        'Forgot password',
                        style: TextStyle(color: Colors.redAccent),
                      )
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
                        'Log in',
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
                  Text(
                    'Or Sign in with',
                    style: TextStyle(color: AppColors.lightGrey),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                            AppAssets.google,
                          )),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.transparent)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an accout?',
                        style: TextStyle(color: AppColors.lightGrey),
                      ),
                      TextButton(
                        child: Text(
                          'Sign up',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register(),
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
