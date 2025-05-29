import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Make sure to add this import for DateFormat

class TransactionModel {
  final String id;
  final String title;
  final String amount;
  final String category;
  final String date;
  final String? description;
  final Timestamp createdAt; // Parsed DateTime from Firestore Timestamp

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.description,
    required this.createdAt,
  });

  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TransactionModel(
      id: doc.id,
      title: data['title'] ?? '',
      amount: data['amount'] ?? '',
      category: data['category'] ?? '',
      date: data['dateAdded'] ?? '',
      description: data['description'],
      createdAt: data['createdAt'],
    );
  }

  String get formattedTransactionDate {
    try {
      // Parse the 'YYYY-MM-DD' string into a DateTime object
      DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
      // Format it to your desired display format, e.g., "May 16, 2025"
      return DateFormat('MMM dd, yyyy').format(parsedDate);
    } catch (e) {
      // Fallback if parsing fails (e.g., malformed date string)
      print('Error parsing date string for display: $date - $e');
      return date; // Return the raw string as a fallback
    }
  }

  String get formattedCreationTime {
    DateTime now = DateTime.now();
    DateTime addedDate = createdAt.toDate(); // Convert Timestamp to DateTime

    // Calculate the difference between now and the transaction creation time
    final Duration difference = now.difference(addedDate);

    if (difference.inDays == 0) {
      // If it's today
      if (difference.inHours < 1) {
        // <--- Changed logic here
        // If it's within the last 5 hours
        if (difference.inHours == 0) {
          // If it's within the current hour
          if (difference.inMinutes < 1) {
            return 'Just now';
          } else if (difference.inMinutes == 1) {
            return '1 mins ago';
          } else {
            return '${difference.inMinutes} min ago';
          }
        } else if (difference.inHours == 1) {
          return '1 hour ago';
        } else {
          return '${difference.inHours} hours ago';
        }
      } else {
        // If it's today but older than 5 hours, show the time
        return DateFormat('hh:mm a')
            .format(addedDate); // e.g., "10:00 AM" or "03:30 PM"
      }
    } else if (difference.inDays == 1) {
      // If it was yesterday
      return 'Yesterday';
    } else {
      // For any other date (more than 1 day ago)
      return DateFormat('dd/MM/yy').format(addedDate); // e.g., "21/05/24"
    }
  }

  String get displayCategory {
    if (category.isEmpty) return '';
    return '${category[0].toUpperCase()}${category.substring(1)}';
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "amount": amount,
      "category": category,
      "date": date,
      "description": description,
      "createdAt": FieldValue
          .serverTimestamp(), // For saving, keep it as serverTimestamp
    };
  }
}
