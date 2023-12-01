import 'dart:io';
import 'package:aoc/extensions/colored_string.dart';

void printHelp() {
  print(File('lib/banner').readAsStringSync());
  print("Usage".yellow);
  print("    dart run [options]");
  print("");
  print("Options".yellow);
  print("     aoc:new        ${'Create a new day'.blue}");
  print("");
}

void main(List<String> args) {
  if (args.isEmpty) printHelp();
}
