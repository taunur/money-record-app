import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_record/config/app_assets.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/data/sources/source_user.dart';
import 'package:money_record/presentation/pages/auth/register_page.dart';
import 'package:money_record/presentation/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false; // Add this variable

  login() async {
    if (mounted && formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Show loading indicator
      });

      bool success = await SourceUser.login(
        controllerEmail.text,
        controllerPassword.text,
      );

      setState(() {
        isLoading = false; // Hide loading indicator
      });

      if (mounted) {
        if (success) {
          DInfo.dialogSuccess(context, "Berhasil Login");
          DInfo.closeDialog(context, actionAfterClose: () {
            Get.off(() => const HomePage());
          });
        } else {
          DInfo.dialogError(context, "Gagal Login");
          DInfo.closeDialog(context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DView.nothing(),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          Image.asset(
                            AppAsset.logo,
                            height: 120,
                          ),
                          DView.spaceHeight(40),
                          TextFormField(
                            controller: controllerEmail,
                            validator: (value) =>
                                value == "" ? "Jangan Kosong" : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: AppColor.primary.withOpacity(0.5),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Email',
                              hintStyle: const TextStyle(color: Colors.white),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                            ),
                          ),
                          DView.spaceHeight(),
                          TextFormField(
                            controller: controllerPassword,
                            obscureText: true,
                            validator: (value) =>
                                value == "" ? "Jangan Kosong" : null,
                            style: const TextStyle(color: Colors.white),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              fillColor: AppColor.primary.withOpacity(0.5),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Password',
                              hintStyle: const TextStyle(color: Colors.white),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                            ),
                          ),
                          DView.spaceHeight(36),
                          Material(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30),
                              onTap: () => login(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 42,
                                  vertical: 16,
                                ),
                                child: isLoading
                                    ? SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              height: 24.0,
                                              width: 24.0,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            DView.spaceWidth(8),
                                            const Text(
                                              "Login",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : const Text(
                                        "Login",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Belum punya akun? ",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const RegisterPage());
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
