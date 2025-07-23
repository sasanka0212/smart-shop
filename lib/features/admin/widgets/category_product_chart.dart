import 'package:amazon/features/admin/models/sales.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CategoryProductChart extends StatefulWidget {
  final List<Sales> chartData;
  const CategoryProductChart({super.key, required this.chartData});

  @override
  State<CategoryProductChart> createState() => _CategoryProductChartState();
}

class _CategoryProductChartState extends State<CategoryProductChart> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBackgroundColor: Colors.transparent,
      margin: EdgeInsets.symmetric(vertical: 10 * 2),
      borderColor: Colors.transparent,
      borderWidth: 0,
      plotAreaBorderWidth: 0,
      enableSideBySideSeriesPlacement: false,
      primaryXAxis: CategoryAxis(isVisible: true),
      title: ChartTitle(text: 'Product Sales Analysis', textStyle: TextStyle(fontSize: 12),),
      series: <CartesianSeries>[
        ColumnSeries<Sales, String>(
          borderRadius: BorderRadius.circular(20),
          dataSource: widget.chartData,
          width: 0.5,
          color: Colors.blue,
          xValueMapper: (Sales data, _) => data.label,
          yValueMapper: (Sales data, _) => data.earnings,
        ),
      ],
    );
  }
}
