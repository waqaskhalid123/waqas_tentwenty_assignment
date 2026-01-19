

import 'package:ten_twenty_task/core/constant/app_constants.dart';
import 'package:ten_twenty_task/data/model/geenere.dart';

extension GetMovieThumbnail on String {
  String getMovieThumbnail() {
    final String path = "https://image.tmdb.org/t/p/w500/";
    return path + this;
  }
}

extension GetGenreName on List<int> {
  String getGenreName() {
    final List<Genere> genres = AppConstant.instance.genereList();
    final List<String> genreNames =
        genres.where((e) => contains(e.id)).map((e) => e.name).toList();
    return genreNames.join(", ");
  }

  List<String> getGenreNamesList() {
    final List<Genere> genres = AppConstant.instance.genereList();
    final List<String> genreNames =
        genres.where((e) => contains(e.id)).map((e) => e.name).toList();
    return genreNames;
  }
}

extension GetYoutubeVideo on String {
  String getYoutubeVideo() {
    return "https://www.youtube.com/watch?v=$this";
  }
}
