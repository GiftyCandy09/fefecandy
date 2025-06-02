import 'package:candy_app/decoration.dart';
import 'package:candy_app/src/controller/authcontroller.dart';
import 'package:candy_app/src/auth/widget/snackbar.dart';
import 'package:candy_app/src/home/screen/homepage.dart';

import 'package:candy_app/src/models/transactionmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart ' as Rx;

//Transaction Controller
class TransactionController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late TextEditingController titleController,
      amountController,
      descriptionController,
      dateController;
  late TextEditingController updateTitleController,
      updateAmountController,
      updateDescriptionController,
      updateDateController;
  late SingleValueDropDownController categoryController;
  late SingleValueDropDownController updateCategoryController;
  final AuthController authController = Get.find<AuthController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    titleController = TextEditingController();
    amountController = TextEditingController();
    descriptionController = TextEditingController();
    dateController = TextEditingController();
    updateTitleController = TextEditingController();
    updateAmountController = TextEditingController();
    updateDescriptionController = TextEditingController();
    updateDateController = TextEditingController();
    categoryController = SingleValueDropDownController();
    updateCategoryController = SingleValueDropDownController();
  }

  void populateControllersForEdit(TransactionModel transaction) {
    updateTitleController.text = transaction.title;
    updateAmountController.text = transaction.amount;
    updateDateController = TextEditingController();
    updateCategoryController = SingleValueDropDownController();
    updateDescriptionController.text = transaction.description ?? '';
  }

  clearUpdateController() {
    updateAmountController.clear();
    updateTitleController.clear();
    updateDateController.clear();
    updateCategoryController.clearDropDown();
    updateDescriptionController.clear();
  }

  checkTransaction() async {
    if (titleController.text.isEmpty) {
      // Simplified length check
      CustomSnackBar("Error", "Title is required", "error");
    } else if (amountController.text.isEmpty) {
      // Simplified length check
      CustomSnackBar("Error", "Amount is required", "error");
    } else if (categoryController.dropDownValue == null) {
      CustomSnackBar("Error", "Category is required", "error");
    } else if (dateController.text.isEmpty) {
      CustomSnackBar("Error", "Date is required", "error");
    } else if (descriptionController.text.isEmpty) {
      CustomSnackBar("Error", "Description is required", "error");
    } else {
      Get.dialog(Center(
          child: CircularProgressIndicator(
        color: primaryColor,
      )));

      try {
        await createTransaction();
      } catch (e) {
        Get.back();
        CustomSnackBar("Error", "An error occurred: $e", "error");
        print("Error during login: $e");
      }
    }
  }

  Future<void> createTransaction() async {
    final userId = auth.currentUser!.uid;
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('userTransactions') // Correct sub-collection name
          .add({
        'title': titleController.text,
        'amount': amountController.text,
        'category': categoryController.dropDownValue!.value,
        'dateAdded': dateController.text,
        'description': descriptionController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });
      Get.offAll(HomePage());
      CustomSnackBar("Success", "Added Transaction", "success");
    } catch (e) {
      CustomSnackBar("Error", "Error $e", "error");
    }
  }

  updateCheckTransaction(String transactionId) async {
    if (updateTitleController.text.isEmpty) {
      // Simplified length check
      CustomSnackBar("Error", "Title is required", "error");
    } else if (updateAmountController.text.isEmpty) {
      // Simplified length check
      CustomSnackBar("Error", "Amount is required", "error");
    } else if (updateCategoryController.dropDownValue == null) {
      CustomSnackBar("Error", "Category is required", "error");
    } else if (updateDateController.text.isEmpty) {
      CustomSnackBar("Error", "Date is required", "error");
    } else if (updateDescriptionController.text.isEmpty) {
      CustomSnackBar("Error", "Description is required", "error");
    } else {
      Get.dialog(Center(
          child: CircularProgressIndicator(
        color: primaryColor,
      )));

      try {
        await updateTransaction(transactionId);
      } catch (e) {
        Get.back();
        CustomSnackBar("Error", "An error occurred: $e", "error");
        print("Error during login: $e");
      }
    }
  }

  Future<void> updateTransaction(String transactionId) async {
    final userId = auth.currentUser!.uid;
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('userTransactions')
          .doc(
              transactionId) // Use .doc(transactionId) to update a specific document
          .update({
        'title': updateTitleController.text,
        'amount': updateAmountController.text,
        'dateAdded': updateDateController.text,
        'description': updateDescriptionController.text,
        'category': updateCategoryController.dropDownValue!.value,
      });
      CustomSnackBar("Success", "Transaction Updated", "success");
      clearUpdateController();
      Get.to(() => HomePage());
    } catch (e) {
      CustomSnackBar("Error", "Error updating transaction: $e", "error");
    }
  }

  Future<void> deleteTransaction(String transactionId) async {
    final userId = auth.currentUser!.uid; // Ensure user is logged in
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('userTransactions')
          .doc(transactionId) // Specify the document to delete by its ID
          .delete();

      // You might want to update your UI or refresh the data after deletion
      // For example, if you're using GetX, you might refresh the stream or list:
      // transactionController.getMonthlyUserTransaction(); // If it's a GetX controller, you might call update() or refresh the stream directly.

      CustomSnackBar("Success", "Transaction Deleted", "success");
    } catch (e) {
      print("Error deleting transaction: $e"); // Log the error for debugging
      CustomSnackBar("Error", "Error deleting transaction: $e", "error");
    }
  }

  Map<String, String> _getCurrentMonthDateRangeStrings() {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    final DateFormat formatter =
        DateFormat('yyyy-MM-dd'); // Strict format for querying
    print(
        'Querying from: ${formatter.format(firstDayOfMonth)} to ${formatter.format(lastDayOfMonth)}'); // Debug print
    return {
      'start': formatter.format(firstDayOfMonth),
      'end': formatter.format(lastDayOfMonth),
    };
  }

