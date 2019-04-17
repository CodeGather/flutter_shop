import 'dart:convert';
import 'package:flutter_shop/config/index.dart' as Config;
import 'package:flutter_shop/store/index.dart' show model;
import 'package:flutter_shop/utils/loadAsset.dart' show loadAssets;
import 'package:flutter_shop/utils/localstage.dart' show LocalStorage;
import 'package:package_info/package_info.dart' show PackageInfo;

class ConfigInfo {
  bool isPro = Config.isPro;
  String version = '1.0';
  dynamic env = Config.env;
  String theme = 'red';
  String appVersion = '-';
}

ConfigInfo _appConfigInfo = new ConfigInfo();

class ConfigModel {
  get state => _appConfigInfo;

  Future getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appConfigInfo.appVersion = await packageInfo.version;
  }

  Future getTheme() async {
    String theme = await LocalStorage.get('theme');
    if (theme != null) {
      _appConfigInfo.theme = theme;
    }
  }

  dynamic getVersion() async {
    print('version ${model.config.state.env.versionUrl}');
    String _version =
        await loadAssets(model.config.state.env.versionUrl).then((resp) {
      Map<String, dynamic> res = json.decode(resp);
      return res['version'].toString() ?? '0.1';
    }).catchError((err) {
      print('err $err');
      return '0.0';
    });
    print('_version ${_version}');
    return _version;
  }

  methods(name, payload) async {
    print('payload= $payload');

    switch (name) {
      case 'setEnv':
        _appConfigInfo.isPro = payload;
        break;
      case 'setVersion':
        _appConfigInfo.version = await this.getVersion();
        break;
      case 'setTheme':
        _appConfigInfo.theme = payload;
        LocalStorage.set('theme', payload);
        break;
      case 'getTheme':
        await this.getTheme();
        break;
    }
  }
}
