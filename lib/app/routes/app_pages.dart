import 'package:get/get.dart';

import '../modules/DetailPage/bindings/detail_page_binding.dart';
import '../modules/DetailPage/views/detail_page_view.dart';
import '../modules/Login_Page/bindings/login_page_binding.dart';
import '../modules/Login_Page/views/login_page_view.dart';
import '../modules/detail_watch_list/bindings/detail_watch_list_binding.dart';
import '../modules/detail_watch_list/views/detail_watch_list_view.dart';
import '../modules/genre_result/bindings/genre_result_binding.dart';
import '../modules/genre_result/views/genre_result_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/list_genre/bindings/list_genre_binding.dart';
import '../modules/list_genre/views/list_genre_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/trending_page/bindings/trending_page_binding.dart';
import '../modules/trending_page/views/trending_page_view.dart';
import '../modules/watch_list/bindings/watch_list_binding.dart';
import '../modules/watch_list/views/watch_list_view.dart';

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
    GetPage(
      name: _Paths.TRENDING_PAGE,
      page: () => const TrendingPageView(),
      binding: TrendingPageBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => const LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_WATCH_LIST,
      page: () => const DetailWatchListView(),
      binding: DetailWatchListBinding(),
    ),
    GetPage(
      name: _Paths.WATCH_LIST,
      page: () => const WatchListView(),
      binding: WatchListBinding(),
    ),
  ];
}
