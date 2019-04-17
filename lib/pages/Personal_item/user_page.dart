/*
 * @Author: 21克的爱情
 * @LastEditors: 21克的爱情
 * @Description: 
 * @Date: 2019-04-02 11:13:54
 * @LastEditTime: 2019-04-09 19:19:22
 */
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPage createState() => new _UserPage();
}

class _UserPage extends State<UserPage> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户中心'),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            child:new CountryCodePicker(
              onChanged: _onCountryChange,
              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
              initialSelection: 'IT',
              showCountryOnly: false, // 是否显示代码
              favorite: ['+39', 'FR']
            ),
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

  void _onCountryChange(CountryCode countryCode) {
    //Todo : manipulate the selected country code here
    print("New Country selected: " + countryCode.toString());
  }

}