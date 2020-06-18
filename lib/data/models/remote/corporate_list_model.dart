import 'package:flutter/material.dart';
import 'package:ifly_corporate_app/data/models/local/auth_prefrence_data.dart';

class CorporatesListModel {
  List<CorporateModel> corporates;

  CorporatesListModel({this.corporates});

  CorporatesListModel.fromJson(Map<String, dynamic> json) {
    if (json['corporates'] != null) {
      corporates = <CorporateModel>[];
      json['corporates'].forEach((v) {
        corporates.add(CorporateModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (corporates != null) {
      data['corporates'] = corporates.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CorporateModel {
  StatusModel status;
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

  CorporateModel(
      {this.status,
      this.airlineCode,
      this.airlineName,
      this.airlineLogo,
      this.companyCode,
      this.companyName,
      this.companyLogo,
      this.webServiceUrl,
      this.desktopUrl,
      this.authCount,
      this.authMode});

  CorporateModel.fromPreference({@required CorporatePreference preference}) {
    status = StatusModel(statusCode: '0', statusDescription: '');
    airlineCode = preference.airlineCode;
    airlineName = preference.airlineName;
    airlineLogo = preference.airlineLogo;
    companyCode = preference.companyCode;
    companyName = preference.companyName;
    companyLogo = preference.companyLogo;
    webServiceUrl = preference.webServiceUrl;
    desktopUrl = preference.desktopUrl;
    authCount = preference.authCount;
    authMode = preference.authMode;
  }

  CorporateModel.fromJson(Map<String, dynamic> json) {
    status =
        json['status'] != null ? StatusModel.fromJson(json['status']) : null;
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
    if (status != null) {
      data['status'] = status.toJson();
    }
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

class StatusModel {
  String statusCode;
  String statusDescription;

  StatusModel({this.statusCode, this.statusDescription});

  StatusModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusDescription = json['statusDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['statusDescription'] = statusDescription;
    return data;
  }
}

extension on CorporateModel {
  CorporatePreference toPreference() {
    return CorporatePreference.fromModel(model: this);
  }
}

abstract class UserAuthenticationType {
  static const lcl = 'LCL';
  static const ldap = 'LDAP';
  static const smal = 'SAML';
  static const okta = 'OKTA';
}

enum AuthenticationType {
  corporate,
  ldap,
  lcl,
  smal,
  okta,
  multiple,
  undefined
}

extension UserAuthenticationTypeExtension on AuthenticationType {
  String get value {
    switch (this) {
      case AuthenticationType.ldap:
        return UserAuthenticationType.ldap;
      case AuthenticationType.lcl:
        return UserAuthenticationType.lcl;
      case AuthenticationType.smal:
        return UserAuthenticationType.smal;
      case AuthenticationType.okta:
        return UserAuthenticationType.okta;
      case AuthenticationType.corporate:
        return 'CORPORATE';
      case AuthenticationType.multiple:
        return 'MULTIPLE';
      default:
        return 'UNDEFINED';
    }
  }
}
