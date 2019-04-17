/*
 * @Author: 21克的爱情
 * @Email: raohong07@163.com
 * @LastEditors: 21克的爱情
 * @Description: 
 * @Date: 2019-03-29 16:37:35
 * @LastEditTime: 2019-04-13 12:59:09
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/iconfont.dart';
import 'register_page.dart';
import 'package:flutter_shop/lang/index.dart' show AppLocalizations;
import 'package:flutter_shop/utils/ThemeUtils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:common_utils/common_utils.dart';

// 其中 xxx，为 iconfont 对应的名字，可以 Chrome 打开
// demo_fontclass.html 查看对应名称


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>with SingleTickerProviderStateMixin {
  final _formKey0 = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  // 定义当前选择下标
  int _currentIndex = 0;
  // 定义参数
  String _mobile, _code, _password, _countryCode;
  // 协议是否勾选
  bool isChecked = true;
  bool _isObscure = true;
  Color _eyeColor;
  List _loginMethod = [
    {
      "title": "微信",
      "color": 0xFF05C964,
      "icon": IconFont.wechat,
    },
    {
      "title": "QQ",
      "color": 0xFFE6162D,
      "icon": IconFont.sina,
    },
    {
      "title": "allipay",
      "color": 0xFF00A0E8,
      "icon": IconFont.allipay,
    }
  ];

  List myTabs = [
    {
      "title": AppLocalizations.$t('login.tab.tab_phone'),
    },
    {
      "title": AppLocalizations.$t('login.tab.tab_account'),
    }
  ];
  
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {//TabBar的监听
      if (!_tabController.indexIsChanging) {//判断TabBar是否切换
        setState(() {
          _currentIndex = _tabController.index;
        });
        print(_currentIndex);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // 登录页面布局
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: ThemeUtils.defaultColor,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: myTabs.map((item) => Builder(
            builder: (context) {
              return Tab(
                child: Text(
                  item['title'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: ThemeUtils.defaultColor
                  ),
                ),
              );
            },
          )).toList(),
        ),
      ),
      bottomNavigationBar: Container(   // 第三方
        height: ScreenUtil().setHeight(250),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              Text(
                AppLocalizations.$t('login.third_party'),
                style: TextStyle(
                  color: ThemeUtils.defaultColor, 
                  fontSize: ScreenUtil().setSp(30)
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              buildOtherMethod(context),
            ],
          ),
        )
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Form(
            key: _formKey0,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setSp(100)),
              children: <Widget>[
                SizedBox(
                  height: kToolbarHeight,
                ),
                SizedBox(height: ScreenUtil().setHeight(70)),
                buildEmailTextField(),
                SizedBox(height: ScreenUtil().setHeight(30)),
                // 验证码
                buildVerificationCodeTextFields(),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setSp(20)),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        print('收不到验证码？');
                      },
                      child: Text(
                        AppLocalizations.$t('login.code'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(62)),
                buildLoginButton(context),
                buildRegisterText(context),
              ],
            )
          ),
          Form(
            key: _formKey1,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setSp(100)),
              children: <Widget>[
                SizedBox(
                  height: kToolbarHeight,
                ),
                SizedBox(height: ScreenUtil().setHeight(70)),
                buildEmailTextField(),
                SizedBox(height: ScreenUtil().setHeight(30)),
                buildPasswordTextField(context),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setSp(20)),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        print('忘记密码');
                      },
                      child: Text(
                        AppLocalizations.$t('login.forget'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(62)), // 上下间距
                buildLoginButton(context),  // 按钮
                buildRegisterText(context), // 协议
              ],
            )
          )
        ]
      ),
    );
  }

  // 按钮下方协议内容
  Align buildRegisterText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            onPressed: (){
              setState(() {
                isChecked = !isChecked;
              });
            },
            splashColor: Colors.transparent,
            icon: isChecked ? 
              Icon(
                Icons.radio_button_checked,
                size: 28.0,
                color: ThemeUtils.defaultColor,
              ) : 
              Icon(
                Icons.radio_button_unchecked,
                size: 28.0,
                color: ThemeUtils.defaultColor,
              ),
          ),
          GestureDetector(
            child: Text(              
              AppLocalizations.$t('login.protocol'),
              style: TextStyle(
                color: ThemeUtils.defaultColor
              ),
            ),
            onTap: () {
              //TODO 跳转到注册页面
              print('去注册');
              Navigator.of(context).push(
                new MaterialPageRoute(builder: (_) {
                  return new RegisterPage();
                })
              );
            },
          ),
        ],
      ),
    );
  }

  // 第三方登录
  Widget buildOtherMethod(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _loginMethod.map((item) => Builder(
        builder: (context) {
          return IconButton(
            padding: EdgeInsets.all(20),
            iconSize: ScreenUtil().setSp(85),
            icon: Icon(
              item['icon'],
              color: Color(item['color'])
            ),
            onPressed: () {
              Fluttertoast.showToast(
                msg: "${item['title']}登录",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                fontSize: 14.0
              );
            }
          );
        },
      )).toList(),
    );
  }

  // 验证码输入框的验证
  TextFormField buildVerificationCodeTextFields() {
    return TextFormField(
      obscureText: false,
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入验证码';
        }
      },
      decoration: InputDecoration(
        hintText: AppLocalizations.$t('login.code_input'),
        prefixIcon: Container(
          width: ScreenUtil().setWidth(110),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.$t('login.code_tip')
            ),
          ),
        ),
        suffixIcon: FlatButton(
          child: Text(
            AppLocalizations.$t('login.get_code')
          ),
          onPressed: () {
            print('获取验证码');
          }
        )
      ),
      onSaved: (String value) => _code = value
    );
  }
  
  // 密码输入框
  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      obscureText: _isObscure,
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入密码';
        }
      },
      decoration: InputDecoration(
        hintText: AppLocalizations.$t('login.password_input'),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.remove_red_eye,
            color: _eyeColor,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
              _eyeColor = _isObscure
                  ? Colors.grey
                  : Theme.of(context).iconTheme.color;
            });
          }
        )
      ),
      onSaved: (String value) => _password = value
    );
  }

  // 手机号码输入框的验证
  TextFormField buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: AppLocalizations.$t('login.phone_input'),
        hasFloatingPlaceholder: true,
        suffixIcon: false ? new Container(
            width: 20.0,
            height: 20.0,
            child: new IconButton(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(0.0),
              iconSize: 18.0,
              icon: Icon(IconFont.cancel),
              onPressed: () {
                setState(() {
                  _mobile = " ";
                  print('qingchu');
                });
              },
            ),
          )
        : new Text(""),
        prefixIcon: Container(
          width: ScreenUtil().setWidth(110),
          child: new CountryCodePicker(
            onChanged: (CountryCode countryCode){
              _countryCode = countryCode.toString();
            },
            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
            initialSelection: 'CN',
            alignments: Alignment.centerLeft,
            showCountryOnly: false, // 是否显示代码
            favorite: ['+86', 'CN']
          ),
        ),
      ),
      validator: (String value) {
        if (!RegexUtil.isMobileExact(value)) {
          Fluttertoast.showToast(
            msg: AppLocalizations.$t('login.code_error_tip'),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 2,
            fontSize: 14.0
          );
        }
      },
      onSaved: (String value)=>_mobile = value
    );
  }

  // 登录按钮
  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: ScreenUtil().setHeight(60),
        width: ScreenUtil().setWidth(530),
        child: FlatButton(
          child: Text(
            AppLocalizations.$t('login.login_button'), 
            style: TextStyle(
              fontSize: ScreenUtil().setSp(36),
              color: Colors.white
            ),
          ),
          color: ThemeUtils.defaultColor,
          onPressed: () {
            if(!isChecked){
              Fluttertoast.showToast(
                msg: "请勾选用户协议",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 2,
                fontSize: 14.0
              );
            }
            var _formKey = _formKey0;
            if (_currentIndex==1) {
              _formKey = _formKey1;
            }
            if (_formKey.currentState.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              _formKey.currentState.save();
              //TODO 执行登录方法
              print('email:$_mobile , password:$_password, code:$_code , 国家代码:$_countryCode , 是否勾选：$isChecked');
            }
          },
          shape: StadiumBorder(
            side: BorderSide(
              color: ThemeUtils.defaultColor,
              width: 1.0,
              style: BorderStyle.solid,
            )
          ),
        ),
      ),
    );
  }



  // 标题中的下划线
  // Padding buildTitleLine() {
  //   return Padding(
  //     padding: EdgeInsets.only(left: 10.0, top: 4.0),
  //     child: Align(
  //       alignment: Alignment.bottomLeft,
  //       child: Container(
  //         color: Colors.black,
  //         width: ScreenUtil().setWidth(70),
  //         height: 2.0,
  //       ),
  //     ),
  //   );
  // }

  // 标题
  // Padding buildTitle() {
  //   return Padding(
  //     padding: EdgeInsets.all(8.0),
  //     child: Text(
  //       '积噩',
  //       style: TextStyle(fontSize: ScreenUtil().setHeight(80)),
  //     ),
  //   );
  // }
}
