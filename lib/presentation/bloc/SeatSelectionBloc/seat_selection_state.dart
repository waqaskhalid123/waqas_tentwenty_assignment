import 'package:equatable/equatable.dart';
import 'package:ten_twenty_task/data/model/seat_model.dart';

class SeatSelectionState extends Equatable {
  final List<List<Seat>> seats;
  final List<Seat> selectedSeats;
  final double zoomLevel;

  const SeatSelectionState({
    required this.seats,
    required this.selectedSeats,
    this.zoomLevel = 1.0,
  });

  factory SeatSelectionState.initial() {
    // Create a 10x8 seat grid
    List<List<Seat>> seatsList = [];
    for (int row = 1; row <= 10; row++) {
      List<Seat> rowSeats = [];
      for (int seatNum = 1; seatNum <= 8; seatNum++) {
        SeatType type = SeatType.regular;
        int price = 50;
        
        // Row 10 is VIP
        if (row == 10) {
          type = SeatType.vip;
          price = 150;
        }
        
        // Some random seats are not available
        bool notAvailable = (row == 2 && seatNum == 3) ||
                           (row == 3 && seatNum == 5) ||
                           (row == 5 && seatNum == 2) ||
                           (row == 7 && seatNum == 7);
        
        if (notAvailable) {
          type = SeatType.notAvailable;
        }
        
        rowSeats.add(Seat(
          row: row,
          number: seatNum,
          type: type,
          price: price,
        ));
      }
      seatsList.add(rowSeats);
    }
    
    return SeatSelectionState(
      seats: seatsList,
      selectedSeats: [],
    );
  }

  SeatSelectionState copyWith({
    List<List<Seat>>? seats,
    List<Seat>? selectedSeats,
    double? zoomLevel,
  }) {
    return SeatSelectionState(
      seats: seats ?? this.seats,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      zoomLevel: zoomLevel ?? this.zoomLevel,
    );
  }

  int get totalPrice {
    return selectedSeats.fold(0, (sum, seat) => sum + seat.price);
  }

  @override
  List<Object> get props => [seats, selectedSeats, zoomLevel];
}