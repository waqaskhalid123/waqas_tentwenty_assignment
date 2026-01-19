import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ten_twenty_task/presentation/bloc/SeatSelectionBloc/seat_selection_bloc.dart';
import 'package:ten_twenty_task/presentation/bloc/SeatSelectionBloc/seat_selection_state.dart';
import 'package:ten_twenty_task/presentation/widgets/zoom_button_widget.dart';

class SeatImageViewer extends StatefulWidget {
  const SeatImageViewer({super.key});

  @override
  State<SeatImageViewer> createState() => _SeatImageViewerState();
}

class _SeatImageViewerState extends State<SeatImageViewer> {
  final ScrollController _scrollController = ScrollController();
  bool _hasCalculatedInitialZoom = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateInitialZoom();
    });
  }

  void _calculateInitialZoom() {
    if (_hasCalculatedInitialZoom) return;
    
    // Mark as calculated - initial zoom of 1.0 should show the image fully
    // Scrollbar will be visible when image goes out of screen
    _hasCalculatedInitialZoom = true;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatSelectionCubit, SeatSelectionState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              thickness: 6,
              radius: const Radius.circular(3),
              scrollbarOrientation: ScrollbarOrientation.bottom,
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Transform.scale(
                    scale: state.zoomLevel,
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      "assets/images/theater.png",
                      height: 350,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            /// Zoom Buttons
            Positioned(
              bottom: 16,
              right: 16,
              child: Row(
                children: [
                  ZoomButtonWidget(icon: Icons.add),
                  const SizedBox(width: 8),
                  ZoomButtonWidget(icon: Icons.remove),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
