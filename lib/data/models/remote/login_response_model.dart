import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    this.status,
    this.twoFactorAuthNeeded,
    this.googleRecaptcha,
    this.token,
    this.userInfo,
  });

  Status status;
  String twoFactorAuthNeeded;
  String googleRecaptcha;
  String token;
  UserInfo userInfo;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        status: Status.fromJson(json['status']),
        twoFactorAuthNeeded: json['twoFactorAuthNeeded'],
        googleRecaptcha: json['googleRecaptcha'],
        token: json['token'],
        userInfo: UserInfo.fromJson(json['userInfo']),
      );
}

class Status {
  Status({
    this.statusCode,
    this.statusDescription,
  });

  String statusCode;
  String statusDescription;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        statusCode: json['statusCode'],
        statusDescription: json['statusDescription'],
      );
}

class UserInfo {
  UserInfo({
    this.empCode,
    this.title,
    this.firstName,
    this.middleName,
    this.surname,
    this.lastlogintime,
    this.lastLoginSource,
    this.roles,
  });

  String empCode;
  String title;
  String firstName;
  String middleName;
  String surname;
  String lastlogintime;
  String lastLoginSource;
  List<Role> roles;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        empCode: json['empCode'],
        title: json['title'],
        firstName: json['firstName'],
        middleName: json['middleName'],
        surname: json['surname'],
        lastlogintime: json['lastlogintime'],
        lastLoginSource: json['lastLoginSource'],
        roles: List<Role>.from(json['roles'].map((x) => Role.fromJson(x))),
      );
}

class Role {
  Role({
    this.roleCode,
    this.roleName,
    this.shortcuts,
    this.modules,
  });

  String roleCode;
  String roleName;
  List<Shortcut> shortcuts;
  List<Module> modules;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleCode: json['roleCode'],
        roleName: json['roleName'],
        shortcuts: List<Shortcut>.from(
            json['shortcuts'].map((x) => Shortcut.fromJson(x))),
        modules:
            List<Module>.from(json['modules'].map((x) => Module.fromJson(x))),
      );
}

class Module {
  Module({
    this.moduleCode,
    this.moduleName,
    this.subModules,
  });

  String moduleCode;
  String moduleName;
  List<Shortcut> subModules;

  factory Module.fromJson(Map<String, dynamic> json) => Module(
        moduleCode: json['moduleCode'],
        moduleName: json['moduleName'],
        subModules: List<Shortcut>.from(
            json['subModules'].map((x) => Shortcut.fromJson(x))),
      );
}

class Shortcut {
  Shortcut({
    this.subModuleCode,
    this.subModuleName,
  });

  String subModuleCode;
  String subModuleName;

  factory Shortcut.fromJson(Map<String, dynamic> json) => Shortcut(
        subModuleCode: json['subModuleCode'],
        subModuleName: json['subModuleName'],
      );
}
