import 'dart:io';
import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:aoc/exceptions/main.dart';

DotEnv env = DotEnv()..load();

void main() {
  try {
    final String day = askDay();

    createTemplate(day);
    addInput(day);
  } catch (e) {
    ErrorHandling.handle(e);
  }
}

String askDay() {
  stdout.write('Enter the challenge number: ');
  final input = stdin.readLineSync()?.trim() ?? '';

  if (int.tryParse(input) == null) throw MissingValueError('Invalid value provided');
  if (input.isEmpty) throw MissingValueError('No value provided');
  return input;
}

void createTemplate(String day) {
  day = day.padLeft(2, '0');
  final String path = 'solutions/$day';

  final template = '''
import 'dart:io';

List<String> inputLines = File('data/$day.txt').readAsLinesSync();

void main() {
  print(inputLines);
}
''';

  Directory(path).createSync(recursive: true);
  if (File('$path/solution.dart').existsSync()) throw FileExists('Challenge already exists');
  File('$path/solution.dart').writeAsStringSync(template);
}

Future<void> addInput(String day) async {
  final String? cookie = env['COOKIE'];
  final url = Uri.parse('https://adventofcode.com/2023/day/$day/input');

  try {
    final response = await http.get(url, headers: {'cookie': 'session=$cookie'});

    if (response.statusCode == 200) {
      File('data/${day.padLeft(2, '0')}.txt').writeAsStringSync(response.body);
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
