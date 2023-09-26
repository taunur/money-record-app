import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/config/app_format.dart';
import 'package:money_record/data/models/history_model.dart';
import 'package:money_record/data/sources/source_history.dart';
import 'package:money_record/presentation/controllers/c_history.dart';
import 'package:money_record/presentation/controllers/c_user.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final cHistory = Get.put(CHistory());
  final cUser = Get.put(CUser());
  final controllerSearch = TextEditingController();

  refresh() {
    cHistory.getList(cUser.data.idUser);
  }

  void delete(String idHistory) async {
    bool? yes = await DInfo.dialogConfirmation(
      context,
      "Hapus",
      "Yakin untuk menghapus ?",
      textNo: 'Batal',
      textYes: 'Ya',
    );
    if (yes!) {
      bool success = await SourceHistory.delete(idHistory);
      if (success) {
        refresh();
      }
    }
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: GetBuilder<CHistory>(builder: (_) {
        if (_.loading) return DView.loadingCircle();
        if (_.list.isEmpty) return DView.empty('Kosong');
        return RefreshIndicator(
          onRefresh: () async => refresh(),
          child: ListView.builder(
            itemCount: _.list.length,
            itemBuilder: (context, index) {
              HistoryModel history = _.list[index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.fromLTRB(
                  16,
                  index == 0 ? 16 : 8,
                  16,
                  index == _.list.length - 1 ? 16 : 8,
                ),
                child: Row(
                  children: [
                    DView.spaceWidth(),
                    history.type == "Pemasukan"
                        ? const Icon(
                            Icons.south_west,
                            color: Colors.green,
                          )
                        : history.type == "Pengeluaran"
                            ? const Icon(
                                Icons.north_east,
                                color: Colors.red,
                              )
                            : const Text("None"),
                    DView.spaceWidth(),
                    Text(
                      AppFormat.date(history.date!),
                      style: const TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        AppFormat.currency(history.total!),
                        style: const TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    IconButton(
                      onPressed: () => delete(history.idHistory!),
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }

  AppBar appBar() {
    return AppBar(
      titleSpacing: 0,
      title: Row(
        children: [
          const Text("Riwayat"),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              height: 40,
              child: TextField(
                controller: controllerSearch,
                onTap: () async {
                  DateTime? result = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023, 01, 01),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );
                  if (result != null) {
                    controllerSearch.text =
                        DateFormat("yyyy-MM-dd").format(result);
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColor.chart.withOpacity(0.5),
                  suffixIcon: IconButton(
                    onPressed: () {
                      cHistory.search(
                        cUser.data.idUser,
                        controllerSearch.text,
                      );
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                  isCollapsed: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  hintText: "2023-20-09",
                  hintStyle: const TextStyle(color: Colors.white),
                ),
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
