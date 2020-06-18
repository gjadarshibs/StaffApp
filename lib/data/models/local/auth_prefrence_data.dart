import 'package:flutter/material.dart';
import 'package:ifly_corporate_app/data/models/remote/corporate_list_model.dart';
import 'package:ifly_corporate_app/data/models/remote/user_model.dart';

/// This is a model class used to save
/// basic auth information which is obtained just after
/// company identification service.

class CorporatePreference {
  String airlineCode;
  String airlineName;
  String airlineLogo;
  String companyCode;
  String companyName;
  String companyLogo;
  String webServiceUrl;
  String desktopUrl;
  String authCount;
  String authMode;

  CorporatePreference(
      {this.airlineCode,
      this.airlineName,
      this.airlineLogo,
      this.companyCode,
      this.companyName,
      this.companyLogo,
      this.webServiceUrl,
      this.desktopUrl,
      this.authCount,
      this.authMode});

  CorporatePreference.fromModel({@required CorporateModel model}) {
    airlineCode = model.airlineCode;
    airlineName = model.airlineName;
    airlineLogo = model.airlineLogo;
    companyCode = model.companyCode;
    companyName = model.companyName;
    companyLogo = model.companyLogo;
    webServiceUrl = model.webServiceUrl;
    desktopUrl = model.desktopUrl;
    authCount = model.authCount;
    authMode = model.authMode;
  }

  CorporatePreference.fromJson(Map<String, dynamic> json) {
    airlineCode = json['airlineCode'];
    airlineName = json['airlineName'];
    airlineLogo = json['airlineLogo'];
    companyCode = json['companyCode'];
    companyName = json['companyName'];
    companyLogo = json['companyLogo'];
    webServiceUrl = json['webServiceUrl'];
    desktopUrl = json['desktopUrl'];
    authCount = json['authCount'];
    authMode = json['authMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['airlineCode'] = airlineCode;
    data['airlineName'] = airlineName;
    data['airlineLogo'] = airlineLogo;
    data['companyCode'] = companyCode;
    data['companyName'] = companyName;
    data['companyLogo'] = companyLogo;
    data['webServiceUrl'] = webServiceUrl;
    data['desktopUrl'] = desktopUrl;
    data['authCount'] = authCount;
    data['authMode'] = authMode;
    return data;
  }
}

class UserPreference {
  String token;
  UserInfoModel info;

  UserPreference({this.token, this.info});

  UserPreference.fromModel({@required UserModel model}) {
    token = model.token;
    info = UserInfoModel(
        username: model.userInfo.username,
        empCode: model.userInfo.empCode,
        title: model.userInfo.title,
        firstName: model.userInfo.firstName,
        middleName: model.userInfo.middleName,
        surname: model.userInfo.surname,
        lastlogintime: model.userInfo.lastlogintime,
        lastLoginSource: model.userInfo.lastLoginSource,
        roles: model.userInfo.roles);
  }

  UserPreference.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    info = json['info'] != null ? UserInfoModel.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (info != null) {
      data['info'] = info.toJson();
    }
    return data;
  }
}

/// For demo purpose only
extension CorporatePreferenceExtension on CorporatePreference {
  CorporateModel toModel() {
    return CorporateModel.fromPreference(preference: this);
  }

  String airlinesLogo() {
    switch (airlineCode) {
      case 'QF':
        return 'assets/images/logo-qantas.svg';
      case 'EY':
        return 'assets/images/logo-etihad.svg';
      default:
        return 'assets/images/logo-etihad.svg';
    }
  }

  String corporatesLogo() {
    switch (companyCode) {
      case 'corp001':
       return 'assets/images/logo-adnoc.svg';
      case 'corp002':
        return 'assets/images/logo-emaar.svg';
      case 'corp003':
        return 'assets/images/logo-adcb.svg';
      case 'corp004':
        return 'assets/images/logo-at&t.svg';
      case 'corp005':
        return 'assets/images/logo-etisalat.svg';
      case 'corp006':
        return 'assets/images/logo-wesfarmers.svg';
      case 'corp007':
        return 'assets/images/logo-CB.svg';
      case 'corp008':
        return 'assets/images/logo-bhp.svg';
      case 'corp009':
        return 'assets/images/logo-nab.svg';
      case 'corp010':
        return 'assets/images/logo-incat.svg';
      default:
        return 'assets/images/logo-adnoc.svg';
    }
  }
}
