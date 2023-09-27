// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_record/data/models/history_model.dart';
import 'package:money_record/data/sources/source_history.dart';

class CUpdateHistory extends GetxController {
  final _date = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  String get date => _date.value;
  setDate(n) => _date.value = n;

  // type
  final _type = 'Pemasukan'.obs;
  String get type => _type.value;
  setType(n) => _type.value = n;

  final _items = [].obs;
  List get items => _items.value;
  addItem(n) {
    _items.value.add(n);
    count();
  }

  deleteItem(i) {
    _items.value.removeAt(i);
    count();
  }

  // total
  final _total = 0.0.obs;
  double get total => _total.value;
  seTotal(n) => _total.value = n;

  count() {
    double newTotal = items
        .map((e) => double.parse(e['price'])) // Convert 'price' to double
        .toList()
        .fold(0.0, (previousValue, element) => previousValue + element);
    seTotal(newTotal);
    update(); // Update the _total value
  }

  init(idUser, date) async {
    HistoryModel? history = await SourceHistory.whereDate(idUser, date);
    if (history != null) {
      setDate(history.date);
      setType(history.type);
      _items.value = jsonDecode(history.details!);
      count();
    }
  }
}
