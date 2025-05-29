import 'package:candy_app/decoration.dart';
import 'package:candy_app/src/auth/widget/auth_button.dart';
import 'package:candy_app/src/auth/widget/fields.dart';
import 'package:candy_app/src/controller/transactioncontroller.dart';
import 'package:candy_app/src/home/screen/transactionpage.dart';
import 'package:candy_app/src/home/widget/pickdate.dart';
import 'package:candy_app/src/home/widget/tab.dart';
import 'package:candy_app/src/home/widget/transactionbox.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:candy_app/src/models/transactionmodel.dart';

class AllBudgetPage extends StatelessWidget {
  AllBudgetPage({super.key});

  // Get an instance of your TransactionController
  final TransactionController transactionController =
      Get.put(TransactionController());

  List<DropDownValueModel> typeDropDownItems = [
    const DropDownValueModel(name: 'Expense', value: 'expense'),
    const DropDownValueModel(name: 'Income', value: 'income'),
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: white,
      bottomNavigationBar: BudgetNavBar(
        width: width,
        height: height,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 8.0, top: 8, bottom: 8), // Use const if possible
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    "Transactions", // Changed to plural
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
                          Get.to(() => BudgetPage());
                        },
                        child: Container(
                          width: width * 0.27,
                          height: height * 0.05,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: lightBlack),
                              color: Colors.transparent),
                          child: Center(
                            child: Text(
                              "This Month",
                              style: textBlackMini.copyWith(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => AllBudgetPage());
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
                  height: height * 0.02,
                ),
                StreamBuilder<List<TransactionModel>>(
                  stream: transactionController.getUserTransaction(),
                  // Call your stream method
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
                        padding: EdgeInsets.only(top: height * 0.2),
                        child: Text(
                          'No transactions yet. Add one!',
                          style: textBlackMedium,
                        ),
                      ));
                    }

                    final transactions = snapshot.data!;

                    return Column(
                      children: transactions.map((transaction) {
                        // Determine color and icon based on category (e.g., "income" or "expense")
                        // You'll need to define how categories map to colors/icons
                        Color transactionColor =
                            transaction.category == 'income'
                                ? Colors.green
                                : red; // Assuming 'red' for expense
                        IconData transactionIcon =
                            transaction.category == 'income'
                                ? FontAwesomeIcons.plus
                                : FontAwesomeIcons.minus;

                        return Dismissible(
                            key: ValueKey(transaction.id),
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.endToStart) {
                                await transactionController
                                    .deleteTransaction(transaction.id);
                                return true;
                              } else if (direction ==
                                  DismissDirection.startToEnd) {
                                transactionController
                                    .populateControllersForEdit(transaction);
                                return showModalBottomSheet(
                                  isDismissible: false,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15)),
                                  ),
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: height * 0.8,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: width * 0.075,
                                                  ),
                                                  Icon(
                                                    Icons.edit_document,
                                                    size: 20,
                                                    color: black,
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.15,
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.5,
                                                    child: Text(
                                                      "Edit Transactions ",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style:
                                                          textBlackMediumBold,
                                                    ),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      icon: Icon(
                                                        Icons.close,
                                                        color: black,
                                                      ))
                                                ],
                                              ),
                                            ),
                                            Field_Title(Title: "Title"),
                                            CustomTextField(
                                                hint:
                                                    "Name of the transaction(Food) ",
                                                controller:
                                                    transactionController
                                                        .updateTitleController),
                                            Field_Title(Title: "Amount"),
                                            AppNumField(
                                                hint: "Enter Amount(5000)",
                                                controller: transactionController
                                                    .updateAmountController),
                                            Field_Title(Title: "Category"),
                                            CustomDropDownField(
                                              hint:
                                                  "Enter Category(Expense or Income)",
                                              dropDownList: typeDropDownItems,
                                              controller: transactionController
                                                  .updateCategoryController,
                                            ),
                                            Field_Title(
                                                Title: "Transaction Date"),
                                            pickedDate(
                                              controller: transactionController
                                                  .updateDateController,
                                            ),
                                            Field_Title(Title: "Description"),
                                            CustomTextField(
                                                hint: "Description...",
                                                maxline: 3,
                                                controller: transactionController
                                                    .updateDescriptionController),
                                            SizedBox(
                                              height: height * 0.05,
                                            ),
                                            CustomBtn(
                                                height: height * 0.075,
                                                width: width * 1,
                                                ontap: () {
                                                  transactionController
                                                      .updateCheckTransaction(
                                                          transaction.id);
                                                },
                                                btnColor: primaryColor,
                                                btnstyle: textWhiteMedium,
                                                btnTitle: "Update Transaction"),
                                            SizedBox(
                                              height: height * 0.05,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              return false;
                            },
                            secondaryBackground: Container(
                              color: white,
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                height: height * 0.1,
                                width: width * 0.1,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: lightBlack),
                                child: Icon(
                                  Icons.delete_forever,
                                  color: white,
                                  size: 30,
                                ),
                              ),
                            ),
                            background: Container(
                              color: white,
                              alignment: Alignment.centerLeft,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                height: height * 0.1,
                                width: width * 0.1,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: lightBlack),
                                child: Icon(
                                  Icons.edit,
                                  color: white,
                                  size: 30,
                                ),
                              ),
                            ),
                            child: TransactionBox(
                              height: height,
                              width: width,
                              title: transaction.title,
                              amount: transaction.amount,
                              color: transactionColor,
                              date: transaction.formattedTransactionDate,
                              description: transaction.description ??
                                  'No description', // Handle null description
                              icon: transactionIcon,
                            ));
                      }).toList(),
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

  //  StreamBuilder<List<TransactionModel>>(
  //                 stream: transactionController
  //                     .getUserTransaction(), // Call your stream method
  //                 builder: (context, snapshot) {
  //                   if (snapshot.connectionState == ConnectionState.waiting) {
  //                     // return const Center(child: CircularProgressIndicator());
  //                   }
  //                   if (snapshot.hasError) {
  //                     print("Error fetching transactions: ${snapshot.error}");
  //                     return Center(child: Text('Error: ${snapshot.error}'));
  //                   }
  //                   if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //                     return Center(
  //                         child: Padding(
  //                       padding: EdgeInsets.only(top: height * 0.2),
  //                       child: Text(
  //                         'No transactions yet. Add one!',
  //                         style: textBlackMedium,
  //                       ),
  //                     ));
  //                   }

  //                   final transactions = snapshot.data!;

  //                   return Column(
  //                     children: transactions.map((transaction) {
  //                       // Determine color and icon based on category (e.g., "income" or "expense")
  //                       // You'll need to define how categories map to colors/icons
  //                       Color transactionColor =
  //                           transaction.category == 'income'
  //                               ? Colors.green
  //                               : red; // Assuming 'red' for expense
  //                       IconData transactionIcon =
  //                           transaction.category == 'income'
  //                               ? FontAwesomeIcons.plus
  //                               : FontAwesomeIcons.minus;

  //                       return TransactionBox(
  //                         height: height,
  //                         width: width,
  //                         title: transaction.title,
  //                         amount: transaction.amount,
  //                         color: transactionColor,
  //                         date: transaction.formattedTransactionDate,
  //                         description: transaction.description ??
  //                             'No description', // Handle null description
  //                         icon: transactionIcon,
  //                       );
  //                     }).toList(),
  //                   );
  //                 },
  //               ),
