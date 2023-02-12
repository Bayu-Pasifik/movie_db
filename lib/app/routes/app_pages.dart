import 'package:get/get.dart';

import '../modules/DetailPage/bindings/detail_page_binding.dart';
import '../modules/DetailPage/views/detail_page_view.dart';
import '../modules/genre_result/bindings/genre_result_binding.dart';
import '../modules/genre_result/views/genre_result_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/list_genre/bindings/list_genre_binding.dart';
import '../modules/list_genre/views/list_genre_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PAGE,
      page: () => const DetailPageView(),
      binding: DetailPageBinding(),
    ),
    GetPage(
      name: _Paths.LIST_GENRE,
      page: () => const ListGenreView(),
      binding: ListGenreBinding(),
    ),
    GetPage(
      name: _Paths.GENRE_RESULT,
      page: () => const GenreResultView(),
      binding: GenreResultBinding(),
    ),
  ];
}
