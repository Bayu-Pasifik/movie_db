import 'package:get/get.dart';

import '../modules/All_Cast/bindings/all_cast_binding.dart';
import '../modules/All_Cast/views/all_cast_view.dart';
import '../modules/All_Now_Playing/bindings/all_now_playing_binding.dart';
import '../modules/All_Now_Playing/views/all_now_playing_view.dart';
import '../modules/All_Popular_Movie/bindings/all_popular_movie_binding.dart';
import '../modules/All_Popular_Movie/views/all_popular_movie_view.dart';
import '../modules/All_Review/bindings/all_review_binding.dart';
import '../modules/All_Review/views/all_review_view.dart';
import '../modules/All_Similiar/bindings/all_similiar_binding.dart';
import '../modules/All_Similiar/views/all_similiar_view.dart';
import '../modules/All_Top_Movie/bindings/all_top_movie_binding.dart';
import '../modules/All_Top_Movie/views/all_top_movie_view.dart';
import '../modules/All_Upcoming_Movie/bindings/all_upcoming_movie_binding.dart';
import '../modules/All_Upcoming_Movie/views/all_upcoming_movie_view.dart';
import '../modules/DetailPage/bindings/detail_page_binding.dart';
import '../modules/DetailPage/views/detail_page_view.dart';
import '../modules/Login_Page/bindings/login_page_binding.dart';
import '../modules/Login_Page/views/login_page_view.dart';
import '../modules/Register_Page/bindings/register_page_binding.dart';
import '../modules/Register_Page/views/register_page_view.dart';
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
    GetPage(
      name: _Paths.REGISTER_PAGE,
      page: () => const RegisterPageView(),
      binding: RegisterPageBinding(),
    ),
    GetPage(
      name: _Paths.ALL_CAST,
      page: () => const AllCastView(),
      binding: AllCastBinding(),
    ),
    GetPage(
      name: _Paths.ALL_REVIEW,
      page: () => const AllReviewView(),
      binding: AllReviewBinding(),
    ),
    GetPage(
      name: _Paths.ALL_SIMILIAR,
      page: () => const AllSimiliarView(),
      binding: AllSimiliarBinding(),
    ),
    GetPage(
      name: _Paths.ALL_NOW_PLAYING,
      page: () => const AllNowPlayingView(),
      binding: AllNowPlayingBinding(),
    ),
    GetPage(
      name: _Paths.ALL_UPCOMING_MOVIE,
      page: () => const AllUpcomingMovieView(),
      binding: AllUpcomingMovieBinding(),
    ),
    GetPage(
      name: _Paths.ALL_POPULAR_MOVIE,
      page: () => const AllPopularMovieView(),
      binding: AllPopularMovieBinding(),
    ),
    GetPage(
      name: _Paths.ALL_TOP_MOVIE,
      page: () => const AllTopMovieView(),
      binding: AllTopMovieBinding(),
    ),
  ];
}
