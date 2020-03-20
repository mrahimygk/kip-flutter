class ApiResponse {
  final statusCode;
  final statusText;
  final dynamic data;

  ApiResponse(this.statusCode, this.statusText, this.data);

  factory ApiResponse.fromMap(Map<String, dynamic> json) {
    return ApiResponse(json['status_code'], json['status_text'], json['data']);
  }
}
