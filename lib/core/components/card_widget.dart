import 'package:flutter/material.dart';
import 'package:flutter_application/core/colors.dart';

class CustomCard extends StatelessWidget {
  /// Un widget opcional que se muestra en la parte superior de la tarjeta.
  final Widget? header;

  /// Un widget opcional que se muestra en el cuerpo de la tarjeta.
  final Widget? content;

  /// Un widget opcional que se muestra en la parte inferior de la tarjeta.
  final Widget? footer;

  /// El color de fondo de la tarjeta.
  final Color? backgroundColor;

  /// La elevación de la tarjeta, que controla la sombra.
  final double elevation;

  /// El relleno interno de la tarjeta.
  final EdgeInsetsGeometry padding;

  /// El margen externo de la tarjeta.
  final EdgeInsetsGeometry margin;

  /// El radio de las esquinas de la tarjeta.
  final BorderRadiusGeometry borderRadius;

  /// El color de la sombra de la tarjeta.
  final Color? shadowColor;

  /// La frontera de la tarjeta.
  final BorderSide? border;

  const CustomCard({
    super.key,
    this.header,
    this.content,
    this.footer,
    this.backgroundColor,
    this.elevation = 1.0,
    this.padding = const EdgeInsets.all(8.0),
    this.margin = const EdgeInsets.all(8.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.shadowColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor ?? ThemeColors.surface,
      elevation: elevation,
      margin: margin,
      shadowColor: shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: border ?? BorderSide.none,
      ),
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (header != null) header!,
            if (content != null) content!,
            if (footer != null) footer!,
          ],
        ),
      ),
    );
  }
}
