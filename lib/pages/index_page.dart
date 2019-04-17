import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Goods_item/home_page.dart';
import 'Discover_item/discover_page.dart';
import 'Shopping_item/cart_page.dart';
import 'Personal_item/personal_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/lang/index.dart' show AppLocalizations;


class IndexPage extends StatefulWidget {
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>{

   PageController _pageController;


  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon:Icon(CupertinoIcons.home),
      title:Text(AppLocalizations.$t('bottom_nav.item_1'))
    ),
    BottomNavigationBarItem(
      icon:Icon(CupertinoIcons.search),
      title:Text(AppLocalizations.$t('bottom_nav.item_2'))
    ),
    BottomNavigationBarItem(
      icon:Icon(CupertinoIcons.shopping_cart),
      title:Text(AppLocalizations.$t('bottom_nav.item_3'))
    ),
     BottomNavigationBarItem(
      icon:Icon(CupertinoIcons.profile_circled),
      title:Text(AppLocalizations.$t('bottom_nav.item_4'))
    ),
  ];
  final List<Widget> tabBodies = [
    HomePage(),
    DiscoverPage(),
    CartPage(),
    MemberPage()
  ];
  int currentIndex= 0;
  var currentPage ;
  @override
  void initState() {
   currentPage=tabBodies[currentIndex];
   _pageController=new PageController()
      ..addListener(() {
        if (currentPage != _pageController.page.round()) {
          setState(() {
            currentPage = _pageController.page.round();
          });
        }
  });


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items:bottomTabs,
        onTap: (index){
          setState(() {
            currentIndex=index;
            currentPage =tabBodies[currentIndex]; 
          });
           
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies
      )
    );
  }
}

