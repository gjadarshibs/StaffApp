import 'package:ifly_corporate_app/data/models/remote/corporate_list_model.dart';


abstract class BasicAuthStatus {
  /// value = '0' Authentication successful.
  static const success = '0';
  /// value = '-3' Authentication successful, change password is needed.
  static const changePassword = '-3';
  /// value = '-2' Authentication successful, account is locked or not permitted.
  static const locked = '-2';
  /// value = '-4' Authentication successful, email is not configured.
  static const configureEmail = '-4';
   /// value = '-6' Authentication successful, restricted by admin.
  static const acessDenied = '-6';
  /// value = '-1' authentication failed
  static const invalidCredentials = '-1';
  /// value = '-5' User tried too many invalid attempts and a google recaptcha is required.
  static const tooManyAttempts = '-5';
  
}


abstract class TwoFactorAuthStatus {
  /// value = '0' Authentication successful.
  static const success = '0';
  /// value = '-3' Authentication successful, change password is needed.
  static const changePassword = '-3';
  /// value = '-2' Authentication successful, account is locked or not permitted.
  static const locked = '-2';
  /// value = '-4' Authentication successful, email is not configured.
  static const codeExpired = '-4';
  /// value = '-1' authentication failed
  static const invalidCredentials = '-1';
 
}


abstract class TwoFactorAuthResendOtpStatus {
  /// value = '0' Authentication successful.
  static const success = '0';
  /// value = '-2' Authentication successful, account is locked or not permitted.
  static const locked = '-2';
  /// value = '-1' authentication failed
  static const error = '-1';
 
}

class UserListModel {
  List<UserModel> userList;

  UserListModel({this.userList});

  UserListModel.fromJson(Map<String, dynamic> json) {
    if (json['userList'] != null) {
      userList =  <UserModel>[];
      json['userList'].forEach((v) {
        userList.add( UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (userList != null) {
      data['userList'] = userList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class UserModel {
  StatusModel status;
  String twoFactorAuthNeeded;
  String googleRecaptcha;
  String token;
  String customErrorMessage;
  String noOfAttemptsRemaining;
  UserInfoModel userInfo;

  UserModel(
      {this.status,
      this.twoFactorAuthNeeded,
      this.googleRecaptcha,
      this.token,
      this.customErrorMessage,
      this.noOfAttemptsRemaining,
      this.userInfo});

  UserModel.fromJson(Map<String, dynamic> json) {
    status =
        json['status'] != null ?  StatusModel.fromJson(json['status']) : null;
    twoFactorAuthNeeded = json['twoFactorAuthNeeded'];
    googleRecaptcha = json['googleRecaptcha'];
    token = json['token'];
    customErrorMessage =  json['customErrorMessage'];
    noOfAttemptsRemaining = json['noOfAttemptsRemaining'];
    userInfo = json['userInfo'] != null
        ?  UserInfoModel.fromJson(json['userInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (status != null) {
      data['status'] = status.toJson();
    }
    data['twoFactorAuthNeeded'] = twoFactorAuthNeeded;
    data['googleRecaptcha'] = googleRecaptcha;
    data['token'] = token;
    if (userInfo != null) {
      data['userInfo'] = userInfo.toJson();
    }
    return data;
  }
}



class UserInfoModel {
  String username;
  String empCode;
  String title;
  String firstName;
  String middleName;
  String surname;
  String lastlogintime;
  String lastLoginSource;
  List<RoleModel> roles;

  UserInfoModel(
      {
      this.username, 
      this.empCode,
      this.title,
      this.firstName,
      this.middleName,
      this.surname,
      this.lastlogintime,
      this.lastLoginSource,
      this.roles});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    username = json['empCode'] ?? '';
    empCode = json['empCode'];
    title = json['title'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    surname = json['surname'];
    lastlogintime = json['lastlogintime'];
    lastLoginSource = json['lastLoginSource'];
    if (json['roles'] != null) {
      roles =  <RoleModel>[];
      json['roles'].forEach((v) {
        roles.add(RoleModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['username'] = username;
    data['empCode'] = empCode;
    data['title'] = title;
    data['firstName'] = firstName;
    data['middleName'] = middleName;
    data['surname'] = surname;
    data['lastlogintime'] = lastlogintime;
    data['lastLoginSource'] = lastLoginSource;
    if (roles != null) {
      data['roles'] = roles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoleModel {
  String roleCode;
  String roleName;
  List<ShortcutModel> shortcuts;
  List<ModuleModel> modules;

  RoleModel({this.roleCode, this.roleName, this.shortcuts, this.modules});

  RoleModel.fromJson(Map<String, dynamic> json) {
    roleCode = json['roleCode'];
    roleName = json['roleName'];
    if (json['shortcuts'] != null) {
      shortcuts =  <ShortcutModel>[];
      json['shortcuts'].forEach((v) {
        shortcuts.add( ShortcutModel.fromJson(v));
      });
    }
    if (json['modules'] != null) {
      modules = <ModuleModel>[];
      json['modules'].forEach((v) {
        modules.add(ModuleModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['roleCode'] = roleCode;
    data['roleName'] = roleName;
    if (shortcuts != null) {
      data['shortcuts'] = shortcuts.map((v) => v.toJson()).toList();
    }
    if (modules != null) {
      data['modules'] = modules.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShortcutModel {
  String subModuleCode;
  String subModuleName;

  ShortcutModel({this.subModuleCode, this.subModuleName});

  ShortcutModel.fromJson(Map<String, dynamic> json) {
    subModuleCode = json['subModuleCode'];
    subModuleName = json['subModuleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['subModuleCode'] = subModuleCode;
    data['subModuleName'] = subModuleName;
    return data;
  }
}

class ModuleModel {
  String moduleCode;
  String moduleName;
  List<SubModuleModel> subModules;

  ModuleModel({this.moduleCode, this.moduleName, this.subModules});

  ModuleModel.fromJson(Map<String, dynamic> json) {
    moduleCode = json['moduleCode'];
    moduleName = json['moduleName'];
    if (json['subModules'] != null) {
      subModules =  <SubModuleModel>[];
      json['subModules'].forEach((v) {
        subModules.add( SubModuleModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['moduleCode'] = moduleCode;
    data['moduleName'] = moduleName;
    if (subModules != null) {
      data['subModules'] = subModules.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class SubModuleModel {
  String subModuleCode;
  String subModuleName;

  SubModuleModel({this.subModuleCode, this.subModuleName});

  SubModuleModel.fromJson(Map<String, dynamic> json) {
    subModuleCode = json['subModuleCode'];
    subModuleName = json['subModuleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['subModuleCode'] = subModuleCode;
    data['subModuleName'] = subModuleName;
    return data;
  }
}


