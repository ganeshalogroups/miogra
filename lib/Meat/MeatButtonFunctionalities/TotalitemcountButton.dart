

import 'package:testing/Meat/MeatButtonFunctionalities/MeatAddproductController.dart/AddmeatController.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MeatButtonController with ChangeNotifier {
  bool _isButtonVisible = false;
  ValueNotifier<int> totalItemCountNotifier = ValueNotifier<int>(0);

  bool get isButtonVisible => _isButtonVisible;

  void showmeatButton() {
    _isButtonVisible = true;
    notifyListeners();
  }

  void hidemeatButton() {
    _isButtonVisible = false;
     totalItemCountNotifier.value = 0;
    notifyListeners();
  }

void incrementmeatItemCount(int count) {
    totalItemCountNotifier.value += count;
    notifyListeners();
  }

  void decrementmeatItemCount(int count) {
    totalItemCountNotifier.value = (totalItemCountNotifier.value - count).clamp(0, double.infinity).toInt();
    loge.i(count);
    notifyListeners();
  }



Future<void> updatemeatTotalItemCount(MeatAddcontroller meatcart) async {

    try {

        var cartItems = await meatcart.getmeatcartmeat(km: 0);
        int totalQuantity = cartItems.fold(0, (sum, item) => sum + (item['quantity'] ?? 0),
      );

        loge.i('==Total Quantity --==> $totalQuantity');
        totalItemCountNotifier.value = totalQuantity;

      
      notifyListeners();
    } catch (e) {
      print("Error updating total item count: $e");
    }
  }

}

class MeatCustomizationController extends GetxController {

  var selectedVariantId  =  "".obs;
  var selectedAddons     =  <String>[].obs;
  var meatCustomerPrice  =  0.0.obs;  // This will hold the final price including the variant and add-ons

  // Store variant and add-on prices separately
  var baseVariantPrice = 0.0.obs;
  var addonPrices = <String, double>{}; // Store add-on prices with IDs

  // Updates the variant selection and recalculates the total price
  void updateVariant(String? newVariantId, int variantPrice) {
    selectedVariantId.value = newVariantId!;
    baseVariantPrice.value = variantPrice.toDouble();
      print("Selected Variant ID updated to: ${selectedVariantId.value}");
    calculateTotalPrice(); // Recalculate the total price when the variant changes
  }

  // Toggles add-on selection and recalculates the total price
  void toggleAddon(String addonId, int addonPrice) {
    if (selectedAddons.contains(addonId)) {
      // Remove add-on and price
      selectedAddons.remove(addonId);
      addonPrices.remove(addonId); // Remove from the prices map
    } else {
      // Add add-on and price
      selectedAddons.add(addonId);
      addonPrices[addonId] = addonPrice.toDouble(); // Store the add-on price
    }
    calculateTotalPrice(); // Recalculate the total price when add-ons change
  }

  // Calculates the total price based on the selected variant and add-ons
  void calculateTotalPrice() {
    // Start with the base variant price
    double totalPrice = baseVariantPrice.value;

    // Add the price of all selected add-ons
    for (String addonId in selectedAddons) {
      totalPrice += addonPrices[addonId] ?? 0.0;
    }

    // Update the foodCustomerPrice with the new total price
    meatCustomerPrice.value = totalPrice;
    update();
  }
}