import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CountryFlag extends StatelessWidget {
  const CountryFlag({
    super.key,
    required this.countryCode,
    this.width = 40,
    this.onErrorLoadingFlag,
  });

  final String countryCode;
  final double width;
  final VoidCallback? onErrorLoadingFlag;

  static const kFlagAspectRatio = (3 / 2);

  @override
  Widget build(BuildContext context) {
    final closestAvailableSize = [20, 40, 80, 160, 320, 640, 1280, 2560]
            .where((x) => x > width)
            .firstOrNull ??
        80;

    return SizedBox(
      width: width,
      child: AspectRatio(
        aspectRatio: kFlagAspectRatio,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
          ),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImage(
            imageUrl:
                'https://flagcdn.com/w$closestAvailableSize/${countryCode.toLowerCase()}.jpg',
            fit: BoxFit.cover,
            errorListener: (value) => onErrorLoadingFlag?.call(),
            placeholder: (context, url) => _CountryFlagPlaceholder(
              width: width,
            ),
            errorWidget: (context, url, error) => _CountryFlagPlaceholder(
              width: width,
            ),
          ),
        ),
      ),
    );
  }
}

class _CountryFlagPlaceholder extends StatelessWidget {
  const _CountryFlagPlaceholder({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: Colors.black12,
    );
  }
}
