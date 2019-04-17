/*
 * @Author: 21克的爱情
 * @LastEditors: 21克的爱情
 * @Description: 
 * @Date: 2019-03-29 16:37:59
 * @LastEditTime: 2019-04-03 16:38:01
 */
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('欢迎注册'),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            child:
                Text('Deliver features faster', textAlign: TextAlign.center),
          ),
          Expanded(
            child: Text('Craft beautiful UIs', textAlign: TextAlign.center),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.contain, // otherwise the logo will be tiny
              child: const FlutterLogo(),
            ),
          ),
        ],
      )
    );
  }
}