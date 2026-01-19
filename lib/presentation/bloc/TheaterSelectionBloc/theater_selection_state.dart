import 'package:equatable/equatable.dart';
import 'package:ten_twenty_task/data/model/theater_selection_models.dart';

class TheaterSelectionState extends Equatable {
  final int selectedDateIndex;
  final int selectedShowtimeIndex;
  final List<TheaterDateOption> dateOptions;
  final List<TheaterShowtimeOption> showtimes;

  const TheaterSelectionState({
    required this.selectedDateIndex,
    required this.selectedShowtimeIndex,
    required this.dateOptions,
    required this.showtimes,
  });

  factory TheaterSelectionState.initial() {
    return const TheaterSelectionState(
      selectedDateIndex: 0,
      selectedShowtimeIndex: 0,
      dateOptions: [
        TheaterDateOption(day: 5, monthShort: 'Mar'),
        TheaterDateOption(day: 6, monthShort: 'Mar'),
        TheaterDateOption(day: 7, monthShort: 'Mar'),
        TheaterDateOption(day: 8, monthShort: 'Mar'),
        TheaterDateOption(day: 9, monthShort: 'Mar'),
      ],
      showtimes: [
        TheaterShowtimeOption(
          time: '12:30',
          theaterAndHall: 'Cinetech + Hall 1',
          fromPrice: 50,
          bonus: 2500,
        ),
        TheaterShowtimeOption(
          time: '13:30',
          theaterAndHall: 'Cinetech + Hall 1',
          fromPrice: 75,
          bonus: 3000,
        ),
      ],
    );
  }

  TheaterSelectionState copyWith({
    int? selectedDateIndex,
    int? selectedShowtimeIndex,
    List<TheaterDateOption>? dateOptions,
    List<TheaterShowtimeOption>? showtimes,
  }) {
    return TheaterSelectionState(
      selectedDateIndex: selectedDateIndex ?? this.selectedDateIndex,
      selectedShowtimeIndex: selectedShowtimeIndex ?? this.selectedShowtimeIndex,
      dateOptions: dateOptions ?? this.dateOptions,
      showtimes: showtimes ?? this.showtimes,
    );
  }

  @override
  List<Object> get props => [
        selectedDateIndex,
        selectedShowtimeIndex,
        dateOptions,
        showtimes,
      ];
}
