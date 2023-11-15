import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skywatch/presentation/components/conditional_builder.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';

class SkeletonLoader extends StatelessWidget {
  SkeletonLoader({
    super.key,
    this.axis = Axis.vertical,
    required this.items,
    this.color,
    this.glow = true,
    this.autoFill = true,
  }) : assert(items.isNotEmpty, 'Must provide at least 1 item');

  final Axis axis;
  final List<SkeletonLoaderItem> items;
  final Color? color;
  final bool autoFill;
  final bool glow;

  @override
  Widget build(BuildContext context) {
    final lastItem = items.where((x) => !x.spacer).last;
    final lastSpacer =
        items.where((x) => x.spacer).lastOrNull ?? SkeletonLoaderItem.spacer();

    return ConditionalBuilder(
      condition: glow,
      builder: (context, child) {
        return Shimmer.fromColors(
          baseColor: context.colorScheme.surfaceVariant,
          highlightColor: context.colorScheme.surfaceVariant.withOpacity(0.8),
          child: child,
        );
      },
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return autoFill && index > items.length - 1
              ? Flex(
                  direction: axis,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    lastItem,
                    lastSpacer,
                  ],
                )
              : items[index];
        },
        itemCount: autoFill ? null : items.length,
        scrollDirection: axis,
      ),
    );
  }
}

class SkeletonLoaderItem extends StatelessWidget {
  const SkeletonLoaderItem._({
    this.width = 20,
    this.height = 20,
    this.borderRadius,
    this.spacer = false,
    this.expanded = false,
    this.items = const [],
  });

  final double? width;
  final double? height;
  final bool spacer;
  final bool expanded;
  final BorderRadius? borderRadius;
  final List<SkeletonLoaderItem> items;

  factory SkeletonLoaderItem.square([double size = 100]) {
    return SkeletonLoaderItem._(
      width: size,
      height: size,
    );
  }

  factory SkeletonLoaderItem.circle([double size = 100]) {
    return SkeletonLoaderItem._(
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(size),
    );
  }

  factory SkeletonLoaderItem.rectangle([double height = 100]) {
    return SkeletonLoaderItem._(
      height: height,
      expanded: true,
    );
  }

  factory SkeletonLoaderItem.spacer([double size = 20]) {
    return SkeletonLoaderItem._(
      spacer: true,
      width: size,
      height: size,
    );
  }

  factory SkeletonLoaderItem.chip([double height = 60]) {
    return SkeletonLoaderItem._(
      height: height,
      expanded: false,
      borderRadius: BorderRadius.circular(height),
    );
  }

  factory SkeletonLoaderItem.row(List<SkeletonLoaderItem> items) {
    return SkeletonLoaderItem._(
      items: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (items.isNotEmpty) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: items
            .map(
              (item) => ConditionalBuilder(
                condition: item.expanded,
                builder: (BuildContext context, Widget child) {
                  return Expanded(child: child);
                },
                child: item,
              ),
            )
            .toList(),
      );
    }

    if (spacer) {
      return Gap(width ?? height ?? 20);
    }

    return Container(
      width: expanded ? double.infinity : width,
      height: height,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceVariant,
        borderRadius: borderRadius ?? BorderRadius.circular(5),
      ),
    );
  }
}
