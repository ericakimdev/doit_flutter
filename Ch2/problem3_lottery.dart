import 'dart:math' as math;
import 'dart:collection';

void main() {
  var landNum = math.Random();
  HashSet<int> lotteries = HashSet();

  while (lotteries.length < 6) {
    lotteries.add(landNum.nextInt(45));
  }

  print(lotteries);
}
