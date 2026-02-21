import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ViewSmartImage extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final BoxFit fit;

  /// Optional tint color
  final Color? color;

  /// Optional placeholder & error widgets
  final Widget? placeholder;
  final Widget? errorWidget;

  const ViewSmartImage({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
    this.color,
    this.placeholder,
    this.errorWidget,
  });

  bool get isNetwork => path.startsWith('http');
  bool get isSvg => path.toLowerCase().endsWith('.svg');

  Widget _defaultPlaceholder() =>
      SizedBox(height: height, width: width);

  Widget _defaultError() => SizedBox(
    height: height,
    width: width,
    child: const Icon(Icons.broken_image),
  );

  @override
  Widget build(BuildContext context) {
    final themePrimary = Theme.of(context).colorScheme.primary;

    /// ---------- SVG NETWORK ----------
    if (isSvg && isNetwork) {
      return SvgPicture.network(
        path,
        height: height,
        width: width,
        fit: fit,
        placeholderBuilder: (_) => placeholder ?? _defaultPlaceholder(),
        theme: color == null
            ? SvgTheme(currentColor: themePrimary)
            : null,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      );
    }

    /// ---------- SVG ASSET ----------
    if (isSvg && !isNetwork) {
      return SvgPicture.asset(
        path,
        height: height,
        width: width,
        fit: fit,
        theme: color == null
            ? SvgTheme(currentColor: themePrimary)
            : null,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      );
    }

    /// ---------- IMAGE NETWORK ----------
    if (!isSvg && isNetwork) {
      return CachedNetworkImage(
        imageUrl: path,
        height: height,
        width: width,
        fit: fit,
        placeholder: (_, __) => placeholder ?? _defaultPlaceholder(),
        errorWidget: (_, __, ___) => errorWidget ?? _defaultError(),
        color: color,
        colorBlendMode: color != null ? BlendMode.srcIn : null,
      );
    }

    /// ---------- IMAGE ASSET ----------
    return Image.asset(
      path,
      height: height,
      width: width,
      fit: fit,
      color: color,
      colorBlendMode: color != null ? BlendMode.srcIn : null,
      errorBuilder: (_, __, ___) => errorWidget ?? _defaultError(),
    );
  }
}