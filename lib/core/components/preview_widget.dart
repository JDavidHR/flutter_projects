import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PreviewWidget extends StatelessWidget {
  /// URL de la imagen a mostrar.
  final String? imageUrl;

  /// Icono a mostrarse.
  final IconData? iconData;

  /// SVG a mostrarse.
  final String? svgAsset;

  /// Tamaño del componente, afecta tanto el ancho como al largo, por defecto
  /// es 100 para ambos casos.
  final double size;

  /// Color del icono.
  final Color? iconColor;
  final BoxFit fit;

  const PreviewWidget({
    super.key,
    this.imageUrl,
    this.iconData,
    this.svgAsset,
    this.size = 100.0,
    this.iconColor,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey[200], // Fondo gris claro por defecto
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    /// Se valida si se esta mostrando la preview con una imagen, icono o svg.
    ///
    /// Si recibe imagen.
    if (imageUrl != null) {
      return Image.network(
        imageUrl!,
        fit: fit,
      );
    }

    /// Si recibe SVG.
    else if (svgAsset != null) {
      return SvgPicture.asset(
        svgAsset!,
        fit: fit,
      );
    }

    /// Si recibe icono.
    else if (iconData != null) {
      return Center(
        child: Icon(
          iconData,
          size: size * 0.5, // Tamaño del ícono relativo al contenedor
          color: iconColor ?? Colors.black,
        ),
      );
    }

    /// Sino recibe nada.
    else {
      return Container(
        color: Colors.grey[400], // Color de fondo si no hay contenido
      );
    }
  }
}
