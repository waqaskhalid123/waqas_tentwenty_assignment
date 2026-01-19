class DateOption {
  final int day;
  final String monthShort;
  const DateOption({required this.day, required this.monthShort});
}

class ShowtimeOption {
  final String time;
  final String theaterAndHall;
  final int fromPrice;
  final int bonus;
  const ShowtimeOption({
    required this.time,
    required this.theaterAndHall,
    required this.fromPrice,
    required this.bonus,
  });
}
