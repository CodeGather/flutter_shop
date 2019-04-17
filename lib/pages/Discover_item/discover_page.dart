/*
 * @Author: 21克的爱情
 * @Email: raohong07@163.com
 * @LastEditors: 21克的爱情
 * @Description: 
 * @Date: 2019-04-08 10:38:01
 * @LastEditTime: 2019-04-16 15:24:54
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_shop/iconfont.dart';
import 'package:flutter_shop/pages/Components/search_input.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/pages/Discover_item/Head_tab/new_video_page.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_shop/utils/ThemeUtils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter_shop/pages/Discover_item/Head_tab/new_discover_page.dart';



class DiscoverPage extends StatefulWidget {
  _DiscoverPageState createState() => new _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> with AutomaticKeepAliveClientMixin {

  GlobalKey<EasyRefreshState> _easyRefreshKey =new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  int page = 1;
  List<Map> hotGoodsList=[];
  
  
  @override
  bool get wantKeepAlive =>true;

  Widget buildSearchInput(BuildContext context) {
    return new SearchInput((value) async {
      if (value != '') {
        // List<WidgetPoint> list = await widgetControl.search(value);
        // return list.map((item) => new MaterialSearchResult<String>(
        //           value: item.name,
        //           icon: WidgetName2Icon.icons[item.name] ?? null,
        //           text: 'widget',
        //           onTap: () {
        //             onWidgetTap(item, context);
        //           },
        //         ))
        //     .toList();
        print("搜索开始");
      } else {
        return null;
      }
    }, (value) {}, () {});
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    var formData = {'lon':'115.02932','lat':'35.76189'};
    
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      appBar: new AppBar(
        title: buildSearchInput(context),
        actions: <Widget>[
          PopupMenuButton(
            offset: Offset(ScreenUtil().setSp(20), ScreenUtil().setSp(80)),
            icon: Icon(
              IconFont.camera,
              size: ScreenUtil().setSp(60),
              color: ThemeUtils.defaultColor,
            ),
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      IconFont.video,
                      color: Color(0xFF2DEDA9),
                    ),
                    Text("  视频",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ],
                ), 
                value: "video",
              ),
              PopupMenuItem<String>(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      IconFont.tupian,
                      color: Color(0xFF53CFFF),
                    ),
                    Text("  图片",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ],
                ), 
                value: "image",
              ),
              PopupMenuItem<String>(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      IconFont.huati,
                      color: Color(0xFFF4C152),
                    ),
                    Text(
                      "  话题",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ],
                ), 
                value: "discover",
              ),
            ],
            onSelected: (String action) {
              switch (action) {
                case "video":
                  print("video");
                  Navigator.of(context).push(
                    new MaterialPageRoute(builder: (_) {
                      return new BezierCirclePage();
                    })
                  );
                  break;
                case "image":
                  print("image");
                  break;
                default:
                  print("discover");
                  Navigator.of(context).push(
                    new MaterialPageRoute(builder: (_) {
                      return new NewDiscoverPage();
                    })
                  );
              }
            },
            onCanceled: () {
              print("onCanceled");
            },
          )
        ],
      ),
      body:FutureBuilder(
        future:request('homePageContext',formData:formData),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var data=json.decode(snapshot.data.toString());
            List<Map> swiperDataList = (data['data']['slides'] as List).cast(); // 顶部轮播组件数
            List<Map> navigatorList =(data['data']['category'] as List).cast();
            print(data['data']['category']);
            return EasyRefresh(
              refreshFooter: ClassicsFooter(
                key:_footerKey,
                bgColor:Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: true,
                noMoreText: '',
                moreInfo: '加载中',
                loadReadyText:'上拉加载....'

              ),
              child: ListView(
                children: <Widget>[
                  SwiperDiy(swiperDataList:swiperDataList ),   //页面顶部轮播组件
                  TopNavigator(navigatorList:navigatorList),
                  _hotGoods(),
                ],
              ) ,
              loadMore: ()async{
                 print('开始加载更多');
                  var formPage={'page': page};
                  await  request('homePageBelowConten',formData:formPage).then((val){
                    print(val);
                    var data=json.decode(val.toString());
                    List<Map> newGoodsList = (data['data'] as List ).cast();
                    setState(() {
                      hotGoodsList.addAll(newGoodsList);
                      page++; 
                    });
                  });
                },
            );
          }else{
            return Center(
              child: Text('加载中'),
              
            );
          }
        },
      )
    );
  }



  //火爆商品接口
  void _getHotGoods(){
     var formPage={'page': page};
     request('homePageBelowConten',formData:formPage).then((val){
       
       var data=json.decode(val.toString());
       List<Map> newGoodsList = (data['data'] as List ).cast();
       setState(() {
         hotGoodsList.addAll(newGoodsList);
         page++; 
       });
     });
  }

  //火爆专区子项
  Widget _wrapList(){
    if(hotGoodsList.length!=0){
      List<Widget> listWidget = hotGoodsList.map((val){
        return InkWell(
          onTap:(){print('点击了火爆商品');},
          child: Container(
            width: ScreenUtil().setWidth(246),
            height: ScreenUtil().setHeight(246),
            color:Colors.white,
            padding: EdgeInsets.all(5.0),
            margin:EdgeInsets.only(top:3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  val['image'],
                  fit: BoxFit.cover,
                ),
              ],
            ), 
          )
        );
      }).toList();
      return Wrap(
        spacing: 3,
        children: listWidget,
      );
    }else{
      return Text(' ');
    }
  }

  //火爆专区组合
  Widget _hotGoods(){
    return Container(
      child:Column(
        children: <Widget>[
          _wrapList(),
        ],
      )   
    );
  }
}
 
// 首页轮播模块组件编写
class SwiperDiy extends StatelessWidget{
  final List swiperDataList;
  SwiperDiy({Key key,this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.white,
      height: ScreenUtil().setHeight(240),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return InkWell(
            onTap: (){print('点击了第${index}图片');},
            child:  Image.network("${swiperDataList[index]['image']}",fit:BoxFit.fill),
          );
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//导航组件
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context,item){
    return InkWell(
      onTap: (){print('点击了导航');},
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width:ScreenUtil().setWidth(90)
          ),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    if(navigatorList.length>10){
      navigatorList.removeRange(10, navigatorList.length);
    }
    return Container(
      color:Colors.white,
      padding:EdgeInsets.all(3.0),
      height: ScreenUtil().setHeight(164),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(), // 是否禁止导航中滑动
        crossAxisCount: 3,
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setSp(20)),
        children: navigatorList.map((item){
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}
