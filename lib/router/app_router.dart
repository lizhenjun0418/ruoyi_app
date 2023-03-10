import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ruoyi_app/pages/edit/index.dart';
import 'package:ruoyi_app/pages/error/404.dart';
import 'package:ruoyi_app/pages/login/login.dart';
import 'package:ruoyi_app/pages/modify/modify_password.dart';
import 'package:ruoyi_app/pages/page_index.dart';
import 'package:ruoyi_app/pages/persion/persional_page.dart';
import 'package:ruoyi_app/pages/setting/index.dart';
import 'package:ruoyi_app/router/app_router_constant.dart';

/// 路由
class AppRouterPage {
  static final errorPage =
      GetPage(name: AppRouterConstant.error_404, page: () => const ErrorPage());

  static final routers = [
    GetPage(name: AppRouterConstant.home, page: () => const PageIndex()),
    GetPage(name: AppRouterConstant.login, page: () => const LoginPage()),
    GetPage(name: AppRouterConstant.error_404, page: () => const ErrorPage()),
    GetPage(
        name: AppRouterConstant.persional, page: () => const PersionalPage()),
    GetPage(name: AppRouterConstant.settings, page: () => const SettingPage()),
    GetPage(
        name: AppRouterConstant.modifyPassword,
        page: () => const ModifyPaswordPage()),
    GetPage(name: AppRouterConstant.editUser, page: () => const EditUserPage())
  ];

  /// 路由
  static final Map<String, WidgetBuilder> routerMaps = {
    AppRouterConstant.home: (context) => const PageIndex(),
    AppRouterConstant.login: (context) => const LoginPage(),
    AppRouterConstant.error_404: (context) => const ErrorPage(),
    AppRouterConstant.persional: (context) => const PersionalPage(),
    AppRouterConstant.settings: (context) => const SettingPage(),
    AppRouterConstant.modifyPassword: (context) => const ModifyPaswordPage(),
    AppRouterConstant.editUser: (context) => const EditUserPage()
  };

  ///路由拦截
  static Route onGenerateRoute(RouteSettings settings) {
    final String? name = settings.name;
    var pageContentBuilder = routerMaps[name];

    /// 如果路由表中未定义，跳转到未定义路由页面
    pageContentBuilder ??= (context) => const ErrorPage();

    if (!GetStorage().hasData("token")) {
      pageContentBuilder = (context) => const LoginPage();
    }

    // 构建动态的route
    final route = MaterialPageRoute(
      builder: pageContentBuilder,
      settings: settings,
    );
    return route;
  }
}
