import 'dart:async';
import 'package:flutter/material.dart';

class BannerSlider extends StatefulWidget {
  final List<String> images; 
  final Duration autoScrollDuration; 
  const BannerSlider({
    super.key,
    required this.images,
    this.autoScrollDuration = const Duration(seconds: 3), 
  });

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  late PageController _pageController;
  double _currentPage = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.95);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0.0;
      });
    });

    _timer = Timer.periodic(widget.autoScrollDuration, (timer) {
      if (!mounted) return;
      int nextPage = (_pageController.page?.round() ?? 0) + 1;
      if (nextPage >= widget.images.length) {
        nextPage = 0; 
      }
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.17;

    return SizedBox(
      height: height,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          final scale = (1 - ((_currentPage - index).abs() * 0.2)).clamp(
            0.8,
            1.0,
          );

          return TweenAnimationBuilder(
            tween: Tween<double>(begin: scale, end: scale),
            duration: const Duration(milliseconds: 250),
            builder: (context, value, child) {
              return Transform.scale(scale: value, child: child);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(widget.images[index]),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
