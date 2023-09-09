// ignore_for_file: use_build_context_synchronously

import 'package:d_info/d_info.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:money_record/config/api.dart';
import 'package:money_record/config/app_request.dart';
import 'package:money_record/config/session.dart';
import 'package:money_record/data/models/user_model.dart';
import 'package:money_record/presentation/pages/auth/login_page.dart';

class SourceUser {
  // login
  static Future<bool> login(
    String email,
    String password,
  ) async {
    String url = '${Api.user}/login.php';
    Map? responseBody = await AppRequest.post(url, {
      'email': email,
      'password': password,
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      var mapUser = responseBody['data'];
      Session.saveUSer(User.fromJson(mapUser));
    }

    return responseBody['success'];
  }

  // register
  static Future<bool> register(
    BuildContext context,
    String name,
    String email,
    String password,
  ) async {
    String url = '${Api.user}/register.php';
    Map? responseBody = await AppRequest.post(url, {
      'name': name,
      'email': email,
      'password': password,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess(context, "Berhasil Register");
      DInfo.closeDialog(context, actionAfterClose: () {
        Get.off(() => const LoginPage());
      });
    } else {
      if (responseBody['message'] == 'email') {
        DInfo.dialogError(context, "Email Sudah Terdaftar");
        DInfo.closeDialog(context);
      } else {
        DInfo.dialogError(context, "Gagal Register");
      }
    }

    return responseBody['success'];
  }
}
