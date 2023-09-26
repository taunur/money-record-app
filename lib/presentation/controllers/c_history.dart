// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:money_record/data/models/history_model.dart';
import 'package:money_record/data/sources/source_history.dart';

class CHistory extends GetxController {
  final _loading = false.obs;
  bool get loading => _loading.value;

  final _list = <HistoryModel>[].obs;
  List<HistoryModel> get list => _list.value;

  getList(idUser) async {
    _loading.value = true;
    update();
    _list.value = await SourceHistory.history(idUser);
    update();

    Future.delayed(const Duration(milliseconds: 900), () {
      _loading.value = false;
      update();
    });
  }

  search(idUser, date) async {
    _loading.value = true;
    update();
    _list.value = await SourceHistory.historySearch(idUser, date);
    update();

    Future.delayed(const Duration(milliseconds: 900), () {
      _loading.value = false;
      update();
    });
  }
}
