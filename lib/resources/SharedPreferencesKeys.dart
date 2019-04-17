/*
 * @Author: 21克的爱情
 * @LastEditors: 21克的爱情
 * @Description: 
 * @Date: 2019-04-02 17:07:28
 * @LastEditTime: 2019-04-08 17:09:06
 */

// 用户信息
class UserInfo {
  num id;
  String name;
  String gender;
  String avatar;
  String email;
  String location;
  String url;

  UserInfo({
    this.id, 
    this.name, 
    this.gender, 
    this.avatar, 
    this.email, 
    this.location, 
    this.url
  });
}


//enum DateType {
//  Int,
//  Double,
//  Bool,
//  String,
//  Dynamic
//}

//class spKey {
//  String name;
//  DateType type;
//
//  spKey({this.name, this.type});
//}

class SharedPreferencesKeys {
  /// boolean
  /// 用于欢迎页面. 只有第一次访问才会显示. 或者手动将这个值设为false
  static String showWelcome = 'loginWelcone';
  // json 
  // 用于存放搜索页的搜索数据.
  // [{
  //  name: 'name'
  // }]
  static String searchHistory = 'searchHistory';
}

