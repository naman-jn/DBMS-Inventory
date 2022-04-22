class CustomException implements Exception {
  final String? messsage;
  const CustomException({this.messsage = "Something went worng!"});

  @override
  String toString() {
    return "CustomException { message: $messsage }";
  }
}
