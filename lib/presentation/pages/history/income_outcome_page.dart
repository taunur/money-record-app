import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/config/app_format.dart';
import 'package:money_record/data/models/history_model.dart';
import 'package:money_record/presentation/controllers/c_income_outcome.dart';
import 'package:money_record/presentation/controllers/c_user.dart';

class IncomeOutcomePage extends StatefulWidget {
  const IncomeOutcomePage({super.key, required this.type});
  final String type;

  @override
  State<IncomeOutcomePage> createState() => _IncomeOutcomePageState();
}

class _IncomeOutcomePageState extends State<IncomeOutcomePage> {
  final cInOut = Get.put(CIncomeOutcome());
  final cUser = Get.put(CUser());
  final controllerSearch = TextEditingController();
  refresh() {
    cInOut.getList(cUser.data.idUser, widget.type);
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
      body: GetBuilder<CIncomeOutcome>(builder: (_) {
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
                    16, index == 0 ? 16 : 8, 16, index == 0 ? 16 : 8),
                child: Row(
                  children: [
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
                    PopupMenuButton(
                      itemBuilder: (context) => [],
                      onSelected: (value) {},
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
          Text(widget.type),
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
                      cInOut.search(
                        cUser.data.idUser,
                        widget.type,
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
