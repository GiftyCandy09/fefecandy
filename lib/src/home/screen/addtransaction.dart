import 'package:candy_app/decoration.dart';
import 'package:candy_app/src/auth/widget/auth_button.dart';
import 'package:candy_app/src/auth/widget/bars.dart';
import 'package:candy_app/src/auth/widget/fields.dart';
import 'package:candy_app/src/controller/transactioncontroller.dart';
import 'package:candy_app/src/home/widget/pickdate.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewTransactionPage extends StatefulWidget {
  NewTransactionPage({super.key});

  @override
  State<NewTransactionPage> createState() => _NewTransactionPageState();
}

//Add Transactions page
class _NewTransactionPageState extends State<NewTransactionPage> {
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
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(height * 0.5),
            child: SafeArea(
                child: Row(children: [
              BasicAppBar(
                title: "Add Transaction",
                width: width,
                height: height,
              ),
            ]))),
        backgroundColor: white,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Field_Title(Title: "Title"),
                          CustomTextField(
                              hint: "Name of the transaction(Food) ",
                              controller:
                                  transactionController.titleController),
                          Field_Title(Title: "Amount"),
                          AppNumField(
                              hint: "Enter Amount(5000)",
                              controller:
                                  transactionController.amountController),
                          Field_Title(Title: "Category"),
                          CustomDropDownField(
                            hint: "Enter Category(Expense or Income)",
                            dropDownList: typeDropDownItems,
                            controller:
                                transactionController.categoryController,
                          ),
                          Field_Title(Title: "Date"),
                          pickedDate(
                            controller: transactionController.dateController,
                          ),
                          Field_Title(Title: "Description"),
                          CustomTextField(
                              hint: "Description...",
                              maxline: 3,
                              controller:
                                  transactionController.descriptionController),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          CustomBtn(
                              height: height * 0.075,
                              width: width * 1,
                              ontap: () {
                                transactionController.checkTransaction();
                              },
                              btnColor: primaryColor,
                              btnstyle: textWhiteMedium,
                              btnTitle: "Add Transaction")
                        ])))));
  }
}
