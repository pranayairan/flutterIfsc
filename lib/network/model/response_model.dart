class ResponseModel<T> {
  String errorMessage;
  int errorCode;
  T data;

  ResponseModel({this.errorMessage, this.errorCode, this.data});
}
