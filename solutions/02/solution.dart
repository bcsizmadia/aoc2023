import 'dart:io';

List<String> inputLines = File('data/02.txt').readAsLinesSync();

void main() {
  try {
    final int resultPartOne = sumOfPossibleGames(inputLines, 12, 13, 14);
    final int resultPartTwo = calculateSumOfMinimumPowers(inputLines);

    print('Part One Result: $resultPartOne');
    print('Part Two Result: $resultPartTwo');
  } catch (e) {
    print('Error reading the file: $e');
  }
}

int calculateSumOfMinimumPowers(List<String> input) {
  int sum = 0;

  for (String game in input) {
    final List<int> reds = [];
    final List<int> greens = [];
    final List<int> blues = [];

    for (String set in game.split(": ")[1].split(";")) {
      for (String cube in set.split(",")) {
        final List<String> info = cube.trim().split(" ");

        if (info[1].contains("red")) reds.add(int.parse(info[0]));
        if (info[1].contains("green")) greens.add(int.parse(info[0]));
        if (info[1].contains("blue")) blues.add(int.parse(info[0]));
      }
    }

    final int red = reds.reduce((a, b) => a > b ? a : b);
    final int green = greens.reduce((a, b) => a > b ? a : b);
    final int blue = blues.reduce((a, b) => a > b ? a : b);

    sum += red * green * blue;
  }

  return sum;
}

int sumOfPossibleGames(List<String> input, int redCount, int greenCount, int blueCount) {
  int possibleGamesSum = 0;

  for (String game in input) {
    final List<String> sets = game.split(':')[1].trim().split(';');

    bool possible = true;

    for (String set in sets) {
      final List<String> cubes = set.trim().split(', ');

      for (String cube in cubes) {
        final List<String> cubeInfo = cube.split(' ');
        final String color = cubeInfo[1];
        final int count = int.parse(cubeInfo[0]);

        if (color == 'red' && count > redCount ||
            color == 'green' && count > greenCount ||
            color == 'blue' && count > blueCount) {
          possible = false;
          break;
        }
      }

      if (!possible) break;
    }

    if (possible) possibleGamesSum += int.parse(game.split(':')[0].substring(5));
  }

  return possibleGamesSum;
}
