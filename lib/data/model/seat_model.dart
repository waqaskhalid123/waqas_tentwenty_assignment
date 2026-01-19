enum SeatType {
  regular,
  vip,
  notAvailable,
}

class Seat {
  final int row;
  final int number;
  final SeatType type;
  final bool isSelected;
  final int price;

  const Seat({
    required this.row,
    required this.number,
    required this.type,
    this.isSelected = false,
    required this.price,
  });

  Seat copyWith({
    int? row,
    int? number,
    SeatType? type,
    bool? isSelected,
    int? price,
  }) {
    return Seat(
      row: row ?? this.row,
      number: number ?? this.number,
      type: type ?? this.type,
      isSelected: isSelected ?? this.isSelected,
      price: price ?? this.price,
    );
  }
}