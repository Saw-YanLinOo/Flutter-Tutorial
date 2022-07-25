void main() {
  Seasons seasons = Seasons.WINTER;
  print(seasons);

  print(seasons.index);
  print(Seasons.values);
}

enum Seasons {
  SPRING,
  SUMMER,
  FALL,
  WINTER,
}
