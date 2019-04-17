/*
 * @Author: 21克的爱情
 * @LastEditors: 21克的爱情
 * @Description: 
 * @Date: 2019-03-29 11:09:43
 * @LastEditTime: 2019-04-16 16:14:32
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart'; // 引入时间插件
import 'package:flutter_shop/iconfont.dart';
import 'package:flutter_shop/pages/Personal_item/about_page.dart';
import 'package:flutter_shop/pages/login_code_page.dart';
import './settings_page.dart';
import './user_page.dart';
import './wallet_page.dart';
import 'package:flutter_shop/lang/index.dart' show AppLocalizations;
// 二维码
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:flutter_shop/pages/richText_page.dart';

class MemberPage extends StatefulWidget {
  @override
  _BasicAppBarSampleState createState() => new _BasicAppBarSampleState();
}

class _BasicAppBarSampleState extends State<MemberPage> {
  static const double ARROW_ICON_WIDTH = 16.0;

  // 二维码
  String barcode = "";

  static const List<Choice> choices = const <Choice>[
    const Choice(title: '扫描', icon: Icons.flip),
    const Choice(title: '设置', icon: Icons.settings), // 设置
  ];

  static const navigatorList = [
    {
      "title": "微信",
      "color": 0xFF05C964,
      "key": "wechat",
      "icon": IconFont.wechat,
    },
    {
      "title": "微博",
      "color": 0xFFE6162D,
      "key": "sina",
      "icon": IconFont.sina,
    },
    {
      "title": "支付宝",
      "color": 0xFF00A0E8,
      "key": "allipay",
      "icon": IconFont.allipay,
    },
    {
      "title": "其它方式",
      "color": 0xFF8A8A8A,
      "key": "other",
      "icon": IconFont.login_out,
    }
  ];

  static const listMenus = [
    const ListMenu(title: '地址管理', moun: 'invitation', number: '邀请好友得红包', icon: Icons.flip),
    const ListMenu(title: '帮助反馈', moun: 'invitation', number: '0', icon: Icons.flip),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return new Scaffold(
        appBar: new AppBar(
          title: Container(  // 导航左侧图标点击事件
            child: Row(
              children: <Widget>[
                new IconButton( 
                  icon: new Icon(choices[0].icon),
                  onPressed: () { 
                    print('扫描点击事件');
                    scan();
                  },
                )
              ],
            ),
          ),
          backgroundColor: Colors.white, // 导航背景颜色
          iconTheme:IconThemeData(color: Colors.blue), // 导航图标颜色
          elevation: 0,      // 导航底部阴影大小
          actions: <Widget>[ // 导航右侧位置布局
            new IconButton( 
              icon: new Icon(choices[0].icon),
              onPressed: () { 
                print('点击扫码按钮事件');
                Navigator.of(context).push(
                  new MaterialPageRoute(builder: (_) {
                    return new LoginCodePage();
                  })
                );
              },
            ),
            new IconButton( 
              icon: new Icon(choices[1].icon),
              onPressed: () {
                print('右侧第二个的图标点击事件');
                Navigator.of(context).push(
                  new MaterialPageRoute(builder: (_) {
                    return new SettingsPage();
                  })
                );
              },
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            buildPersonalFlatButton(), // 第一栏
            SizedBox( height: ScreenUtil().setHeight(20) ),
            buildShoppingRow(),
            SizedBox( height: ScreenUtil().setHeight(20) ),
            buildCollectionFlatButton(),
            SizedBox( height: ScreenUtil().setHeight(20) ),
            renderRow(),
          ],
        ),
        // body: FlatButton( // 时间选择插件
        //   onPressed: () {
        //     DatePicker.showDatePicker(context,
        //       showTitleActions: true,
        //       minTime: DateTime(2018, 3, 5),
        //       maxTime: DateTime(2019, 6, 7), 
        //     onChanged: (date) {
        //       print('change $date');
        //     }, onConfirm: (date) {
        //       print('confirm $date');
        //     }, currentTime: DateTime.now(), locale: LocaleType.zh);
        //   },
        //   child: Text(
        //     'show date time picker (Chinese)',
        //     style: TextStyle(color: Colors.blue),
        //   )
        // )
    );
  }

  // 第一栏个人信息布局
  FlatButton buildPersonalFlatButton(){
    return FlatButton(  // 第一列布局
      onPressed: () {
        print('点击个人信息按钮事件');
        // Navigator.of(context).push(
        //   new MaterialPageRoute(builder: (_) {
        //     return new UserPage();
        //   })
        // );
        _showMyModelBottomSheet();
      },
      splashColor: const Color(0xffffffff),
      highlightColor: const Color(0xffffffff),
      color: const Color(0xffffffff),
      padding: const EdgeInsets.fromLTRB(20, 20, 10, 30),
      child: Row( // 第一栏
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(35.0),
            child: FadeInImage.assetNetwork(
              placeholder: "assets/images/normal_user_icon.png", //预览图
              fit: BoxFit.cover,
              image: "https://img.alicdn.com/tfs/TB148sWfMHqK1RjSZFgXXa7JXXa-536-482.png",
              width: 70.0,
              height: 70.0,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    AppLocalizations.$t('user_title'),
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(36)
                    ),
                  ),
                  Text(
                    AppLocalizations.$t('user_title_subheading'),
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(28)
                    ),
                  ),
                ],
              )
            )
          ),   
          // Text(
          //   '个人中心',
          // ),
          Icon(Icons.navigate_next),
        ],
      ),
    );
  }

  // 第二栏横向购买出售布局
  Row buildShoppingRow(){
    return Row(         
      children: <Widget>[
        Expanded( // 第二栏左侧
          child: RaisedButton(
            onPressed: () {
              print('点击购买按钮事件');
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (_){
                    return new FullPageEditorScreen();
                  }
                )
              );
            },
            color: const Color(0xffffffff),
            elevation: 0,
            padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child:Icon(Icons.shopping_basket),
                      ),
                      Text(
                        '购买',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(36),
                          fontWeight: FontWeight.w900
                        ),
                      )
                    ]
                  )
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(36),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child:Icon(Icons.navigate_next),
                    ),
                  ]
                )
              ]
            )
          )
        ),
        Expanded( // 第二栏右侧
          child: RaisedButton(
            onPressed: () {
              print('点击出售按钮事件');
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (_){
                    return new Page();
                  }
                )
              );
            },
            color: const Color(0xffffffff),
            elevation: 0,
            padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child:Icon(Icons.date_range),
                      ),
                      Text(
                        '出售',
                        style: TextStyle(
                          fontSize:  ScreenUtil().setSp(36),
                          fontWeight: FontWeight.w900
                        ),
                      )
                    ]
                  )
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(36),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child:Icon(Icons.navigate_next),
                    ),
                  ]
                )
              ]
            )
          )
        ),
      ],
    );
  }

  // 第三栏收藏布局
  FlatButton buildCollectionFlatButton(){
    return FlatButton( 
      onPressed: () {
        print('点击收藏按钮事件');
      },
      color: const Color(0xffffffff),
      padding: const EdgeInsets.fromLTRB(20, 15, 10, 15),
      child: Row( // 第三栏
        children: <Widget>[
          Icon(Icons.account_balance_wallet),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                '钱包',
                style: TextStyle(
                  fontSize:  ScreenUtil().setSp(36),
                  fontWeight: FontWeight.w900,
                ),
              ),
            )
          ),   
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('0.0'),
              Text('余额')
            ],
          ),
          Icon(Icons.navigate_next),
        ],
      ),
    );
  }
  
  // 第四栏
  Padding PaddingBuild(){
    return Padding(     // 第四栏布局
      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: FlatButton( 
        onPressed: () {
          print('点击钱包按钮事件');
          Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (_){
                return new WalletPage();
              }
            )
          );
        },
        color: const Color(0xffffffff),
        splashColor: const Color(0xffffffff),
        highlightColor: const Color(0xffffffff),
        padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(150),
              child: Row(
                children: <Widget>[
                  Icon(Icons.account_balance_wallet),
                  Text(
                    ' 钱包',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: ScreenUtil().setSp(36)
                    ),
                  )
                ],
              ),
            ),
            Expanded(  // 余额
              child: Container(
                height: ScreenUtil().setSp(160),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('99.0'),
                    Text(
                      '余额',
                      style: TextStyle(
                        // fontSize: ScreenUtil().setSp(18)
                      ),
                    )
                  ],
                )
              )
            ),
            Expanded(  // 优惠券
              child: Container(
                height: ScreenUtil().setSp(160),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('0.0'),
                    Text('优惠券')
                  ],
                )
              )
            ),
            Expanded(  // 毒币
              child: Container(
                height: ScreenUtil().setSp(160),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('0.0'),
                    Text('毒币')
                  ],
                )
              )
            ),
            Expanded(  // 红包
              child: Container(
                height: ScreenUtil().setSp(160),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('0.0'),
                    Text('红包')
                  ],
                )
              )
            ),
            Container( // 右箭头
              height: ScreenUtil().setSp(160),
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 0),
                child: Icon(Icons.navigate_next),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 第五栏布局
  Widget renderRow() {
    // itemCount: titles.length*2,
    // if (index.isOdd) {//是奇数
    //   return new Divider( //返回分割线
    //     height: 0.0,
    //   );
    // } else {
    //   index = index ~/ 2;
    // }
    // 否则返回菜单item组件
    List<Widget> tiles = [];
    Widget content;
    for(var i=0; i< listMenus.length; i++) {
      tiles.add(
        FlatButton(  // 第三栏布局
          onPressed: () {
            print('$i');
          },
          color: const Color(0xffffffff),
          padding: const EdgeInsets.fromLTRB(20, 15, 10, 15),
          child: Row( // 第三栏
            children: <Widget>[
              Expanded(
                child: Text(
                  listMenus[i].title,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(36),
                    fontWeight: FontWeight.w900,
                  ),
                )
              ), 
              Icon(Icons.navigate_next),
            ],
          ),
        )
      );
    }
    content = new Column(
      children: tiles //重点在这里，因为用编辑器写Column生成的children后面会跟一个<Widget>[]，
      //此时如果我们直接把生成的tiles放在<Widget>[]中是会报一个类型不匹配的错误，把<Widget>[]删了就可以了
    );
    return content;
  } 

  // 授权登录弹出底部菜单
  void _showMyModelBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // 此处可以自定义任何内容
        return new Container(
          height: ScreenUtil().setHeight(364),
          child: Column(
            children: <Widget>[
              Container( // 弹出框标题
                height: ScreenUtil().setHeight(80),
                child: Center(
                  child:Text(
                    AppLocalizations.$t('login.title'),
                  )
                )
              ),
              Container(
                height: ScreenUtil().setHeight(180),
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(), // 是否禁止导航中滑动
                  crossAxisCount: 4,
                  children: navigatorList.map((item){
                    return InkWell(
                      onTap: (){
                        _bottomSheetFn(item);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            item['icon'],
                            size: ScreenUtil().setSp(80),
                            color: Color(item['color']),
                          ),
                          SizedBox(  // 弹出框线条
                            child:  Container(
                              height: ScreenUtil().setHeight(20),
                            ),
                          ),
                          Text(item['title'])
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(  // 弹出框线条
                child:  Container(
                  width: ScreenUtil().setWidth(740),
                  height: ScreenUtil().setHeight(4),
                  color: Colors.black12,
                ),
              ),
              Container(  // 取消按钮
                height: ScreenUtil().setHeight(100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: new Text( AppLocalizations.$t('cancel') ),
                      ),
                    )
                  ],
                )
              )
            ],
          ),
        );
      }
    ).then((val) {
      print(val);
    });
  }

  // 第三方登录
  void _bottomSheetFn(type){
    switch (type['key']) {
      case 'other':
        Navigator.pop(context);
        Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (_){
              return new LoginCodePage();
            }
          )
        );
        break;
      default:
        print(type);
    }
  }

  // 相机扫码
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = AppLocalizations.$t('permission.camera');
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = AppLocalizations.$t('scanning_back'));
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

}

class Choice {
  const Choice({ this.title, this.icon });
  final String title;
  final IconData icon;
}

class ListMenu {
  final String title;
  final IconData icon;
  final String moun;
  final String number;
  const ListMenu({ 
    this.title, 
    this.icon,
    this.moun,
    this.number
  });
}
