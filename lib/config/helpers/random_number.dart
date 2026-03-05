import 'dart:math';

class RandomNumber {
  //instalar paquete: intl
  static int getNumber(double number) {
    var rng = Random();

    // Número entre 0 y number
    int rndNumber = rng.nextInt(number.toInt());

    return rndNumber;
  }
}
