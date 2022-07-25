void main() {
  Seasons seasons = Seasons.WINTER;
  print(seasons);

  print(seasons.index);
  print(Seasons.values);

  switch (seasons) {
    case Seasons.SPRING:
      print('This season is spring');
      break;
    case Seasons.SUMMER:
      print('This season is summer');
      break;
    case Seasons.SUMMER:
      print('This season is summer');
      break;
    case Seasons.SUMMER:
      print('This season is summer');
      break;
    case Seasons.FALL:
      print('This season is fall');
      break;
    case Seasons.WINTER:
      print('This season is winter');
      break;
  }
}

enum Seasons {
  SPRING,
  SUMMER,
  FALL,
  WINTER,
}
