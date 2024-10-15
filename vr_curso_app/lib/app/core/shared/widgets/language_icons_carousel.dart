import 'package:flutter/material.dart';

class LanguageIconsCarousel extends StatefulWidget {
  final List<String> iconUrls; 

  const LanguageIconsCarousel({super.key, required this.iconUrls});

  @override
  _LanguageIconsCarouselState createState() => _LanguageIconsCarouselState();
}

class _LanguageIconsCarouselState extends State<LanguageIconsCarousel> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.iconUrls.length,
      itemBuilder: (context, index) {
        return Image.network(
          widget.iconUrls[index],
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error); // Exibe um ícone de erro caso a imagem não carregue
          },
        );
      },
    );
  }
}