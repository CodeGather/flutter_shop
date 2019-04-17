/*
 * @Author: 21克的爱情
 * @LastEditors: 21克的爱情
 * @Description: 
 * @Date: 2019-04-02 11:13:54
 * @LastEditTime: 2019-04-08 10:31:36
 */
import 'package:flutter/material.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flutter/services.dart';
import 'package:lpinyin/lpinyin.dart';
import 'city_model.dart';
import 'dart:convert';

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CitySelectRouteState();
  }
}

class _CitySelectRouteState extends State<UserPage> {
  List<CityInfo> _cityList = List();
  List<CityInfo> _hotCityList = List();

  int _suspensionHeight = 40;
  int _itemHeight = 50;
  String _suspensionTag = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // 加载本地城市json文件 
  void loadData() async {
    _hotCityList.add(CityInfo(name: "北京市", value: "111", tagIndex: "★"));
    _hotCityList.add(CityInfo(name: "广州市", value: "222", tagIndex: "★"));
    _hotCityList.add(CityInfo(name: "成都市", value: "333", tagIndex: "★"));
    _hotCityList.add(CityInfo(name: "深圳市", value: "444", tagIndex: "★"));
    _hotCityList.add(CityInfo(name: "杭州市", value: "555", tagIndex: "★"));
    _hotCityList.add(CityInfo(name: "武汉市", value: "666", tagIndex: "★"));
 
    //加载城市列表
    rootBundle.loadString('assets/data/china_city.json').then((value) {
      Map countyMap = json.decode(value); 
      List list = countyMap['china'];
      list.forEach((value) {
        _cityList.add(CityInfo(name: value['name'], value: value['value']));
      });
      _handleList(_cityList);
      setState(() {
        _suspensionTag = _hotCityList[0].getSuspensionTag();
      });
    });
  }

  void _handleList(List<CityInfo> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_cityList);
  }

  void _onSusTagChanged(String tag) {
    setState(() {
      _suspensionTag = tag;
    });
  }
 
  Widget _buildSusWidget(String susTag) {
    susTag = (susTag == "★" ? "热门城市" : susTag);
    return Container(
      height: _suspensionHeight.toDouble(),
      padding: const EdgeInsets.only(left: 15.0),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text( 
        '$susTag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xff999999),
        ),
      ),
    );
  }

  Widget _buildListItem(CityInfo model) {
    String susTag = model.getSuspensionTag();
    susTag = (susTag == "★" ? "热门城市" : susTag);
    return Column(
        children:  <Widget>[ 
        Offstage(
          offstage: model.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        SizedBox(
          height: _itemHeight.toDouble(),
          child: ListTile(
            title: Text(model.name),
            onTap: () {
              print("OnItemClick: $model");
              Navigator.pop(context, model);
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 15.0),
          height: 50.0,
          child: Text("当前城市: 成都市"),
        ),
        Expanded(
            flex: 1,
            child: AzListView(
              data: _cityList,
              topData: _hotCityList,
              itemBuilder: (context, model) => _buildListItem(model),
              suspensionWidget: _buildSusWidget(_suspensionTag),
              isUseRealIndex: true,
              itemHeight: _itemHeight,
              suspensionHeight: _suspensionHeight,
              onSusTagChanged: _onSusTagChanged,
              //showCenterTip: false,
            )),
      ],
    ),
    );
  }
}