typedef RestApiErrorDetails = ({String code, List<String>? params});

class RestApiValidationErrorModel {
  final String fieldName;
  final List<RestApiErrorDetails> errorList;

  RestApiValidationErrorModel({
    required this.fieldName,
    required this.errorList,
  });
}
