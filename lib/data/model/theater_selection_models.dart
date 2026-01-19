class TheaterDateOption {
  final int day;
  final String monthShort;

  const TheaterDateOption({
    required this.day,
    required this.monthShort,
  });
}

class TheaterShowtimeOption {
  final String time;
  final String theaterAndHall;
  final int fromPrice;
  final int bonus;

  const TheaterShowtimeOption({
    required this.time,
    required this.theaterAndHall,
    required this.fromPrice,
    required this.bonus,
  });
}

