class MasterResponseModel {
  final int? status;
  final bool? error;
  final String? message;

  const MasterResponseModel({this.status, this.error, this.message});

  factory MasterResponseModel.fromJson(Map<String, dynamic> json) {
    return MasterResponseModel(
      status: json['status'],
      error: json['error'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'error': error, 'message': message};
  }
}
