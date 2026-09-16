import 'package:flutter/material.dart';
import 'package:madperfume/shared/widgets/animated_circular_loader.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: AnimatedCircularLoader());
  }
}
