import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; //语言包实例化

import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/provide/category_goods_list.dart';
import 'package:flutter_shop/provide/counter.dart';

import 'package:flutter_shop/pages/splash_screen.dart';

import 'package:flutter_shop/lang/index.dart' show AppLocalizationsDelegate, AppLocalizations;
import 'package:flutter_shop/lang/config.dart' show ConfigLanguage;
import 'package:flutter_shop/store/index.dart' show model, Store; //引用Store 层

void main(){
  var childCategory= ChildCategory();
  var categoryGoodsListProvide= CategoryGoodsListProvide();

  var counter =Counter();
  var providers  =Providers();
  providers
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<Counter>.value(counter));


  runApp(ProviderNode(child:MyApp(),providers:providers));
}
class MyApp extends StatefulWidget {
  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MyApp> {
  // 定义全局 语言代理
  AppLocalizationsDelegate _delegate;

  @override
  void initState() {
    //实例化多语言
    super.initState();
    _delegate = AppLocalizationsDelegate();
    model.dispatch('config', 'getTheme');
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      
      child: MaterialApp(
        title:'百姓生活+',
        debugShowCheckedModeBanner: false,
        // 根据读取的语言信息进行判断
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          print( 'deviceLocale=$deviceLocale supportedLocales=$supportedLocales');
          Locale _locale = supportedLocales.contains(deviceLocale)
              ? deviceLocale
              : Locale('zh');
          print(deviceLocale);
          return _locale;
        },
        onGenerateTitle: (context) {
          // 设置多语言代理
          AppLocalizations.setProxy(setState, _delegate);
          return 'flutter';
        },
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          _delegate,
        ],
        supportedLocales: ConfigLanguage.supportedLocales,
        theme: ThemeData(
          primaryColor:Colors.pink,
          platform: TargetPlatform.iOS, // 该属性可使页面右划返回
        ),
        home:SplashScreen()
      ),
    );
  }
}
