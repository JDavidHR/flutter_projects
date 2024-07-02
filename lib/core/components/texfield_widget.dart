import 'package:flutter/material.dart';
import 'package:flutter_application/core/colors.dart';

class TextfieldWidget extends StatelessWidget {
  /// El tipo de información para la cual optimizar el control de entrada de texto
  final TextInputType? keyboardType;

  /// Un controlador para un campo de texto editable.
  final TextEditingController? controller;

  /// Firma para validar un campo de formulario.
  /// Devuelve una cadena de error para mostrar si la entrada es inválida, o null.
  final FormFieldValidator<String> onValidator;

  /// Una acción que el usuario ha solicitado que realice el control de entrada de texto
  final TextInputAction? textInputAction;

  /// Un ícono que aparece después de la parte editable del campo de texto
  final Widget? suffixIcon;

  /// Un ícono que aparece antes de la parte editable del campo de texto
  final Widget? prefixIcon;

  /// Texto de sugerencia, se muestra dentro del contenedor del campo
  final String? hint;

  /// Pasa [true] para ocultar los datos ingresados en el campo de entrada
  /// El valor predeterminado es false, lo que hace que sea visible
  /// A menudo usado para el campo de contraseña
  final bool obscureText;

  /// Habilitar/deshabilitar la entrada de valores en el campo de entrada
  /// El valor predeterminado es true, lo que lo habilita.
  final bool enabled;

  /// Firma para las devoluciones de llamada que informan que un valor subyacente ha cambiado.
  final ValueChanged<String> onChanged;

  /// Estilo de texto del campo de entrada
  final TextStyle? style;

  /// Un ícono para mostrar antes del campo de entrada y fuera de la decoración
  final Widget? icon;

  /// El color del [icon]
  final Color? iconColor;

  /// Texto que proporciona contexto sobre el valor de [InputDecorator.child],
  /// como cómo se utilizará el valor.
  final String? helperText;

  /// El estilo a usar para el [helperText]
  final TextStyle? helperStyle;

  /// El número máximo de líneas que puede ocupar el [helperText].
  final int? helperMaxLines;

  /// La dirección a usar para el [hintText]
  final TextDirection? hintTextDirection;

  /// El número máximo de líneas que puede ocupar el [hint].
  final int? hintMaxLines;

  /// Texto que aparece debajo de [InputDecorator.child] y el borde.
  final String? errorText;

  /// El estilo a usar para el [errorText].
  final TextStyle? errorStyle;

  /// El número máximo de líneas que puede ocupar el [errorText].
  final int? errorMaxLines;

  /// Define **cómo** debería comportarse la etiqueta flotante.
  /// Cuando [FloatingLabelBehavior.auto] la etiqueta flotará hacia la parte superior solo cuando
  /// el campo esté enfocado o tenga algún contenido de texto, de lo contrario aparecerá
  /// en el campo en lugar del contenido.
  /// Cuando [FloatingLabelBehavior.always] la etiqueta siempre flotará en la parte superior
  /// del campo sobre el contenido.
  /// Cuando [FloatingLabelBehavior.never] la etiqueta siempre aparecerá en un campo vacío
  /// en lugar del contenido.
  final FloatingLabelBehavior? floatingLabelBehavior;

  /// Define **dónde** debería mostrarse la etiqueta flotante.
  final FloatingLabelAlignment? floatingLabelAlignment;

  /// Prefijo de texto opcional para colocar en la línea antes de la entrada.
  final String? prefixText;

  /// El estilo a usar para el [prefixText].
  final TextStyle? prefixStyle;

  /// Color opcional del prefixIcon
  final Color? prefixIconColor;

  /// Sufijo de texto opcional para colocar en la línea antes de la entrada.
  final String? suffixText;

  /// El estilo a usar para el [suffixStyle].
  final TextStyle? suffixStyle;

  /// Color opcional del suffixIcon
  final Color? suffixIconColor;

  /// Texto de etiqueta para el campo de texto delineado
  final String? labelText;

  /// También puedes pasar una tematización personalizada a esta clase que sea diferente de
  /// la tematización a nivel de la aplicación.
  final InputDecorationTheme? theme;

  /// El número máximo de caracteres (clusters de grafemas Unicode) permitidos en
  /// el campo de texto.
  final int? maxLength;

  /// Alinear el texto horizontalmente.
  final TextAlign textAlign;

  /// La alineación vertical del texto dentro de un cuadro de entrada.
  final TextAlignVertical? textAlignVertical;

  /// Color del input, por defecto usa el color de [ThemeColors.onSurface].
  final Color? background;

  /// Margen interno del input, por defecto esta en 8 px.
  final EdgeInsets? contendPadding;

  const TextfieldWidget({
    super.key,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.keyboardType,
    this.controller,
    required this.onValidator,
    this.textInputAction,
    this.suffixIcon,
    this.prefixIcon,
    this.hint,
    this.obscureText = false,
    this.enabled = true,
    required this.onChanged,
    this.style,
    this.icon,
    this.iconColor,
    this.errorStyle,
    this.errorMaxLines,
    this.errorText,
    this.floatingLabelAlignment,
    this.floatingLabelBehavior,
    this.helperMaxLines,
    this.helperStyle,
    this.helperText,
    this.hintMaxLines,
    this.hintTextDirection,
    this.suffixIconColor,
    this.prefixIconColor,
    this.prefixStyle,
    this.prefixText,
    this.suffixStyle,
    this.suffixText,
    this.labelText,
    this.theme,
    this.maxLength,
    this.background,
    this.contendPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 312,
      height: 56,
      padding: contendPadding ?? const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: background ?? ThemeColors.onSurface,
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        textAlign: textAlign,
        textAlignVertical: textAlignVertical,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: labelText,
          hintStyle: theme?.hintStyle,
          contentPadding: theme?.contentPadding,
          errorStyle: theme?.errorStyle,
          floatingLabelStyle: theme?.floatingLabelStyle,
          labelStyle: theme?.labelStyle,
          fillColor: theme?.fillColor,
          border: theme?.border ?? InputBorder.none,
          focusedBorder: theme?.focusedBorder,
          enabledBorder: theme?.enabledBorder,
          icon: icon,
          iconColor: theme?.iconColor,
          errorMaxLines: theme?.errorMaxLines,
          errorText: errorText,
          floatingLabelAlignment: theme?.floatingLabelAlignment,
          floatingLabelBehavior: theme?.floatingLabelBehavior,
          helperMaxLines: theme?.helperMaxLines,
          helperStyle: theme?.helperStyle,
          helperText: helperText,
          hintMaxLines: hintMaxLines,
          hintTextDirection: hintTextDirection,
          suffixIconColor: theme?.suffixIconColor,
          prefixIconColor: theme?.prefixIconColor,
          prefixStyle: theme?.prefixStyle,
          prefixText: prefixText,
          suffixStyle: theme?.suffixStyle,
          suffixText: suffixText,
          filled: theme?.filled,
        ),
        validator: onValidator,
        onChanged: onChanged,
        enabled: enabled,
        obscureText: obscureText,
        controller: controller,
        style: style,
        textInputAction: textInputAction,
        maxLength: maxLength,
      ),
    );
  }
}
