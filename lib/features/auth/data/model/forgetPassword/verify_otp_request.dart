class VerifyOtpRequest {
  String? resetCode;

  VerifyOtpRequest({this.resetCode});

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) {
    return VerifyOtpRequest(resetCode: json['resetCode'] as String?);
  }

  Map<String, dynamic> toJson() => {'resetCode': resetCode};
}
