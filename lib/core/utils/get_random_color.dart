import 'dart:math';
import 'dart:ui';

Color getRandomColor() {
  // Create an instance of Random class
  Random random = Random();

  // Generate random values for red, green, and blue components
  int red = random.nextInt(256); // Generates a random value between 0 and 255
  int green = random.nextInt(256);
  int blue = random.nextInt(256);

  // Create a Color object using the generated values
  Color color = Color.fromRGBO(red, green, blue, 1);

  return color;
}