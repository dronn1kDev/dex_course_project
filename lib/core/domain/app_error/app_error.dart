typedef ValidationErrorsMap = Map<String, String>;
typedef GlobalErrorsMap = Map<String, Map<String, String>>;
typedef SelfValidationErrorsMap = Map<String, String>;

extension GlobalDescription on GlobalErrorsMap {
  String getDescription(String errorKey, String errorDescriptionKey) {
    return AppError.globalErrorsMap[errorKey]?[errorDescriptionKey] ??
        AppError.globalErrorsMap[errorKey]?[AppError._defaultErrorKey] ??
        AppError._defaultErrorText;
  }
}

extension ValidationDescription on ValidationErrorsMap {
  String getDescription(final String errorKey) =>
      AppError.validationErrorsMap[errorKey] ??
      AppError.validationErrorsMap[AppError._defaultErrorKey] ??
      AppError._defaultErrorText;
}

sealed class AppError {
  final String code;

  AppError({
    required this.code,
  });

  String get description;

  static const _errorKeySplitter = '.';
  static const _defaultErrorKey = 'Default';
  // TODO this field have to handle all localizations
  static const _defaultErrorText = 'Unknown error';

  static GlobalErrorsMap globalErrorsMap = {};
  static ValidationErrorsMap validationErrorsMap = {};
  static SelfValidationErrorsMap selfValidationErrorsMap = {};

  static String getTextByErrorKeyFromBackEnd(String key) {
    final splittedKey = key.split(_errorKeySplitter);
    if (splittedKey case ['validations', final String errorKey]) {
      return validationErrorsMap[errorKey] ??
          validationErrorsMap[_defaultErrorKey] ??
          _defaultErrorText;
    } else if (splittedKey
        case [
          'errors',
          final String errorKey,
          final String errorDescriptionKey
        ]) {
      return globalErrorsMap[errorKey]?[errorDescriptionKey] ??
          globalErrorsMap[errorKey]?[_defaultErrorKey] ??
          _defaultErrorText;
    } else {
      throw Exception('Unknown error type $key');
    }
  }
}

class SelfValidationError implements AppError {
  @override
  final String code;

  const SelfValidationError(this.code);

  @override
  String get description =>
      AppError.selfValidationErrorsMap.getDescription(code);
}

class ValidationError implements AppError {
  @override
  final String code;

  final String fieldName;

  const ValidationError(this.code, this.fieldName);

  @override
  String get description {
    final splittedCode = code.split(AppError._errorKeySplitter);
    if (splittedCode case ['validations', final String errorKey]) {
      return AppError.validationErrorsMap.getDescription(errorKey);
    } else {
      return AppError._defaultErrorText;
    }
  }
}

class SpecificError implements AppError {
  @override
  final String code;

  SpecificError(this.code);

  @override
  String get description {
    final splittedCode = code.split(AppError._errorKeySplitter);
    if (splittedCode
        case [final String errorKey, final String errorDescriptionKey]) {
      return AppError.globalErrorsMap
          .getDescription(errorKey, errorDescriptionKey);
    } else {
      return AppError._defaultErrorText;
    }
  }
}
