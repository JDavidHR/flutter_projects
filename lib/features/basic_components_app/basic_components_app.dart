import 'package:flutter/material.dart';
import 'package:flutter_application/core/colors.dart';
import 'package:flutter_application/core/components/button_widget.dart';
import 'package:flutter_application/core/components/preview_widget.dart';
import 'package:flutter_application/core/components/texfield_widget.dart';

class BasicComponentsApp extends StatefulWidget {
  const BasicComponentsApp({
    super.key,
  });

  @override
  State<BasicComponentsApp> createState() => _BasicComponentsAppState();
}

class _BasicComponentsAppState extends State<BasicComponentsApp>
    with MaterialStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.surface,
      body: Center(
        child: Wrap(
          runSpacing: 16,
          spacing: 16,
          children: [
            /// Preview (image/icon/svg).
            const PreviewWidget(
              iconData: Icons.image,
              iconColor: Colors.deepPurple,
            ),

            /// Input de email.
            TextfieldWidget(
              keyboardType: TextInputType.emailAddress,
              hint: 'Email',
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.email_outlined),
              onValidator: (String? value) {
                return null;
              },
              onChanged: (String value) {},
            ),

            /// Input de Password.
            TextfieldWidget(
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              hint: 'Password',
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.security_outlined),
              onValidator: (String? value) {
                return null;
              },
              onChanged: (String value) {},
            ),

            /// Boton.
            ButtonWidget(
              text: 'Press Me',
              icon: Icons.touch_app_outlined,
              onPressed: () {},
              backgroundColor: ThemeColors.secondary,
              textColor: ThemeColors.onSecondary,
              iconColor: ThemeColors.onSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
