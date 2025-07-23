import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/admin/models/sales.dart';
import 'package:amazon/features/admin/services/admin_services.dart';
import 'package:amazon/features/admin/widgets/category_product_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts;

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? Loader()
        : SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Column(
              children: [
                Text(
                  'Total Earnings: Rs $totalSales',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 250,
                  decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: CategoryProductChart(
                    chartData: earnings!,
                  ),
                ),
              ],
            ),
        );
  }
}
