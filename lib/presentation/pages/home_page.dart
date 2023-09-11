import 'package:d_chart/commons/config_render.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/ordinal/bar.dart';
import 'package:d_chart/ordinal/pie.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_record/config/app_assets.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/config/session.dart';
import 'package:money_record/presentation/controllers/c_user.dart';
import 'package:money_record/presentation/pages/auth/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cUser = Get.put(CUser());

  @override
  Widget build(BuildContext context) {
    // barchart
    List<OrdinalData> ordinalList = [
      OrdinalData(domain: 'Sen', measure: 3),
      OrdinalData(domain: 'Sel', measure: 5),
      OrdinalData(domain: 'Rab', measure: 9),
      OrdinalData(domain: 'Kam', measure: 6.5),
      OrdinalData(domain: 'Jum', measure: 6.5),
      OrdinalData(domain: 'Sab', measure: 6.5),
      OrdinalData(domain: 'Min', measure: 6.5),
    ];
    final ordinalGroup = [
      OrdinalGroup(
        id: '1',
        data: ordinalList,
      ),
    ];
    // piechart
    List<OrdinalData> ordinalDataList = [
      OrdinalData(domain: 'Mon', measure: 3, color: AppColor.primary),
      OrdinalData(domain: 'Tue', measure: 5, color: AppColor.chart),
    ];

    return Scaffold(
        endDrawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                margin: const EdgeInsets.only(bottom: 0),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(AppAsset.profile),
                        DView.spaceWidth(4),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () {
                                  return Text(
                                    cUser.data.name ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  );
                                },
                              ),
                              Obx(
                                () {
                                  return Text(
                                    cUser.data.email ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Material(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        onTap: () {
                          Session.clearUser();
                          Get.off(() => const LoginPage());
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.add),
                horizontalTitleGap: 0,
                title: const Text("Tambah Baru"),
                trailing: const Icon(Icons.navigate_next),
              ),
              const Divider(height: 1),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.south_west),
                horizontalTitleGap: 0,
                title: const Text("Pemasukan"),
                trailing: const Icon(Icons.navigate_next),
              ),
              const Divider(height: 1),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.north_east),
                horizontalTitleGap: 0,
                title: const Text("Pengeluaran"),
                trailing: const Icon(Icons.navigate_next),
              ),
              const Divider(height: 1),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.history),
                horizontalTitleGap: 0,
                title: const Text("Riwayat"),
                trailing: const Icon(Icons.navigate_next),
              ),
              const Divider(height: 1),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
              child: Row(
                children: [
                  Image.asset(AppAsset.profile),
                  DView.spaceWidth(4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hi,",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Obx(
                          () {
                            return Text(
                              cUser.data.name ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Builder(builder: (ctx) {
                    return Material(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColor.chart,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4),
                        onTap: () {
                          Scaffold.of(ctx).openEndDrawer();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(6),
                          child: Icon(
                            Icons.menu,
                            color: AppColor.primary,
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                children: [
                  Text(
                    "Pengeluaran Hari Ini",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  DView.spaceHeight(),
                  cardToday(context),
                  Container(
                    height: 8,
                    width: 80,
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 3,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.bg,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  Text(
                    "Pengeluaran Minggu Ini",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  DView.spaceHeight(),
                  weeklyBarChart(ordinalGroup),
                  DView.spaceHeight(),
                  Text(
                    "Perbandingan Bulan Ini",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  monthlyPieChart(context, ordinalDataList),
                ],
              ),
            ),
          ],
        ));
  }

  Row monthlyPieChart(BuildContext context, List<OrdinalData> ordinalDataList) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              children: [
                DChartPieO(
                  animate: true,
                  data: ordinalDataList,
                  configRenderPie: const ConfigRenderPie(
                    arcWidth: 30,
                  ),
                ),
                Center(
                  child: Text(
                    "60%",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColor.primary,
                        ),
                  ),
                )
              ],
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16,
                  width: 16,
                  color: AppColor.primary,
                ),
                DView.spaceWidth(8),
                const Text("Pemasukan")
              ],
            ),
            DView.spaceHeight(8),
            Row(
              children: [
                Container(
                  height: 16,
                  width: 16,
                  color: AppColor.bg,
                ),
                DView.spaceWidth(8),
                const Text("Pengeluaran")
              ],
            ),
            DView.spaceHeight(20),
            const Text('Pemasukan'),
            const Text("lebih besar 20%"),
            const Text("dari Pengeluaran"),
            DView.spaceHeight(20),
            const Text("Atau setara:"),
            const Text(
              "Rp. 20.000, 00",
              style: TextStyle(
                color: AppColor.primary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )
      ],
    );
  }

  AspectRatio weeklyBarChart(List<OrdinalGroup> ordinalGroup) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: DChartBarO(
        animate: true,
        fillColor: (group, ordinalData, index) {
          return AppColor.primary;
        },
        groupList: ordinalGroup,
      ),
    );
  }

  Material cardToday(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 4,
      color: AppColor.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
            child: Text(
              'Rp. 500. 000',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColor.secondary,
                  ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 30),
            child: Text(
              '+ 20% dibanding kemarin',
              style: TextStyle(color: AppColor.bg),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 0, 16),
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Selengkapnya",
                  style: TextStyle(
                    color: AppColor.primary,
                  ),
                ),
                Icon(
                  Icons.navigate_next_rounded,
                  color: AppColor.primary,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
