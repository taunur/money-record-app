import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/config/app_format.dart';

class AddHistoryPage extends StatelessWidget {
  const AddHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Tambah Baru'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Tanggal'),
          Row(
            children: [
              const Text(
                "2022/01/02",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DView.spaceWidth(),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.date_range),
                label: const Text("Pilih"),
              ),
            ],
          ),
          DView.spaceHeight(),
          const Text(
            'Tipe',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          DView.spaceHeight(8),
          DropdownButtonFormField(
            value: 'pemasukan',
            items: ['pemasukan', 'pengeluaran'].map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e),
              );
            }).toList(),
            onChanged: (value) {},
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          DView.spaceHeight(),
          DInput(
            controller: TextEditingController(),
            hint: 'Jualan',
            title: 'Sumber/Object Pengeluaran',
          ),
          DView.spaceHeight(),
          DInput(
            controller: TextEditingController(),
            hint: '30000',
            title: 'Harga',
            inputType: TextInputType.number,
          ),
          DView.spaceHeight(),
          Center(
            child: Container(
              height: 4,
              width: 80,
              decoration: BoxDecoration(
                color: AppColor.bg,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          DView.spaceHeight(),
          const Text(
            'Items',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          DView.spaceHeight(8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: Wrap(
              children: [
                Chip(
                  label: const Text("Sumber"),
                  deleteIcon: const Icon(Icons.clear),
                  onDeleted: () {},
                )
              ],
            ),
          ),
          DView.spaceHeight(),
          Row(
            children: [
              const Text(
                "Total: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DView.spaceWidth(4),
              Text(
                AppFormat.currency('300000'),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColor.primary,
                    ),
              ),
            ],
          ),
          DView.spaceHeight(30),
          Material(
            color: AppColor.primary,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
