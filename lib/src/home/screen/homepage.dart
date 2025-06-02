import 'package:candy_app/decoration.dart';
import 'package:candy_app/src/controller/usercontroller.dart';
import 'package:candy_app/src/controller/transactioncontroller.dart';
import 'package:candy_app/src/home/screen/addtransaction.dart';
import 'package:candy_app/src/home/screen/transactionpage.dart';
import 'package:candy_app/src/home/widget/message.dart';
import 'package:candy_app/src/home/widget/moneybox.dart';
import 'package:candy_app/src/home/widget/tab.dart';
import 'package:candy_app/src/home/widget/transactionbox.dart';
import 'package:easy_pie_chart/easy_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:candy_app/src/models/transactionmodel.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;



    final TransactionController transactionController =
        Get.put(TransactionController());

    return Scaffold(
      backgroundColor: white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        shape: const OvalBorder(), // Use const for better performance
        onPressed: () {
          Get.to(() => NewTransactionPage());
        },
        elevation: 0,
        child: Icon(
          FontAwesomeIcons.plus,
          color: white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: HomeNavBar(width: width, height: height),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height * 0.58,
                // height: height * 0.7,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: lightWhite,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      // Make Padding const
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text(
                        "Overview",
                        style: textBlackLargeBold,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomGreeting(
                        width: width,
                        height: height,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: height * 0.28,
                        //  height: height * 0.4,
                        width: width * 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Monthly Account Balance",
                                    style: textGreyMedium,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Container(
                                width: width * 0.5,
                                child: Align(
                                  alignment: Alignment.center,
                                  // --- StreamBuilder for Account Balance ---
                                  child: StreamBuilder<double>(
                                    stream: transactionController
                                        .getAccountBalance(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        // return const CircularProgressIndicator();
                                      }
                                      if (snapshot.hasError) {
                                        print(
                                            "Error balance: ${snapshot.error}");
                                        return Text(
                                          "Error", // Or a more descriptive error
                                          style: textBlackBigBold.copyWith(
                                              color: red),
                                        );
                                      }
                                      final balance = snapshot.data ??
                                          0.0; // Default to 0.0
                                      return Row(
                                        mainAxisSize: MainAxisSize
                                            .min, // To keep content compact
                                        children: [
                                          Padding(
                                            // Make Padding const
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text("FCFA",
                                                style: textBlackMediumBold
                                                    .copyWith(
                                                        color: balance >= 0
                                                            ? green
                                                            : red)),
                                          ),
                                          Text(
                                            balance.toStringAsFixed(
                                                2), // Format to 2 decimal places
                                            style: textBlackBigBold.copyWith(
                                              color: balance >= 0
                                                  ? green
                                                  : red, // Green for positive, red for negative
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // --- StreamBuilder for Income ---
                                    StreamBuilder<double>(
                                      stream: transactionController
                                          .getTotalMonthlyIncome(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          // return const CircularProgressIndicator();
                                        }
                                        final income = snapshot.data ?? 0.0;
                                        return MoneyBox(
                                          height: height,
                                          width: width,
                                          title: "Income",
                                          amount: income
                                              .toStringAsFixed(2), // Format
                                          color: green,
                                          icon: FontAwesomeIcons
                                              .coins, // Or arrowUp
                                        );
                                      },
                                    ),
                                    // --- StreamBuilder for Expenses ---
                                    StreamBuilder<double>(
                                      stream: transactionController
                                          .getTotalMonthlyExpenses(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          // return const CircularProgressIndicator();
                                        }
                                        final expenses = snapshot.data ?? 0.0;
                                        return MoneyBox(
                                          height: height,
                                          width: width,
                                          title: "Expenses",
                                          amount: expenses
                                              .toStringAsFixed(2), // Format
                                          color: red,
                                          icon: FontAwesomeIcons
                                              .coins, // Or arrowDown
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(color: lightWhite),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Transactions",
                      style: textBlackMediumBold,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => BudgetPage());
                      },
                      child: Text(
                        "View all",
                        style: textGreyMedium,
                      ),
                    )
                  ],
                ),
              ),
              // StreamBuilder for recent transactions (already implemented, but ensure it's here)
              StreamBuilder<List<TransactionModel>>(
                // stream: transactionController.getMonthlyExpenseTransactions(),
                stream: transactionController.getUserTransaction(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    print("Error fetching transactions: ${snapshot.error}");
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: height * 0.1),
                      child: Text(
                        'No transactions yet. Add one!',
                        style: textBlackMedium,
                      ),
                    ));
                  }

                  final transactions = snapshot.data!;

                  // It's good practice to limit the number of recent transactions displayed here
                  // For example, show only the top 5
                  final recentTransactions =
                      transactions.take(5).toList(); // Show top 5

                  return Column(
                    children: recentTransactions.map((transaction) {
                      Color transactionColor =
                          transaction.category == 'income' ? Colors.green : red;
                      IconData transactionIcon =
                          transaction.category == 'income'
                              ? FontAwesomeIcons.arrowUp
                              : FontAwesomeIcons.arrowDown;

                      return TransactionBox1(
                        height: height,
                        width: width,
                        type: transaction
                            .displayCategory, // Use the displayCategory getter
                        amount: transaction.amount, // Still a String from model
                        color: transactionColor,
                        date: transaction
                            .formattedCreationTime, // Use formattedCreationTime

                        icon: transactionIcon,
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
