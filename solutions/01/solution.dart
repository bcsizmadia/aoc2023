import 'dart:io';

List<String> inputLines = File('data/01.txt').readAsLinesSync();

void main() {
  try {
    final int resultPartOne = processInput(inputLines);
    final int resultPartTwo = processInput(inputLines, isPartTwo: true);

    print('Part One Result: $resultPartOne');
    print('Part Two Result: $resultPartTwo');
  } catch (e) {
    print('Error reading the file: $e');
  }
}

int processInput(Iterable<String> inputLines, {bool isPartTwo = false}) {
  const List<String> digitWords = [
    'zero',
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine'
  ];

  return inputLines.fold(0, (sum, line) {
    int? firstDigit, secondDigit;

    for (var i = 0; i < line.length; i++) {
      final int? parsedDigit = int.tryParse(line[i]);

      if (parsedDigit != null) {
        firstDigit ??= parsedDigit;
        secondDigit = parsedDigit;
      } else if (isPartTwo) {
        for (final (int value, String digitWord) in digitWords.indexed) {
          if (i + digitWord.length - 1 < line.length &&
              line.substring(i, i + digitWord.length) == digitWord) {
            firstDigit ??= value;
            secondDigit = value;
          }
        }
      }
    }

    secondDigit ??= firstDigit;

    return sum + int.parse('$firstDigit$secondDigit');
  });
}
