import 'package:cristalteacher/features/authentication/domain/entities/login_entity.dart';

class LoginResponseModel extends LoginEntity {
  LoginResponseModel({
    super.status,
    super.error,
    super.message,
    LoginDataModel? super.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json['status'] as int?,
      error: json['error'] as bool?,
      message: json['message']?.toString(),
      data: json['data'] != null
          ? LoginDataModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class LoginDataModel extends LoginData {
  LoginDataModel({super.token, UserModel? super.user});

  factory LoginDataModel.fromJson(Map<String, dynamic> json) {
    return LoginDataModel(
      token: json['token']?.toString(),
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }
}

class UserModel extends UserEntity {
  UserModel({
    super.id,
    super.username,
    super.name,
    super.createdDate,
    super.createdUser,
    super.modifiedDate,
    super.modifiedUser,
    super.employeeId,
    super.status,
    super.branchId,
    super.usergroupId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int?,
      username: json['username']?.toString(),
      name: json['name']?.toString(),
      createdDate: json['CreatedDate']?.toString(),
      createdUser: json['CreatedUser']?.toString(),
      modifiedDate: json['ModifiedDate']?.toString(),
      modifiedUser: json['ModifiedUser']?.toString(),
      employeeId: json['employeeId'] as int?,
      status: json['Status'] as bool?,
      branchId: json['branchId'] as int?,
      usergroupId: json['usergroupId'] as int?,
    );
  }
}
