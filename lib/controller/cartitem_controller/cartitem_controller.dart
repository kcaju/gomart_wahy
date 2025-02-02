import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartitemController with ChangeNotifier {
  // Variable to store cart items locally
  List<dynamic> cartItems = [];

  // Function to get current user's ID
  Future<String?> getCurrentUserId() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return user.uid;
      } else {
        return null; // User is not logged in
      }
    } catch (e) {
      print('Error getting current user ID: $e');
      return null;
    }
  }

  // Function to remove item from Firestore cart
  Future<void> removeCartItem(String userId, String productName) async {
    try {
      // Reference to the user's document in the 'users' collection
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      // Update the cart array by removing the item with the specified productName
      await userDocRef.update({
        'cartItems': FieldValue.arrayRemove([
          {'productName': productName}
        ]), // Remove item by productName
      });

      // After removal, update the local cart items list
      cartItems.removeWhere((item) => item['productName'] == productName);
      notifyListeners(); // Notify listeners (UI)
    } catch (e) {
      print('Error removing item from cart: $e');
    }
  }

  // Function to fetch cart items
  Future<void> fetchCartItems(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        // Print the fetched document for debugging
        print('User document fetched: ${userDoc.data()}');

        var cartItems = userDoc['cartItems'] ?? [];
        print('Cart Items: $cartItems'); // Debugging the cart items

        // Update local cartItems list
        this.cartItems = List.from(cartItems);
        notifyListeners(); // Notify listeners (UI)
      } else {
        print('User document does not exist');
      }
    } catch (e) {
      print('Error fetching cart items: $e');
    }
  }
}
