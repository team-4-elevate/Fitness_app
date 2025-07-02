class UploadImageResponse {
  String? message;

  UploadImageResponse({this.message});

  factory UploadImageResponse.fromJson(Map<String, dynamic> json) {
    return UploadImageResponse(
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
      };
}
