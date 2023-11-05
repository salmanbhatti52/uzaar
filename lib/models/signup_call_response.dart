class SignupCallResponse {
  String status;
  String message;

  SignupCallResponse({
    required this.status,
    required this.message,
  });

  factory SignupCallResponse.fromJson(Map<String, dynamic> json) {
    return SignupCallResponse(
      message: json['message'] as String,
      status: json['status'] as String,
    );
  }
}
