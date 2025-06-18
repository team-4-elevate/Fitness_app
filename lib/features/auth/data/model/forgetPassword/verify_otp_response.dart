class VerifyOtpResponse {
  String? status;

  VerifyOtpResponse({this.status});

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(status: json['status'] as String?);
  }

  Map<String, dynamic> toJson() => {'status': status};
}
