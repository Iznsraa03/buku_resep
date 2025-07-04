import 'package:get/get.dart';

import '../modules/category/bindings/category_binding.dart';
import '../modules/category/views/category_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/detail_resep/bindings/detail_resep_binding.dart';
import '../modules/detail_resep/views/detail_resep_view.dart';
import '../modules/form_tambah_resep/bindings/form_tambah_resep_binding.dart';
import '../modules/form_tambah_resep/views/form_tambah_resep_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/regist/bindings/regist_binding.dart';
import '../modules/regist/views/regist_view.dart';
import '../modules/tambah_resep/bindings/tambah_resep_binding.dart';
import '../modules/tambah_resep/views/tambah_resep_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => const HomeView(),
          binding: HomeBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGIST,
      page: () => const RegistView(),
      binding: RegistBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => const CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_RESEP,
      page: () => DetailResepView(),
      binding: DetailResepBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_RESEP,
      page: () => const TambahResepView(),
      binding: TambahResepBinding(),
    ),
    GetPage(
      name: _Paths.FORM_TAMBAH_RESEP,
      page: () => const FormTambahResepView(),
      binding: FormTambahResepBinding(),
    ),
  ];
}
