import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartitemController with ChangeNotifier {
  // Function to get current user's ID
  Future<String?> getCurrentUserId() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      return user?.uid;
    } catch (e) {
      print('Error getting current user ID: $e');
      return null;
    }
  }

  // Function to remove item from Firestore cart
  Future<void> removeCartItem(String productId) async {
    try {
      String? userId = await getCurrentUserId();
      if (userId == null) return;

      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      DocumentSnapshot userDoc = await userDocRef.get();

      if (!userDoc.exists) return;

      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      List<dynamic> cartItems = userData['cartItems'] ?? [];
      num totalPrice = userData['totalPrice'] ?? 0.0;

      // Find and remove the item
      cartItems.removeWhere((item) => item['productId'] == productId);

      // Recalculate total price
      totalPrice = cartItems.fold(
          0, (sum, item) => sum + (item['ourPrice'] * item['quantity']));

      // Update Firestore
      await userDocRef.update({
        'cartItems': cartItems,
        'totalPrice': totalPrice,
      });

      print("Item removed successfully. Updated total: ₹$totalPrice");

      notifyListeners();
    } catch (e) {
      print("Error removing item: $e");
    }
  }

  // Function to update cart quantity
  Future<void> updateCartQuantity(String productId, int change) async {
    try {
      String? userId = await getCurrentUserId();
      if (userId == null) return;

      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      DocumentSnapshot userDoc = await userDocRef.get();

      if (!userDoc.exists) return;

      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      List<dynamic> cartItems = userData['cartItems'] ?? [];
      num totalPrice = userData['totalPrice'] ?? 0.0;

      // Find the item
      var index =
          cartItems.indexWhere((item) => item['productId'] == productId);
      if (index == -1) return;

      // Update quantity
      int newQuantity = (cartItems[index]['quantity'] ?? 1) + change;
      if (newQuantity <= 0) {
        cartItems.removeAt(index); // Remove if quantity is 0
      } else {
        cartItems[index]['quantity'] = newQuantity;
      }

      // Recalculate total price
      totalPrice = cartItems.fold(
          0, (sum, item) => sum + (item['ourPrice'] * item['quantity']));

      // Update Firestore
      await userDocRef.update({
        'cartItems': cartItems,
        'totalPrice': totalPrice,
      });

      print("Cart updated successfully.");

      notifyListeners();
    } catch (e) {
      print("Error updating cart: $e");
    }
  }
}
