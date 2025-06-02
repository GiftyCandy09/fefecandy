import 'package:candy_app/decoration.dart';
import 'package:candy_app/src/auth/widget/snackbar.dart';
import 'package:candy_app/src/controller/transactioncontroller.dart';
import 'package:candy_app/src/models/transactionmodel.dart';
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';
// Import for Uint8List


class ExportController extends GetxController {
  final TransactionController transactionController =
      Get.put(TransactionController());

  Future<void> exportTransactionsCsv() async {
    try {
      // 1. Get Data
      List<TransactionModel> transactions = [];
      await transactionController
          .getMonthlyUserTransaction()
          .first
          .then((list) {
        transactions = list;
      });

      if (transactions.isEmpty) {
        CustomSnackBar('No Data',
            'No transactions found for the current month to export.', 'error');
        return;
      }

      // 2. Prepare CSV Data
      List<List<dynamic>> csvData = [];

      // Add CSV Headers
      csvData.add([
        'Date',
        'Amount',
        'Category',
        'Description',
      ]);

      // Add Transaction Data
      for (var transaction in transactions) {
        csvData.add([
          transaction.date,
          transaction.amount,
          transaction.category,
          transaction.description ?? '',
        ]);
      }

      // Encode CSV Data
      String csv = const ListToCsvConverter().convert(csvData);
      Uint8List bytes =
          Uint8List.fromList(csv.codeUnits); // Convert string to bytes

      // 3. Use FilePicker to allow the user to choose save location and write the file
      String? outputPath = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Transactions CSV',
        fileName:
            'monthly_transactions_${DateTime.now().toIso8601String().replaceAll(':', '-')}.csv',
        type: FileType.custom,
        allowedExtensions: ['csv'],
        bytes: bytes, //
      );

      if (outputPath == null) {
        // User canceled the picker
        CustomSnackBar(
            'Export Canceled', 'CSV export was canceled by the user.', 'error');
        return;
      }

      // 4. No need to manually write now, file_picker handled it.
      // The outputPath will contain the path where the file was saved.

      // 5. Notify User
      CustomSnackBar(
          'Success', 'Transactions exported to CSV successfully!', 'success');
      print('CSV exported to: $outputPath');
    } catch (e) {
      CustomSnackBar('Error', 'Failed to export transactions: $e', 'error');
      print('Error exporting CSV: $e');
    }
  }

  Future<void> exportTransactionsPdf() async {
    try {
      // 1. Get Data
      List<TransactionModel> transactions = [];
      // Assuming getMonthlyUserTransaction returns a Stream<List<TransactionModel>>
      // We take the first list emitted by the stream.
      await transactionController
          .getMonthlyUserTransaction()
          .first
          .then((list) {
        transactions = list;
      });

      if (transactions.isEmpty) {
        CustomSnackBar('No Data',
            'No transactions found for the current month to export.', 'error');
        return;
      }

      // 2. Create PDF Document
      final pdf = pw.Document();
       final String formattedDateTime =
          '${DateTime.now().toLocal().toIso8601String().substring(0, 10)} at ${DateTime.now().toLocal().hour}:${DateTime.now().toLocal().minute.toString().padLeft(2, '0')}';
      // Load a font if you want custom fonts (optional, default is Helvetica)
      // final font = await PdfGoogleFonts.nunitoExtraLight();

      // Add a page to the PDF
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return [
              pw.Center(
                child: pw.Text(
                  'Monthly Transactions Report',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    // font: font, // Apply custom font if loaded
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: ['Date', 'Amount', 'Category', 'Description'],
                data: transactions.map((transaction) {
                  return [
                    transaction
                        .date, // Assuming transaction.date is already a formatted string
                    transaction.amount, // Format amount to 2 decimal places
                    transaction.category,
                    transaction.description ?? 'N/A', // Handle null description
                  ];
                }).toList(),
                border: pw.TableBorder.all(color: PdfColors.grey500),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                cellAlignment: pw.Alignment.centerLeft,
                cellPadding: const pw.EdgeInsets.all(8),
                columnWidths: {
                  0: const pw.FlexColumnWidth(2), // Date
                  1: const pw.FlexColumnWidth(1.5), // Amount
                  2: const pw.FlexColumnWidth(2), // Category
                  3: const pw.FlexColumnWidth(3), // Description
                },
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Generated on: $formattedDateTime',
                style:
                    const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
              ),
            ];
          },
        ),
      );

      // 3. Get PDF bytes
      final Uint8List bytes = await pdf.save();

      // 4. Use FilePicker to allow the user to choose save location and write the file
      String? outputPath = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Transactions PDF',
        fileName:
            'monthly_transactions_${DateTime.now().toIso8601String().replaceAll(':', '-')}.pdf',
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        bytes: bytes, // Pass the PDF bytes directly
      );

      if (outputPath == null) {
        // User canceled the picker
        CustomSnackBar(
            'Export Canceled', 'PDF export was canceled by the user.', 'error');
        return;
      }

      // 5. Notify User
      CustomSnackBar(
          'Success', 'Transactions exported to PDF successfully!', 'success');
      print('PDF exported to: $outputPath');
    } catch (e) {
      CustomSnackBar('Error', 'Failed to export transactions: $e', 'error');
      print('Error exporting PDF: $e');
    }
  }

  Future<void> exportTransactionsImage() async {
    try {
      // Show a loading indicator while processing
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );
 final String formattedDateTime =
          '${DateTime.now().toLocal().toIso8601String().substring(0, 10)} at ${DateTime.now().toLocal().hour}:${DateTime.now().toLocal().minute.toString().padLeft(2, '0')}';
      // 1. Get Data: Fetch the monthly transactions, similar to PDF/CSV exports
      List<TransactionModel> transactions = [];
      await transactionController
          .getMonthlyUserTransaction()
          .first
          .then((list) {
        transactions = list;
      });

      // If no transactions, dismiss loader and show error
      if (transactions.isEmpty) {
        Get.back();
        CustomSnackBar(
            'No Data',
            'No transactions found for the current month to export as image.',
            'error');
        return;
      }

      // 2. Create a Widget to represent the transactions for image capture.
      // This widget will be rendered off-screen by the screenshot package.
      final imageWidget = Container(
        padding: const EdgeInsets.all(20.0), // Padding around the content
        color: Colors.white, // Essential: Set a background color for the image
        child: Column(
          // Important: mainAxisSize.min makes the column only as tall as its children,
          // preventing a large empty space in the image.
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Monthly Transactions Report',
                style: textBlackLargeBold.copyWith(
                    fontSize: 20,
                    color: Colors.black), // Ensure text has a color
              ),
            ),
            SizedBox(height: 25), // Spacing below title
            // Build the table using Flutter's Table widget
            Table(
              border: TableBorder.all(color: Colors.grey.shade400, width: 1.0),
              columnWidths: const {
                0: FlexColumnWidth(2), // Date
                1: FlexColumnWidth(1.5), // Amount
                2: FlexColumnWidth(2), // Category
                3: FlexColumnWidth(3), // Description
              },
              children: [
                // Table Header Row
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey.shade200),
                  children: [
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Date",
                            style: textBlackMedium.copyWith(fontSize: 11))),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Amount",
                            style: textBlackMedium.copyWith(fontSize: 11))),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Category",
                            style: textBlackMedium.copyWith(fontSize: 11))),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Description",
                            style: textBlackMedium.copyWith(fontSize: 11))),
                  ],
                ),
                // Data Rows for each transaction
                ...transactions.map((transaction) {
                  return TableRow(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(transaction.date,
                              style: textBlackMini.copyWith(fontSize: 8.5))),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(transaction.amount,
                              style: textBlackMini.copyWith(fontSize: 8.5))),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(transaction.category,
                              style: textBlackMini.copyWith(fontSize: 8.5))),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            transaction.description ?? 'N/A',
                            style: textBlackMini.copyWith(fontSize: 8.5),
                          )),
                    ],
                  );
                }).toList(),
              ],
            ),
            SizedBox(height: 25), // Spacing above footer
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Generated on: $formattedDateTime',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      );

      // 3. Capture the created widget as an image using ScreenshotController.captureFromWidget
      final Uint8List? imageBytes =
          await ScreenshotController().captureFromWidget(
        imageWidget,
        delay: const Duration(milliseconds: 100), // Small delay for rendering
        pixelRatio:
            2.5, // Higher pixelRatio for better image quality (e.g., 2.0 or 3.0)
        // context: Get.context, // Providing context might be necessary for some widgets (e.g., Theme.of)
      );

      // Dismiss the loading indicator
      Get.back();

      // Check if image capture was successful
      if (imageBytes == null) {
        CustomSnackBar('Capture Failed',
            'Failed to generate image from transactions data.', 'error');
        return;
      }

      // 4. Use FilePicker to allow the user to choose the save location
      String? outputPath = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Transactions Image',
        fileName:
            'monthly_transactions_report_${DateTime.now().toIso8601String().replaceAll(':', '-')}.png',
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg'], // Allow PNG and JPG formats
        bytes: imageBytes, // Pass the generated image bytes directly
      );

      // If user cancels file picker
      if (outputPath == null) {
        CustomSnackBar('Export Canceled',
            'Image export was canceled by the user.', 'error');
        return;
      }

      // 5. Notify the user of success
      CustomSnackBar(
          'Success', 'Transactions exported as image successfully!', 'success');
      print('Image exported to: $outputPath');
    } catch (e) {
      // Ensure loading indicator is dismissed even on error
      Get.back();
      CustomSnackBar('Error', 'Failed to export image: $e', 'error');
      print('Error exporting image from data: $e');
    }
  }
}
