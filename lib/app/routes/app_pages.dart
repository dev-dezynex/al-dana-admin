import 'package:get/get.dart';

import '../modules/add_banner/bindings/add_banner_binding.dart';
import '../modules/add_banner/views/add_banner_view.dart';
import '../modules/add_branch/bindings/add_branch_binding.dart';
import '../modules/add_branch/views/add_branch_view.dart';
import '../modules/add_brand/bindings/add_brand_binding.dart';
import '../modules/add_brand/views/add_brand_view.dart';
import '../modules/add_car_model/bindings/add_car_model_binding.dart';
import '../modules/add_car_model/views/add_car_model_view.dart';
import '../modules/add_category/bindings/add_category_binding.dart';
import '../modules/add_category/views/add_category_view.dart';
import '../modules/add_color_page/bindings/add_color_page_binding.dart';
import '../modules/add_color_page/views/add_color_page_view.dart';
import '../modules/add_coupon/bindings/add_coupon_binding.dart';
import '../modules/add_coupon/views/add_coupon_view.dart';
import '../modules/add_package/bindings/add_package_binding.dart';
import '../modules/add_package/views/add_package_view.dart';
import '../modules/add_service/bindings/add_service_binding.dart';
import '../modules/add_service/views/add_service_view.dart';
import '../modules/add_service_mode/bindings/add_service_mode_binding.dart';
import '../modules/add_service_mode/views/add_service_mode_view.dart';
import '../modules/add_spare/bindings/add_spare_binding.dart';
import '../modules/add_spare/views/add_spare_view.dart';
import '../modules/add_spare_category/bindings/add_spare_category_binding.dart';
import '../modules/add_spare_category/views/add_spare_category_view.dart';
import '../modules/add_users/bindings/add_users_binding.dart';
import '../modules/add_users/views/add_users_view.dart';
import '../modules/add_variant/bindings/add_variant_binding.dart';
import '../modules/add_variant/views/add_variant_view.dart';
import '../modules/add_work/bindings/add_work_binding.dart';
import '../modules/add_work/views/add_work_view.dart';
import '../modules/add_year_page/bindings/add_year_page_binding.dart';
import '../modules/add_year_page/views/add_year_page_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/banner/bindings/banner_binding.dart';
import '../modules/banner/views/banner_view.dart';
import '../modules/branch_list/bindings/branch_list_binding.dart';
import '../modules/branch_list/views/branch_list_view.dart';
import '../modules/car_model/bindings/car_model_binding.dart';
import '../modules/car_model/views/car_model_view.dart';
import '../modules/category_list/bindings/category_list_binding.dart';
import '../modules/category_list/views/category_list_view.dart';
import '../modules/coupon/bindings/coupon_binding.dart';
import '../modules/coupon/views/coupon_view.dart';
import '../modules/custom_price/bindings/custom_price_binding.dart';
import '../modules/custom_price/views/custom_price_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/map_page/bindings/map_page_binding.dart';
import '../modules/map_page/views/map_page_view.dart';
import '../modules/package_list/bindings/package_list_binding.dart';
import '../modules/package_list/views/package_list_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/reward/bindings/reward_binding.dart';
import '../modules/reward/views/reward_view.dart';
import '../modules/service_list/bindings/service_list_binding.dart';
import '../modules/service_list/views/service_list_view.dart';
import '../modules/service_mode/bindings/service_mode_binding.dart';
import '../modules/service_mode/views/service_mode_view.dart';
import '../modules/spare/bindings/spare_binding.dart';
import '../modules/spare/views/spare_view.dart';
import '../modules/spare_category/bindings/spare_category_binding.dart';
import '../modules/spare_category/views/spare_category_view.dart';
import '../modules/splash_page/bindings/splash_page_binding.dart';
import '../modules/splash_page/views/splash_page_view.dart';
import '../modules/users/bindings/users_binding.dart';
import '../modules/users/views/users_view.dart';
import '../modules/variant/bindings/variant_binding.dart';
import '../modules/variant/views/variant_view.dart';
import '../modules/vehicle/bindings/vehicle_binding.dart';
import '../modules/vehicle/views/vehicle_view.dart';
import '../modules/work/bindings/work_binding.dart';
import '../modules/work/views/work_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_PAGE,
      page: () => SplashPageView(),
      binding: SplashPageBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.BRANCH_LIST,
      page: () => const BranchListView(),
      binding: BranchListBinding(),
    ),
    GetPage(
      name: _Paths.USERS,
      page: () => const UsersView(),
      binding: UsersBinding(),
    ),
    GetPage(
      name: _Paths.SPARE_CATEGORY,
      page: () => const SpareCategoryView(),
      binding: SpareCategoryBinding(),
    ),
    GetPage(
      name: _Paths.WORK,
      page: () => const WorkView(),
      binding: WorkBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_LIST,
      page: () => const CategoryListView(),
      binding: CategoryListBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_LIST,
      page: () => const ServiceListView(),
      binding: ServiceListBinding(),
    ),
    GetPage(
      name: _Paths.PACKAGE_LIST,
      page: () => const PackageListView(),
      binding: PackageListBinding(),
    ),
    GetPage(
      name: _Paths.ADD_BRANCH,
      page: () => AddBranchView(),
      binding: AddBranchBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CATEGORY,
      page: () => AddCategoryView(),
      binding: AddCategoryBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PACKAGE,
      page: () => AddPackageView(),
      binding: AddPackageBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SERVICE,
      page: () => AddServiceView(),
      binding: AddServiceBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SPARE_CATEGORY,
      page: () => AddSpareCategoryView(),
      binding: AddSpareCategoryBinding(),
    ),
    GetPage(
      name: _Paths.SPARE,
      page: () => const SpareView(),
      binding: SpareBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SPARE,
      page: () => AddSpareView(),
      binding: AddSpareBinding(),
    ),
    GetPage(
      name: _Paths.ADD_USERS,
      page: () => AddUsersView(),
      binding: AddUsersBinding(),
    ),
    GetPage(
      name: _Paths.ADD_WORK,
      page: () => AddWorkView(),
      binding: AddWorkBinding(),
    ),
    GetPage(
      name: _Paths.VEHICLE,
      page: () => const VehicleView(),
      binding: VehicleBinding(),
    ),
    GetPage(
      name: _Paths.ADD_BRAND,
      page: () => AddBrandView(),
      binding: AddBrandBinding(),
    ),
    GetPage(
      name: _Paths.ADD_COLOR_PAGE,
      page: () => const AddColorPageView(),
      binding: AddColorPageBinding(),
    ),
    GetPage(
      name: _Paths.ADD_YEAR_PAGE,
      page: () => const AddYearPageView(),
      binding: AddYearPageBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_MODE,
      page: () => const ServiceModeView(),
      binding: ServiceModeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SERVICE_MODE,
      page: () => AddServiceModeView(),
      binding: AddServiceModeBinding(),
    ),
    
    GetPage(
      name: _Paths.VARIANT,
      page: () => const VariantView(),
      binding: VariantBinding(),
    ),
    GetPage(
      name: _Paths.ADD_VARIANT,
      page: () => AddVariantView(),
      binding: AddVariantBinding(),
    ),
    GetPage(
      name: _Paths.CAR_MODEL,
      page: () => const CarModelView(),
      binding: CarModelBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CAR_MODEL,
      page: () => AddCarModelView(),
      binding: AddCarModelBinding(),
    ),
    GetPage(
      name: _Paths.BANNER,
      page: () => const BannerView(),
      binding: BannerBinding(),
    ),
    GetPage(
      name: _Paths.ADD_BANNER,
      page: () => AddBannerView(),
      binding: AddBannerBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOM_PRICE,
      page: () => CustomPriceView(),
      binding: CustomPriceBinding(),
    ),
    GetPage(
      name: _Paths.MAP_PAGE,
      page: () => MapPageView(),
      binding: MapPageBinding(),
    ),
    GetPage(
      name: _Paths.COUPON,
      page: () => const CouponView(),
      binding: CouponBinding(),
    ),
    GetPage(
      name: _Paths.ADD_COUPON,
      page: () => AddCouponView(),
      binding: AddCouponBinding(),
    ),
    GetPage(
      name: _Paths.REWARD,
      page: () => RewardView(),
      binding: RewardBinding(),
    ),
    
  ];
}
