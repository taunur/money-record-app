import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_record/config/session.dart';
import 'package:money_record/presentation/pages/auth/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Session.clearUser();
                Get.off(
                  () => const LoginPage(),
                );
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
