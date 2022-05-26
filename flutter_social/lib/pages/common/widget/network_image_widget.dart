import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ENetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final double radius;
  final BoxFit fit;
  final ImageWidgetBuilder? imageBuilder;
  final Color? placeholderColor;

  /// Widget displayed while the target [imageUrl] is loading.
  final PlaceholderWidgetBuilder? placeholder;

  /// Widget displayed while the target [imageUrl] is loading.
  final ProgressIndicatorBuilder? progressIndicatorBuilder;

  /// Widget displayed while the target [imageUrl] failed loading.
  final LoadingErrorWidgetBuilder? errorWidget;

  const ENetworkImage(
      {Key? key,
      this.imageUrl,
      this.width,
      this.height,
      this.fit = BoxFit.cover,
      this.radius = 0.0,
      this.imageBuilder,
      this.placeholder,
      this.placeholderColor,
      this.progressIndicatorBuilder,
      this.errorWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(this.radius),
      child: _buildContent(context),
    );
  }

  _buildContent(BuildContext context) {
    if (this.imageUrl == null || this.imageUrl!.isEmpty) {
      if (this.placeholder != null) {
        return this.placeholder!(context, "");
      }

      return _buildIdle();
    }
    return CachedNetworkImage(
      imageUrl: this.imageUrl!,
      width: this.width,
      height: this.height,
      fit: this.fit,
      imageBuilder: this.imageBuilder,
      placeholder: this.placeholder ?? (context, url) => _buildIdle(),
      errorWidget: this.errorWidget ?? (context, url, error) => _buildIdle(),
      progressIndicatorBuilder: this.progressIndicatorBuilder,
    );
  }

  Widget _buildIdle() {
    return Container(
      color: placeholderColor ?? Colors.grey[100],
      width: this.width,
      height: this.height,
    );
  }
}
