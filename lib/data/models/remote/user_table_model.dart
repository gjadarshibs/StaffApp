class UserInfoListModel {
  List<UserTableInfoModel> userList;

  UserInfoListModel({this.userList});

  UserInfoListModel.fromJson(Map<String, dynamic> json) {
    if (json['userList'] != null) {
      userList =  <UserTableInfoModel>[];
      json['userList'].forEach((v) {
        userList.add( UserTableInfoModel.fromJson(v));
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

class UserTableInfoModel {
  String corporateId;
  String username;
  String password;
  String userId;

  UserTableInfoModel({this.corporateId, this.username, this.password, this.userId});

  UserTableInfoModel.fromJson(Map<String, dynamic> json) {
    corporateId = json['corporateId'];
    username = json['username'];
    password = json['password'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['corporateId'] = corporateId;
    data['username'] = username;
    data['password'] = password;
    data['userId'] = userId;
    return data;
  }
}

