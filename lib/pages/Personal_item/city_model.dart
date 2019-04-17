import 'package:azlistview/azlistview.dart';

class CityInfo extends ISuspensionBean {
  String name;
  String value;
  String tagIndex;
  String namePinyin;

  CityInfo({
    this.name,
    this.value,
    this.tagIndex,
    this.namePinyin,
  });

  CityInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'] == null ? "" : json['name'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'value': value,
    'tagIndex': tagIndex,
    'namePinyin': namePinyin,
    'isShowSuspension': isShowSuspension
  };

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() => "CityBean {" + " \"name\":\"" + name + "\"" + " \"value\":\"" + value + "\"" + "}";
}
