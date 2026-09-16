import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:get/get.dart';

class ShellState extends Equatable {
  const ShellState(this.tabIndex);

  final int tabIndex;

  @override
  List<Object?> get props => [tabIndex];
}

class ShellCubit extends Cubit<ShellState> {
  ShellCubit() : super(const ShellState(0)) {
    instance = this;
  }

  static ShellCubit? instance;

  final pageController = PageController();

  void setTabFromPage(int index) {
    if (state.tabIndex != index) {
      emit(ShellState(index));
    }
  }

  void setTab(int index) {
    emit(ShellState(index));
    void move() {
      if (pageController.hasClients) {
        pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 420),
          curve: Curves.easeOutCubic,
        );
      }
    }

    move();
    if (!pageController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) => move());
    }
  }

  static Future<void> returnToMain({int tab = 0}) async {
    instance?.setTab(tab);
    final nav = Get.key.currentState;
    if (nav != null && nav.canPop()) {
      nav.popUntil((route) {
        return route.settings.name == AppRoutes.main || route.isFirst;
      });
    }
    if (Get.currentRoute != AppRoutes.main) {
      Get.offAllNamed(AppRoutes.main);
    }
  }

  @override
  Future<void> close() {
    if (identical(instance, this)) {
      instance = null;
    }
    pageController.dispose();
    return super.close();
  }
}
