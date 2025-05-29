import 'package:candy_app/decoration.dart';
import 'package:candy_app/src/controller/transactioncontroller.dart';
import 'package:candy_app/src/home/screen/expenestatistics.dart';
import 'package:candy_app/src/home/screen/statisticspage.dart';

import 'package:candy_app/src/home/widget/statisticsbox.dart';
import 'package:candy_app/src/home/widget/tab.dart';
import 'package:flutter/material.dart';
import 'package:easy_pie_chart/easy_pie_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:candy_app/src/models/transactionmodel.dart';

// Ensure this import is correct
class AllSearchPage extends StatelessWidget {
  AllSearchPage({super.key});

  final List<Color> customChartColors = [
    Colors.blue.shade400, // A nice blue
    Colors.orange.shade400, // A vibrant orange
    Colors.purple.shade400, // A deep purple
    Colors.teal.shade400, // A teal color
    Colors.red.shade400, // A red
    Colors.green.shade400, // A distinct green
    Colors.amber.shade400, // Amber
    Colors.cyan.shade400, // Cyan
    Colors.indigo.shade400, // Indigo
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final TransactionController transactionController =
        Get.put(TransactionController());

    return Scaffold(
      backgroundColor: white,
      bottomNavigationBar: SearchNavBar(
        height: height,
        width: width,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    "Statistics",
                    style: textBlackLargeBold,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.03,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => SearchPage());
                        },
                        child: Container(
                          width: width * 0.27,
                          height: height * 0.05,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: lightBlack),
                              color: white),
                          child: Center(
                            child: Text(
                              "This Month",
                              style: textBlackMini.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => AllSearchPage());
                        },
                        child: Container(
                          width: width * 0.2,
                          height: height * 0.05,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: lightBlack),
                              color: black),
                          child: Center(
                            child: Text(
                              "All",
                              style: textBlackMini.copyWith(
                                  fontSize: 14, color: white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                // --- Single StreamBuilder for ALL income data ---
                StreamBuilder<List<TransactionModel>>(
                  stream: transactionController.getIncomeTransactions(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: height * 0.2),
                          child: Text(
                            'No statistics data available.',
                            style: textBlackMedium,
                          ),
                        ),
                      );
                    }

                    final List<TransactionModel> incomeTransactions =
                        snapshot.data!;

                    // 1. Calculate total income from the fetched list
                    final double totalIncome =
                        incomeTransactions.fold(0.0, (sum, transaction) {
                      return sum + (double.tryParse(transaction.amount) ?? 0.0);
                    });

                    // 2. Aggregate income by title and store associated color
                    Map<String, _AggregatedIncomeData> aggregatedIncomeData =
                        {};
                    int colorIndex = 0;

                    for (var transaction in incomeTransactions) {
                      final double transactionAmount =
                          double.tryParse(transaction.amount) ?? 0.0;

                      Color assignedColor;
                      if (aggregatedIncomeData.containsKey(transaction.title)) {
                        assignedColor =
                            aggregatedIncomeData[transaction.title]!.color;
                      } else {
                        assignedColor = customChartColors[
                            colorIndex % customChartColors.length];
                        colorIndex++;
                      }

                      aggregatedIncomeData.update(
                        transaction.title,
                        (value) => _AggregatedIncomeData(
                          totalAmount: value.totalAmount + transactionAmount,
                          color: assignedColor,
                        ),
                        ifAbsent: () => _AggregatedIncomeData(
                          totalAmount: transactionAmount,
                          color: assignedColor,
                        ),
                      );
                    }

                    // 3. Prepare PieData from aggregated income
                    final List<PieData> pieData = [];
                    aggregatedIncomeData.forEach((title, data) {
                      pieData.add(PieData(
                        value: data.totalAmount,
                        color: data.color,
                        // <--- ADD THIS LINE: Explicitly set title to an empty string
                      ));
                    });

                    // 4. Sort the individual transactions for the StatisticBox list
                    incomeTransactions
                        .sort((a, b) => b.createdAt.compareTo(a.createdAt));

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: EasyPieChart(
                              showValue: false,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Center(
                                  child: Text(
                                    totalIncome.toStringAsFixed(2),
                                    style: textBlackBigBold,
                                  ),
                                ),
                              ),
                              centerStyle: textBlackMediumBold,
                              size: height * 0.25,
                              pieType: PieType.crust,
                              borderWidth: width * 0.075,
                              children: pieData,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: width * 0.99,
                            height: height * 0.075,
                            child: Stack(
                              children: [
                                Container(
                                  child: Center(
                                    child: Text(
                                      "Income",
                                      style: textWhiteLargeBold.copyWith(
                                          fontSize: 14),
                                    ),
                                  ),
                                  width: width * 0.55,
                                  height: height * 0.075,
                                  decoration: BoxDecoration(
                                      color: green,
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                Positioned(
                                  right: width * 0.01,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => ExpensePage());
                                    },
                                    child: Container(
                                      child: Center(
                                        child: Text(
                                          "Expense",
                                          style: textBlackLargeBold.copyWith(
                                              fontSize: 14),
                                        ),
                                      ),
                                      width: width * 0.35,
                                      height: height * 0.075,
                                      decoration: BoxDecoration(
                                          color: lightWhite,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: lightWhite,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        ),
                        // --- Individual income transactions in StatisticBox ---
                        Column(
                          children: incomeTransactions.map((transaction) {
                            final double transactionAmount =
                                double.tryParse(transaction.amount) ?? 0.0;

                            // Find the color for this transaction's title from our aggregated data
                            final Color transactionColor =
                                aggregatedIncomeData[transaction.title]
                                        ?.color ??
                                    green;

                            // Calculate dynamic itemWidth
                            // We need a maximum possible width for a StatisticBox and the total income to scale.
                            // A good maximum could be a percentage of the screen width, e.g., 80% (width * 0.8)
                            // We'll scale the current transaction's amount relative to the total income.
                            // To prevent division by zero if totalIncome is 0, default to a small width.
                            final double maxItemWidth =
                                width * 0.8; // Example max width
                            double dynamicItemWidth;
                            if (totalIncome > 0) {
                              dynamicItemWidth =
                                  (transactionAmount / totalIncome) *
                                      maxItemWidth;
                              // Ensure minimum width to avoid invisible boxes for small amounts
                              if (dynamicItemWidth < (width * 0.1)) {
                                // Set a reasonable minimum width
                                dynamicItemWidth = width * 0.1;
                              }
                            } else {
                              dynamicItemWidth = width *
                                  0.1; // Default small width if no income
                            }

                            return StatisticBox(
                              amountColor:
                                  green, // Dynamic color for amount text
                              width: width,
                              height: height,
                              itemWidth:
                                  dynamicItemWidth, // Dynamic width based on amount
                              amount: transactionAmount.toStringAsFixed(2),
                              color:
                                  transactionColor, // Dynamic color for icon background
                              icon: FontAwesomeIcons.plus,
                              title: transaction.title,
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Helper class to store aggregated income and its assigned color
class _AggregatedIncomeData {
  final double totalAmount;
  final Color color;

  _AggregatedIncomeData({required this.totalAmount, required this.color});
}
