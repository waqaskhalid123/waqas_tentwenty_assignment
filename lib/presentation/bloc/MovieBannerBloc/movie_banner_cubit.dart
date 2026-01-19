import 'package:flutter_bloc/flutter_bloc.dart';

class MovieBannerCubit extends Cubit<double> {
  MovieBannerCubit() : super(0.0);

  void startHoverAnimation() {
    emit(1.0);
  }

  void stopHoverAnimation() {
    emit(0.0);
  }

  void updateAnimationValue(double value) {
    emit(value.clamp(0.0, 1.0));
  }
}
