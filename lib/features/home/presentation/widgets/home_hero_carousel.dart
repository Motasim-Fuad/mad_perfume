import 'dart:async';

import 'package:flutter/material.dart';
import 'package:madperfume/core/models/catalog_models.dart';
import 'package:madperfume/features/home/presentation/widgets/home_hero_banner.dart';

class HomeHeroCarousel extends StatefulWidget {
  const HomeHeroCarousel({
    super.key,
    required this.products,
    required this.onOpen,
  });

  final List<ProductModel> products;
  final ValueChanged<int> onOpen;

  @override
  State<HomeHeroCarousel> createState() => _HomeHeroCarouselState();
}

class _HomeHeroCarouselState extends State<HomeHeroCarousel> {
  late final PageController _controller;
  Timer? _timer;
  var _page = 0;

  List<ProductModel> get _items => widget.products;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _start();
  }

  void _start() {
    _timer?.cancel();
    if (_items.length < 2) {
      return;
    }
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || !_controller.hasClients) {
        return;
      }
      final next = _page + 1;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 780),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) {
      return const SizedBox.shrink();
    }
    final loop = _items.length * 200;
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: SizedBox(
        height: 240,
        width: double.infinity,
        child: PageView.builder(
          controller: _controller,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) => _page = index,
          itemCount: loop,
          itemBuilder: (context, index) {
            final product = _items[index % _items.length];
            return HomeHeroBanner(
              product: product,
              onTap: () => widget.onOpen(product.id),
            );
          },
        ),
      ),
    );
  }
}
