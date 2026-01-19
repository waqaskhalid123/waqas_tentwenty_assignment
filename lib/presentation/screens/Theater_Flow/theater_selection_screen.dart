import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ten_twenty_task/core/styles/app_colors.dart';
import 'package:ten_twenty_task/core/styles/typography.dart';
import 'package:ten_twenty_task/presentation/bloc/TheaterSelectionBloc/theater_selection_cubit.dart';
import 'package:ten_twenty_task/presentation/bloc/TheaterSelectionBloc/theater_selection_state.dart';
import 'package:ten_twenty_task/presentation/widgets/horizontal_date_selector.dart';
import 'package:ten_twenty_task/presentation/widgets/showtime_option_card.dart';
import 'package:ten_twenty_task/presentation/widgets/showtime_separator.dart';
import 'package:ten_twenty_task/presentation/widgets/theater_selection_app_bar.dart';
import 'package:ten_twenty_task/presentation/widgets/select_seats_button.dart';
import 'package:ten_twenty_task/routes/app_routes.dart';

class TheaterSelectionScreen extends StatelessWidget {
  final String movieTitle;
  final String? subtitle;

  const TheaterSelectionScreen({
    super.key,
    required this.movieTitle,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TheaterSelectionCubit(),
      child: BlocBuilder<TheaterSelectionCubit, TheaterSelectionState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.scaffoldBackground,
            appBar: TheaterSelectionAppBar(
              title: movieTitle,
              subtitle: subtitle, 
            ),
            body: SafeArea(
              top: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date',
                            style: kStyle16500.copyWith(
                              color: AppColors.textDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          HorizontalDateSelector(
                            options: state.dateOptions
                                .map((d) =>
                                    DateOption(label: '${d.day} ${d.monthShort}'))
                                .toList(growable: false),
                            selectedIndex: state.selectedDateIndex,
                            onSelected: (index) {
                              context.read<TheaterSelectionCubit>().selectDate(
                                    index,
                                  );
                            },
                          ),
                          const SizedBox(height: 16),
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFEAEAEA),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 265,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.showtimes.length,
                              separatorBuilder: (context, _) =>
                                  const ShowtimeSeparator(
                                color: Color(0xFFEAEAEA),
                              ),
                              itemBuilder: (context, index) {
                                final s = state.showtimes[index];
                                return ShowtimeOptionCard(
                                  time: s.time,
                                  theaterAndHall: s.theaterAndHall,
                                  fromPrice: s.fromPrice,
                                  bonus: s.bonus,
                                  isSelected:
                                      index == state.selectedShowtimeIndex,
                                  onTap: () {
                                    context
                                        .read<TheaterSelectionCubit>()
                                        .selectShowtime(index);
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 18),
                        ],
                      ),
                    ),
                    SelectSeatsButton(onPressed: () {
                      final selectedDate = state.dateOptions[state.selectedDateIndex];
                      final selectedShowtime = state.showtimes[state.selectedShowtimeIndex];
                      Navigator.of(context).pushNamed(
                        NamedRoutes.selectSeats.path,
                        arguments: {
                          'title': movieTitle,
                          'date': '${selectedDate.day} ${selectedDate.monthShort}',
                          'time': selectedShowtime.time,
                          'hall': selectedShowtime.theaterAndHall,
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
