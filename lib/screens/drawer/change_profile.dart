import 'package:flutter/material.dart';
import 'package:weather_app/models/account.dart';
import 'package:weather_app/values/app_colors.dart';

import '../../values/app_styles.dart';

class ChangeProfile extends StatelessWidget {
  MyAccount account = MyAccount(
      photoUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkg-307JO6AHvZVx8999lW46CWnwCPcBqgMA&usqp=CAU',
      email: 'hongtamtc1612@gmail.com',
      firstName: 'Nguyen',
      lastName: 'Hong Tam',
      uid: '111');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff484B5B), Color(0xff2C2D35)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                  Text(
                    'Profile',
                    style: AppStyles.h2.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Done',
                        style: TextStyle(color: Colors.lightBlueAccent),
                      ))
                ],
              ),
              account.photoUrl!.isEmpty
                  ? Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white10),
                      child: Center(
                          child: Text(
                        _getTextImage(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightGrey,
                            fontSize: 30),
                      )))
                  : Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(account.photoUrl!),
                        ),
                      ),
                    ),
              Text(
                'Change profile picture',
                style: TextStyle(color: AppColors.lightGrey),
              ),
              Container(
                decoration: BoxDecoration(),
                child: Column(children: [
                  Text('First name'),
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    ));
  }

  String _getTextImage() {
    return account.firstName![0] + account.lastName![0];
  }
}
