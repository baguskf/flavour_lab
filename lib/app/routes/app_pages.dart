import 'package:get/get.dart';

import '../modules/bookmark/bindings/bookmark_binding.dart';
import '../modules/bookmark/views/bookmark_view.dart';
import '../modules/bottomnav/bindings/bottomnav_binding.dart';
import '../modules/bottomnav/views/bottmnav_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/detail/bindings/detail_binding.dart';
import '../modules/detail/views/detail_view.dart';
import '../modules/edit_info/bindings/edit_info_binding.dart';
import '../modules/edit_info/views/edit_info_view.dart';
import '../modules/edit_photo/bindings/edit_photo_binding.dart';
import '../modules/edit_photo/views/edit_photo_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/search_page/bindings/search_page_binding.dart';
import '../modules/search_page/views/search_page_view.dart';
import '../modules/see_all/bindings/see_all_binding.dart';
import '../modules/see_all/views/see_all_view.dart';
import '../modules/video_tutorial/bindings/video_tutorial_binding.dart';
import '../modules/video_tutorial/views/video_tutorial_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.BOTTOM_NAV;

  static final routes = [
    GetPage(
      name: _Paths.BOTTOM_NAV,
      page: () => BottmnavView(),
      binding: BottomNavBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.HOME_VIEW,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITE,
      page: () => const Bookmarkview(),
      binding: BookmarkBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_INFO,
      page: () => const EditInfoView(),
      binding: EditInfoBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PHOTO,
      page: () => const EditPhotoView(),
      binding: EditPhotoBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.SEE_ALL,
      page: () => const SeeAllView(),
      binding: SeeAllBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => const DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_TUTORIAL,
      page: () => const VideoTutorialView(),
      binding: VideoTutorialBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_PAGE,
      page: () => const SearchPageView(),
      binding: SearchPageBinding(),
    ),
  ];
}