// Getting User AllTransaction
  Stream<List<TransactionModel>> getUserTransaction() {
    final userId = auth.currentUser!.uid;

    return firestore
        .collection('users')
        .doc(userId)
        .collection('userTransactions')
        .orderBy('dateAdded',
            descending: true) // Order by creation date (newest first)
        .snapshots() // Listen for real-time updates
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => TransactionModel.fromFirestore(doc))
          .toList();
    });
  }

// Getting Monthly User Transaction
  Stream<List<TransactionModel>> getMonthlyUserTransaction() {
    final userId = auth.currentUser!.uid;
    final dateRange = _getCurrentMonthDateRangeStrings();
    final startOfMonthString = dateRange['start']!;
    final endOfMonthString = dateRange['end']!;

    return firestore
        .collection('users')
        .doc(userId)
        .collection('userTransactions')
        .where('dateAdded', isGreaterThanOrEqualTo: startOfMonthString)
        .where('dateAdded', isLessThanOrEqualTo: endOfMonthString)
        .orderBy('dateAdded', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => TransactionModel.fromFirestore(doc))
          .toList();
    });
  }

  //Getting User IncomeTransaction
  Stream<List<TransactionModel>> getIncomeTransactions() {
    final userId = auth.currentUser!.uid;
    return firestore
        .collection('users')
        .doc(userId)
        .collection('userTransactions')
        .where('category', isEqualTo: 'income')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => TransactionModel.fromFirestore(doc))
          .toList();
    });
  }

  //Getting User ExpenseTransaction
  Stream<List<TransactionModel>> getExpenseTransactions() {
    final userId = auth.currentUser!.uid;
    return firestore
        .collection('users')
        .doc(userId)
        .collection('userTransactions')
        .where('category', isEqualTo: 'expense')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => TransactionModel.fromFirestore(doc))
          .toList();
    });
  }

  Stream<List<TransactionModel>> getMonthlyIncomeTransactions() {
    final userId = auth.currentUser!.uid;
    final dateRange = _getCurrentMonthDateRangeStrings();
    final startOfMonthString = dateRange['start']!;
    final endOfMonthString = dateRange['end']!;

    return firestore
        .collection('users')
        .doc(userId)
        .collection('userTransactions')
        .where('category', isEqualTo: 'income')
        .where('dateAdded',
            isGreaterThanOrEqualTo:
                startOfMonthString) // Filter by 'date' string
        .where('dateAdded',
            isLessThanOrEqualTo: endOfMonthString) // Filter by 'date' string
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => TransactionModel.fromFirestore(doc))
          .toList();
    });
  }

  Stream<List<TransactionModel>> getMonthlyExpenseTransactions() {
    final userId = auth.currentUser!.uid;
    final dateRange = _getCurrentMonthDateRangeStrings();
    final startOfMonthString = dateRange['start']!;
    final endOfMonthString = dateRange['end']!;

    return firestore
        .collection('users')
        .doc(userId)
        .collection('userTransactions')
        .where('category', isEqualTo: 'expense')
        .where('dateAdded', isGreaterThanOrEqualTo: startOfMonthString)
        .where('dateAdded', isLessThanOrEqualTo: endOfMonthString)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => TransactionModel.fromFirestore(doc))
          .toList();
    });
  }

  // Stream<double> getTotalIncome() {
  //   return getUserTransaction().map((transactions) {
  //     double totalIncome = 0.0;
  //     for (var transaction in transactions) {
  //       if (transaction.category == 'income') {
  //         // IMPORTANT: Convert the amount string to double for calculation
  //         totalIncome += double.tryParse(transaction.amount) ?? 0.0;
  //       }
  //     }
  //     return totalIncome;
  //   });
  // }

  // Stream<double> getTotalExpenses() {
  //   return getUserTransaction().map((transactions) {
  //     double totalExpenses = 0.0;
  //     for (var transaction in transactions) {
  //       if (transaction.category == 'expense') {
  //         // IMPORTANT: Convert the amount string to double for calculation
  //         totalExpenses += double.tryParse(transaction.amount) ?? 0.0;
  //       }
  //     }
  //     return totalExpenses;
  //   });
  // }

  Stream<double> getTotalMonthlyIncome() {
    return getMonthlyIncomeTransactions().map((transactions) {
      return transactions.fold(
          0.0,
          (sum, transaction) =>
              sum + (double.tryParse(transaction.amount) ?? 0.0));
    });
  }

  Stream<double> getTotalMonthlyExpenses() {
    return getMonthlyExpenseTransactions().map((transactions) {
      return transactions.fold(
          0.0,
          (sum, transaction) =>
              sum + (double.tryParse(transaction.amount) ?? 0.0));
    });
  }

  Stream<double> getAccountBalance() {
    return Rx.CombineLatestStream.combine2(
      // <--- Use CombineLatestStream.combine2
      getTotalMonthlyIncome(),
      getTotalMonthlyExpenses(),
      (double totalIncome, double totalExpenses) {
        return totalIncome - totalExpenses;
      },
    );
  }
}
