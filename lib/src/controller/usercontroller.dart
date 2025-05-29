import 'package:candy_app/src/auth/widget/snackbar.dart';
import 'package:candy_app/src/controller/authcontroller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserController extends GetxController {
  final AuthController authController =
      Get.put(AuthController()); // Use Get.find()
  final Rxn<Map<String, dynamic>> _userInfo =
      Rxn<Map<String, dynamic>>(); // Use Rxn for nullable Map
  Map<String, dynamic>? get userInfo => _userInfo.value;

  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    final String? currentUser =
        authController.getUserId(); // Get user ID from LoginController

    if (currentUser == null || currentUser.isEmpty) {
      print("Error: User is not logged in.");
      _userInfo.value = null;
    }

    try {
      final DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(currentUser) // Reference to the user's main document
          .collection('userData') // Reference to the 'userData' sub-collection
          .doc(
              'profile') // Reference to the specific 'profile' document within 'userData'
          .get();

      if (userDoc.exists) {
        _userInfo.value = userDoc.data(); // Directly assign the user data
        print("User data fetched successfully: ${_userInfo.value}");
      } else {
        print("User document not found for user ID: $currentUser");
        _userInfo.value = null; // Set to null to indicate no data found
      }
    } catch (error) {
      print("Error fetching user data: $error");
      _userInfo.value = null; // Set to null on error

      CustomSnackBar(
          'Error',
          'Failed to load user information this could be due to your network: Were gonna log you in to blank account log out and login to your account or create a new one',
          'error');
    }
  }

  String? getUserField(String field) {
    final data = _userInfo.value?[field];
    if (data == null) return null; // Handle null case

    if (data is Timestamp) {
      DateTime dateTime = data.toDate();

      return DateFormat('dd-MM-yyyy')
          .format(dateTime); // Customize the format as needed
    }

    return data as String?;
  }
}
