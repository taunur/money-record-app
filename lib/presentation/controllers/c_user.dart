import 'package:get/get.dart';
import 'package:money_record/data/models/user_model.dart';

class CUser extends GetxController {
  final _data = User().obs;
  User get data => _data.value;
  setData(n) => _data.value = n;
}
