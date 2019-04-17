/*
 * @Author: 21克的爱情
 * @LastEditors: 21克的爱情
 * @Description: 
 * @Date: 2019-04-02 11:06:55
 * @LastEditTime: 2019-04-06 00:44:27
 */
import 'package:flutter/material.dart';
class SettingsPage extends StatelessWidget {

  static const listMenusIdx = [2, 4, 6, 8]; // 需要分组的数组下标
  static const listMenus = [
    const ListMenu(title: '账户与安全', moun: 'invitation', number: '邀请好友得红包', icon: Icons.flip),
    const ListMenu(title: '消息通知', moun: 'invitation', number: '0', icon: Icons.flip),
    const ListMenu(title: '黑名单', moun: 'invitation', number: '0', icon: Icons.flip),
    const ListMenu(title: '地址管理', moun: 'invitation', number: '0', icon: Icons.flip),
    const ListMenu(title: '收款账户', moun: 'invitation', number: '邀请好友得红包', icon: Icons.flip),
    const ListMenu(title: '用户评价', moun: 'invitation', number: '0', icon: Icons.flip),
    const ListMenu(title: '清理缓存', moun: 'invitation', number: '0', icon: Icons.flip),
    const ListMenu(title: '关于我们', moun: 'invitation', number: '0', icon: Icons.flip),
    const ListMenu(title: '检查更新', moun: 'invitation', number: '邀请好友得红包', icon: Icons.flip),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
        centerTitle: false,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: listMenus.length+1,
              physics: new ClampingScrollPhysics(),
              itemBuilder: renderRow
            ),
          ),
        ],
      ),
    );
  }


  // 第五栏布局
  Widget renderRow(BuildContext context, int index) {
    // itemCount: titles.length*2,
    // if (index.isOdd) {//是奇数
    //   return new Divider( //返回分割线
    //     height: 0.0,
    //   );
    // } else {
    //   index = index ~/ 2;
    // }
    // 否则返回菜单item组件
    var listItemContent = index==listMenus.length?buttonView():listNameView(index);

    return new InkWell(
      child: listItemContent,
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text(
                '点击提示',
                textAlign: TextAlign.center,
                style: new TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              ),
              content: new Text('您选择的item内容为:$index'),
            );
          },
        );
      },
    );
  } 

  Widget listNameView(index){
    return Padding(
      padding: EdgeInsets.only(bottom: listMenusIdx.indexOf(index) != -1?20:0),
      child: Container(
        color: Colors.white,
        alignment: Alignment.centerRight,
        child:ListTile(
          title: Row( // 添加横向布局
            children: <Widget>[
              Expanded(
                child: Text(
                  listMenus[index].title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              Text(
                listMenus[index].number,
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              Icon(
                Icons.navigate_next,
                color: Colors.black,
              ),
            ],
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
          selected: false,
        )
      ),
    );
  } 

  Widget buttonView(){
    return MaterialButton(  // 第三栏布局
      onPressed: () {
        print('点击收藏按钮事件');
      },
      height: 60,
      elevation: 0,
      color: const Color(0xffffffff),
      child: (
        Text(
          '退出登录',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700
          ),
        )
      ),
    );
  }
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