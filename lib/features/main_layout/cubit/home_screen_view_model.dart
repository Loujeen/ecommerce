import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/features/main_layout/cubit/home_screen_states.dart';
import 'package:ecommerce/features/products_screen/presentation/screens/products_screen.dart';

import '../favourite/presentation/favourite_screen.dart';
import '../home/presentation/home_tab.dart';
import '../profile_tab/presentation/profile_tab.dart';

class HomeScreenViewModel extends Cubit<HomeScreenStates> {
  HomeScreenViewModel() : super(HomeScreenInitialState());

  //todo: hold data - handle logic
  int currentIndex = 0;
  List<Widget> tabs = [
    HomeTab(),
    ProductsScreen(),
    FavouriteScreen(),
    const ProfileTab(),
  ];

  void changeSelectedIndex(int newIndex) {
    emit(HomeScreenInitialState());
    currentIndex = newIndex;
    emit(ChangeSelectedIndexState());
  }
}