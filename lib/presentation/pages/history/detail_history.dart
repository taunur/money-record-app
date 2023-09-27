import 'dart:convert';

import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/config/app_format.dart';
import 'package:money_record/presentation/controllers/history/c_detail_history.dart';

class DetailHistoryPage extends StatefulWidget {
  const DetailHistoryPage(
      {super.key,
      required this.idUser,
      required this.date,
      required this.type});
  final String idUser;
  final String date;
  final String type;

  @override
  State<DetailHistoryPage> createState() => _DetailHistoryPageState();
}

class _DetailHistoryPageState extends State<DetailHistoryPage> {
  final cDetailHistory = Get.put(CDetailHistory());

  @override
  void initState() {
    cDetailHistory.getData(widget.idUser, widget.date, widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Obx(
          () {
            if (cDetailHistory.data.date == null) return DView.nothing();
            return Row(
              children: [
                Expanded(
                  child: Text(
                    AppFormat.date(cDetailHistory.data.date!),
                  ),
                ),
                cDetailHistory.data.type == "Pemasukan"
                    ? Icon(Icons.south_west, color: Colors.green[100])
                    : Icon(Icons.north_east, color: Colors.red[100]),
                DView.spaceWidth(),
              ],
            );
          },
        ),
      ),
      body: GetBuilder<CDetailHistory>(builder: (_) {
        if (_.data.date == null) {
          String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
          if (widget.date == today && widget.type == "Pengeluaran") {
            return DView.empty("Belum ada Pengeluaran");
          }
          return DView.nothing();
        }
        List details = jsonDecode(_.data.details!);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                "Total",
                style: TextStyle(
                  color: AppColor.bg,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
            ),
            DView.spaceHeight(8),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Text(
                AppFormat.currency(_.data.total!),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColor.primary,
                    ),
              ),
            ),
            DView.spaceHeight(20),
            Center(
              child: Container(
                height: 5,
                width: 100,
                decoration: BoxDecoration(
                  color: AppColor.bg,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            DView.spaceHeight(20),
            Expanded(
              child: ListView.separated(
                itemCount: details.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                itemBuilder: (context, index) {
                  Map item = details[index];
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text('${index + 1}.'),
                        DView.spaceWidth(8),
                        Expanded(
                          child: Text(
                            item["name"],
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Text(
                          AppFormat.currency(item["price"]),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
