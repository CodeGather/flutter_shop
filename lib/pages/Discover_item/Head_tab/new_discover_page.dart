/*
 * @Author: 21克的爱情
 * @Email: raohong07@163.com
 * @LastEditors: 21克的爱情
 * @Description: 
 * @Date: 2019-04-16 10:15:06
 * @LastEditTime: 2019-04-16 15:18:15
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewDiscoverPage extends StatefulWidget {
  _NewDiscoverPageState createState() => new _NewDiscoverPageState();
}

class _NewDiscoverPageState extends State<NewDiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        titleSpacing: 0,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: (){
                // 返回
                Navigator.pop(context);
              },
              child: Align(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('取消'),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                print('object');
              },
              child: Align(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('发布'),
                )
              ),
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(40)),
        child: Column(
          children: <Widget>[
            TextField(
              maxLines: 10,
              inputFormatters: [LengthLimitingTextInputFormatter(11)],   
              decoration: new InputDecoration(
                hintText: '这一刻的想法',
                border: InputBorder.none,
              ),     
            ),
            new GridView.builder(
                physics: NeverScrollableScrollPhysics(), // 是否禁止导航中滑动
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing:5.0,
                  mainAxisSpacing: 5.0,
                  crossAxisCount: 3,
                ),
                shrinkWrap: true,
                itemBuilder:  (BuildContext context, int index) {
                  return new Image.network(
                    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=15335368'
                        '41326&di=682e2e7c3810ac92be325e62e173c0ea&imgtype=0&src=http%3A%2F%2Fs6.si'
                        'naimg.cn%2Fmw690%2F006LDoUHzy7auXEaYER25%26690',
                    fit: BoxFit.cover,
                  );
                },
              itemCount: 9,
            ),
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
   );
  }
}