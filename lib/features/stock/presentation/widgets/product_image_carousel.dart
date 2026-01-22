import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:warehousesys/core/theme/app_theme.dart';

class ProductImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final double height;
  final bool autoPlay;

  const ProductImageCarousel({
    super.key,
    required this.imageUrls,
    this.height = 300,
    this.autoPlay = false,
  });

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  final String baseUrl = 'http://127.0.0.1:8080';

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) {
      return Container(
        height: widget.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_not_supported_outlined, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 8),
            Text("Нет изображений", style: TextStyle(color: Colors.grey.shade500)),
          ],
        ),
      );
    }

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
                height: widget.height,
                viewportFraction: 1.0,
                enableInfiniteScroll: widget.imageUrls.length > 1,
                autoPlay: widget.autoPlay && widget.imageUrls.length > 1,
                onPageChanged: (index, reason) {
                  setState(() => _currentIndex = index);
                },
              ),
              items: widget.imageUrls.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderColor),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        '$baseUrl$url',
                        fit: BoxFit.contain,
                        errorBuilder: (ctx, err, stack) => const Center(
                          child: Icon(Icons.broken_image, color: Colors.red),
                        ),
                        loadingBuilder: (ctx, child, progress) {
                          if (progress == null) return child;
                          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                        },
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            if (widget.imageUrls.length > 1)
              Positioned(
                left: 16,
                child: _ArrowButton(
                  icon: Icons.arrow_back_ios_rounded,
                  onTap: () => _controller.previousPage(),
                ),
              ),

            if (widget.imageUrls.length > 1)
              Positioned(
                right: 16,
                child: _ArrowButton(
                  icon: Icons.arrow_forward_ios_rounded,
                  onTap: () => _controller.nextPage(),
                ),
              ),
          ],
        ),
        
        if (widget.imageUrls.length > 1) ...[
          const SizedBox(height: 12),
          AnimatedSmoothIndicator(
            activeIndex: _currentIndex,
            count: widget.imageUrls.length,
            onDotClicked: (index) => _controller.animateToPage(index),
            effect: const WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              spacing: 8,
              activeDotColor: primaryColor,
              dotColor: Color(0xFFE5E7EB),
            ),
          ),
        ],
      ],
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ArrowButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.8),
      shape: const CircleBorder(),
      elevation: 2,
      shadowColor: Colors.black26,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        hoverColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            size: 20,
            color: textDarkColor,
          ),
        ),
      ),
    );
  }
}