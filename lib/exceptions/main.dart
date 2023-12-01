import 'dart:io';

import 'file_exists.dart';
import 'missing_value_error.dart';
import '../extensions/colored_string.dart';

export 'file_exists.dart';
export 'missing_value_error.dart';

class ErrorHandling {
  static void handle(dynamic e) {
    if (e is MissingValueError) {
      handleMissingValueError(e);
    } else if (e is FileExists) {
      handleFileExists(e);
    } else {
      print('[ ERROR ]:'.red + e.toString());
      exit(1);
    }
  }

  static void handleMissingValueError(MissingValueError e) {
    print("${'[ MISSING VALUE ERROR ] =>'.red} ${e.message}");
    exit(1);
  }

  static void handleFileExists(FileExists e) {
    print("${'[ FILE EXISTS ] =>'.red} ${e.message}");
    exit(1);
  }
}
