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
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
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
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.5, color: Colors.redAccent),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              )),
                        ),
                      ),
                      Container(
                        width: 15,
                      ),
                      const Expanded(
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
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.5, color: Colors.redAccent),
                                borderRadius: BorderRadius.all(
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
                  Container(height: 15),
                  TextField(
                    style: const TextStyle(color: Colors.white),
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
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an accout?',
                        style: TextStyle(color: AppColors.lightGrey),
                      ),
                      TextButton(
                        child: const Text(
                          'Sign in',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
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
