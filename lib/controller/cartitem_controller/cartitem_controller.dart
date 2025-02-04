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
      double totalPrice = userData['totalPrice'] ?? 0.0;

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
      double totalPrice = userData['totalPrice'] ?? 0.0;

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





// Variable to store cart items locally
  // List<dynamic> cartItems = [];

  // Function to get current user's ID
  // Future<String?> getCurrentUserId() async {
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       return user.uid;
  //     } else {
  //       return null; // User is not logged in
  //     }
  //   } catch (e) {
  //     print('Error getting current user ID: $e');
  //     return null;
  //   }
  // }

  // Function to remove item from Firestore cart
  // Future<void> removeCartItem(String userId, String productName) async {
  //   try {
  //     // Reference to the user's document in the 'users' collection
  //     DocumentReference userDocRef =
  //         FirebaseFirestore.instance.collection('users').doc(userId);

  //     // Update the cart array by removing the item with the specified productName
  //     await userDocRef.update({
  //       'cartItems': FieldValue.arrayRemove([
  //         {'productName': productName}
  //       ]), // Remove item by productName
  //     });

      // After removal, update the local cart items list
  //     cartItems.removeWhere((item) => item['productName'] == productName);
  //     notifyListeners(); // Notify listeners (UI)
  //   } catch (e) {
  //     print('Error removing item from cart: $e');
  //   }
  // }

  // Function to fetch cart items
  // Future<void> fetchCartItems(String userId) async {
  //   try {
  //     DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userId)
  //         .get();

  //     if (userDoc.exists) {
  //       // Print the fetched document for debugging
  //       print('User document fetched: ${userDoc.data()}');

  //       var cartItems = userDoc['cartItems'] ?? [];
  //       print('Cart Items: $cartItems'); // Debugging the cart items

  //       // Update local cartItems list
  //       this.cartItems = List.from(cartItems);
  //       notifyListeners(); // Notify listeners (UI)
  //     } else {
  //       print('User document does not exist');
  //     }
  //   } catch (e) {
  //     print('Error fetching cart items: $e');
  //   }
  // }
