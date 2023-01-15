import 'package:flutter/material.dart';
import 'package:rotten/common/pie_chart.dart';
import 'package:rotten/dummy_data.dart';
import 'package:rotten/modules/finance/show_money_frame.dart';

class FinanceHomePage extends StatefulWidget {
  const FinanceHomePage({Key? key}) : super(key: key);

  @override
  State<FinanceHomePage> createState() => _FinanceHomePageState();
}

class _FinanceHomePageState extends State<FinanceHomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShowMoneyFrame("Income", 12, 100),
        SizedBox(height: 360, child: ChartPie(transactionsSorted)),
      ],
    );
  }
}
