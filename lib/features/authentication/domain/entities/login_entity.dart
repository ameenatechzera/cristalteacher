// // class LoginEntity {
// //   final int? status;
// //   final bool? error;
// //   final String? message;
// //   final LoginData? data;

// //   const LoginEntity({this.status, this.error, this.message, this.data});
// // }

// // class LoginData {
// //   final String? token;
// //   final UserEntity? user;

// //   const LoginData({this.token, this.user});
// // }

// // class UserEntity {
// //   final int? id;
// //   final String? username;
// //   final String? name;
// //   final String? createdDate;
// //   final String? createdUser;
// //   final String? modifiedDate;
// //   final String? modifiedUser;
// //   final int? employeeId;
// //   final bool? status;
// //   final int? branchId;
// //   final int? usergroupId;

// //   const UserEntity({
// //     this.id,
// //     this.username,
// //     this.name,
// //     this.createdDate,
// //     this.createdUser,
// //     this.modifiedDate,
// //     this.modifiedUser,
// //     this.employeeId,
// //     this.status,
// //     this.branchId,
// //     this.usergroupId,
// //   });
// // }
// class LoginEntity {
//   final int? status;
//   final bool? error;
//   final String? message;
//   final LoginData? data;

//   const LoginEntity({this.status, this.error, this.message, this.data});
// }

// class LoginData {
//   final String? token;
//   final UserEntity? user;

//   const LoginData({this.token, this.user});

//   factory LoginData.fromJson(Map<String, dynamic> json) {
//     return LoginData(
//       token: json['token'],
//       user: json['user'] != null ? UserEntity.fromJson(json['user']) : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {'token': token, 'user': user?.toJson()};
//   }
// }

// class UserEntity {
//   final int? id;
//   final String? username;
//   final String? name;
//   final String? createdDate;
//   final String? createdUser;
//   final String? modifiedDate;
//   final String? modifiedUser;
//   final int? employeeId;
//   final bool? status;
//   final int? branchId;
//   final int? usergroupId;

//   const UserEntity({
//     this.id,
//     this.username,
//     this.name,
//     this.createdDate,
//     this.createdUser,
//     this.modifiedDate,
//     this.modifiedUser,
//     this.employeeId,
//     this.status,
//     this.branchId,
//     this.usergroupId,
//   });

//   factory UserEntity.fromJson(Map<String, dynamic> json) {
//     return UserEntity(
//       id: json['id'],
//       username: json['username'],
//       name: json['name'],
//       createdDate: json['CreatedDate'],
//       createdUser: json['CreatedUser'],
//       modifiedDate: json['ModifiedDate'],
//       modifiedUser: json['ModifiedUser'],
//       employeeId: json['employee_id'],
//       status: json['status'],
//       branchId: json['branch_id'],
//       usergroupId: json['usergroup_id'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'username': username,
//       'name': name,
//       'CreatedDate': createdDate,
//       'CreatedUser': createdUser,
//       'ModifiedDate': modifiedDate,
//       'ModifiedUser': modifiedUser,
//       'employee_id': employeeId,
//       'status': status,
//       'branch_id': branchId,
//       'usergroup_id': usergroupId,
//     };
//   }
// }
class LoginEntity {
  final int? status;
  final bool? error;
  final String? message;
  final LoginData? data;

  const LoginEntity({this.status, this.error, this.message, this.data});

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'error': error,
      'message': message,
      'data': data?.toJson(),
    };
  }

  factory LoginEntity.fromJson(Map<String, dynamic> json) {
    return LoginEntity(
      status: json['status'],
      error: json['error'],
      message: json['message'],
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }
}

class LoginData {
  final String? token;
  final UserEntity? user;

  const LoginData({this.token, this.user});

  Map<String, dynamic> toJson() {
    return {'token': token, 'user': user?.toJson()};
  }

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'],
      user: json['user'] != null ? UserEntity.fromJson(json['user']) : null,
    );
  }
}

class UserEntity {
  final int? id;
  final String? username;
  final String? name;
  final String? createdDate;
  final String? createdUser;
  final String? modifiedDate;
  final String? modifiedUser;
  final int? employeeId;
  final bool? status;
  final int? branchId;
  final int? usergroupId;

  const UserEntity({
    this.id,
    this.username,
    this.name,
    this.createdDate,
    this.createdUser,
    this.modifiedDate,
    this.modifiedUser,
    this.employeeId,
    this.status,
    this.branchId,
    this.usergroupId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'CreatedDate': createdDate,
      'CreatedUser': createdUser,
      'ModifiedDate': modifiedDate,
      'ModifiedUser': modifiedUser,
      'employeeId': employeeId,
      'Status': status,
      'branchId': branchId,
      'usergroupId': usergroupId,
    };
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      createdDate: json['CreatedDate'],
      createdUser: json['CreatedUser']?.toString(),
      modifiedDate: json['ModifiedDate'],
      modifiedUser: json['ModifiedUser']?.toString(),
      employeeId: json['employeeId'],
      status: json['Status'],
      branchId: json['branchId'],
      usergroupId: json['usergroupId'],
    );
  }
}
