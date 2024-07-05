import 'package:flutter/material.dart';
import 'package:flutter_application/features/login/login.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Aquí hice lo mismo que en la anterior page, redirigí nuevamente
            /// al login usando el mismo método, en esta caso push.
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_back),
            ),
            const Text("Entraste"),
          ],
        ),
      ),
    );
  }
}
