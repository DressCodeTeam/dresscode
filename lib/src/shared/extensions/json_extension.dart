import 'package:dresscode/src/utils/required_field.dart';

extension JsonRequireExtension on Map<String, dynamic> {
  T require<T>(String key, {String? className}) {
    return requireField<T>(this, key, className: className);
  }
}
