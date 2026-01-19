import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ten_twenty_task/core/styles/app_colors.dart';
import 'package:ten_twenty_task/core/styles/typography.dart';
import 'package:ten_twenty_task/presentation/bloc/BottomNavBloc/bottom_nav_bloc.dart';
import 'package:ten_twenty_task/presentation/bloc/BottomNavBloc/bottom_nav_event.dart';

class WatchSearchBar extends StatefulWidget {
  final String? initialValue;
  final Function(String)? onChanged;
  final VoidCallback? onClear;
  final Function(String)? onSubmitted;
  final bool showClearButton;

  const WatchSearchBar({
    super.key,
    this.initialValue,
    this.onChanged,
    this.onClear,
    this.onSubmitted,
    this.showClearButton = false,
  });

  @override
  State<WatchSearchBar> createState() => _WatchSearchBarState();
}

class _WatchSearchBarState extends State<WatchSearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void didUpdateWidget(WatchSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue &&
        _controller.text != widget.initialValue) {
      _controller.text = widget.initialValue ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.textInputFilledForeground,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: AppColors.textInputBordered,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: SvgPicture.asset(
                'assets/images/search.svg',
                width: 20,
                height: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: widget.onChanged,
                onSubmitted: widget.onSubmitted,
                autofocus: true,
                textInputAction: TextInputAction.search,
                style: kStyle14400.copyWith(
                  color: AppColors.textDark,
                ),
                decoration: InputDecoration(
                  hintText: 'TV shows, movies and more',
                  hintStyle: kStyle14400.copyWith(
                    color: AppColors.textInputHint,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            if (widget.showClearButton)
              InkWell(
                onTap: () {
                  _controller.clear();
                  widget.onClear?.call();
                },
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: SvgPicture.asset(
                    'assets/images/x_mark_icon.svg',
                    width: 20,
                    height: 20,
                  ),
                ),
              )
            else
              InkWell(
                onTap: () {
                  context.read<BottomNavBloc>().add(
                        const WatchSearchToggled(showSearch: false),
                      );
                },
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: SvgPicture.asset(
                    'assets/images/x_mark_icon.svg',
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
