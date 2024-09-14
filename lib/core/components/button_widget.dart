import 'package:flutter/material.dart';
import 'package:flutter_application/core/colors.dart';

class ButtonWidget extends StatelessWidget {
  /// Texto del boton.
  final String text;

  /// Color del texto del boton.
  final Color? textColor;

  /// Color del boton.
  final Color? backgroundColor;

  /// Funcion a ejecutar el boton al ser precionado.
  final void Function() onPressed;

  /// Icono a ser usado en el boton, puede ser null.
  final IconData? icon;

  /// Color del icono de l boton.
  final Color? iconColor;

  /// Tamaño del icono del boton.
  final double? iconSize;

  /// Radio del boton, por defecto es 8 px.
  final double borderRadius;

  /// Estilo del texto del boton.
  final TextStyle? textStyle;

  /// Padding del contenido del boton.
  final EdgeInsets? contendPadding;

  const ButtonWidget({
    super.key,
    required this.text,
    this.textColor,
    this.backgroundColor,
    required this.onPressed,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.borderRadius = 8.0,
    this.textStyle,
    this.contendPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? ThemeColors.primary,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: contendPadding ?? const EdgeInsets.all(8),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: iconColor ?? ThemeColors.onPrimary,
                size: iconSize ?? 24.0,
              ),
            if (icon != null) const SizedBox(width: 8),
            Text(
              text,
              style: textStyle ??
                  TextStyle(
                    color: textColor ?? ThemeColors.onPrimary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
