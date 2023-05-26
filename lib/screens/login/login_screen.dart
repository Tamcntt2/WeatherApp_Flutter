import 'package:flutter/material.dart';
import 'package:weather_app/screens/login/register_screen.dart';
import 'package:weather_app/values/app_assets.dart';

import '../../values/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Log In',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextField(
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
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.5, color: Colors.redAccent),
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        )),
                  ),
                  Container(
                    height: 15,
                  ),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
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
                        hintStyle: const TextStyle(
                            color: AppColors.lightGrey,
                            fontStyle: FontStyle.italic),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.5, color: Colors.redAccent),
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        suffixIconColor: Colors.white,
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.5, color: Colors.redAccent),
                          borderRadius: BorderRadius.all(
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
                            side: const BorderSide(color: Colors.white),
                            activeColor: Colors.redAccent,
                            checkColor: Colors.white,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            },
                          ),
                          const Text(
                            'Remember me',
                            style: TextStyle(color: AppColors.lightGrey),
                          ),
                        ],
                      ),
                      const Text(
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
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Text(
                        'Log in',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Or Sign in with',
                    style: TextStyle(color: AppColors.lightGrey),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
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
                      const Text(
                        'Don\'t have an accout?',
                        style: TextStyle(color: AppColors.lightGrey),
                      ),
                      TextButton(
                        child: const Text(
                          'Sign up',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
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
