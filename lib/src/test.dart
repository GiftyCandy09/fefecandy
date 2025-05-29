// class ExportController extends GetxController {
//   final TransactionController transactionController =
//       Get.put(TransactionController());

//   Future<void> exportTransactions() async {
//     try {
//       // 1. Fetch the data
//       final List<TransactionModel> transactions =
//           await transactionController.getMonthlyUserTransaction().first;

//       if (transactions.isEmpty) {
//         CustomSnackBar(
//             "Error", "No transactions to export for this month.", 'error');
//         return;
//       }

//       // 2. Prepare data for CSV
//       List<List<dynamic>> csvData = [];
//       // Add header row
//       csvData.add([
//         'Date',
//         'Description',
//         'Amount',
//         'Category'
//       ]); // Added 'Category' based on your loop

//       // Add transaction data
//       for (var transaction in transactions) {
//         csvData.add([
//           transaction.formattedTransactionDate,
//           transaction.description,
//           transaction.amount,
//           transaction.category,
//         ]);
//       }

//       // Convert to CSV string
//       String csvString = const ListToCsvConverter().convert(csvData);

//       // 3. Define and create the directory
//       final downloadsDirectory = await getDownloadsDirectory();
//       if (downloadsDirectory == null) {
//         CustomSnackBar(
//             "Error", "Could not access downloads directory.", 'error');
//         return;
//       }

//       final appSpecificDirectory =
//           Directory('${downloadsDirectory.path}/SavvySpend');

//       // Create the directory if it doesn't exist
//       if (!await appSpecificDirectory.exists()) {
//         await appSpecificDirectory.create(recursive: true);
//       }
//       print(appSpecificDirectory);
//       // 4. Save the file
//       final fileName =
//           'monthly_transactions_${DateTime.now().toIso8601String().substring(0, 10)}.csv';
//       final filePath = '${appSpecificDirectory.path}/$fileName';
//       final File file = File(filePath);
//       await file.writeAsString(csvString);

//       // 5. Share the file
//       await Share.shareXFiles([XFile(file.path)],
//           text: 'Here are my monthly transaction details.');
//       print(filePath);
//       CustomSnackBar("Success", "Transactions exported and ready to share!",
//           'success'); // Changed to 'Success'
//     } catch (e) {
//       print('Error exporting transactions: $e');
//       CustomSnackBar("Error", "Failed to export transactions: $e", 'error');
//     }
//   }
// }


