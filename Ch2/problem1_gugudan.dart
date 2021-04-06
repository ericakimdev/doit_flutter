void main() {
  var mulResult = 0;

  for (int i = 2; i <= 9; i++) {
    for (int j = 1; j <= 9; j++) {
      mulResult = i * j;
      print('$i * $j = $mulResult');

      //another way
      print('$i * $j = ${i * j}');
    }
  }
}
