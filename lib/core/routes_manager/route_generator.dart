import 'package:flutter/material.dart';
import 'package:ecommerce/core/routes_manager/routes.dart';
import 'package:ecommerce/features/auth/presentation/screens/login/login_screen.dart';
import 'package:ecommerce/features/auth/presentation/screens/register/register_screen.dart';

import '../../features/cart/screens/cart_screen.dart';
import '../../features/main_layout/main_layout.dart';
import '../../features/product_details/presentation/screen/product_details.dart';
import '../../features/products_screen/presentation/screens/products_screen.dart';


class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.cartRoute:
        return MaterialPageRoute(builder: (_) =>  CartScreen());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) =>  MainLayout());

      case Routes.productsScreenRoute:
        return MaterialPageRoute(builder: (_) =>  ProductsScreen());



      case Routes.signInRoute:
        return MaterialPageRoute(builder: (_) =>  LoginScreen());


      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('No Route Found'),
        ),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}