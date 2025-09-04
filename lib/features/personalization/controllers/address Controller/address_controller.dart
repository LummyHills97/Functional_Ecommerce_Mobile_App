import 'package:ecommerce_store/features/personalization/screens/address/widgets/address_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

// Address Controller
class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final Rx<Address?> selectedAddress = Rx<Address?>(null);
  final RxList<Address> allAddresses = <Address>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load some sample addresses
    _loadSampleAddresses();
  }

  void _loadSampleAddresses() {
    allAddresses.assignAll([
      Address(
        id: '1',
        name: 'John Doe',
        phoneNumber: '(+234) 456 7890',
        street: '82356 Timmy Coves',
        city: 'South Liana',
        state: 'Maine',
        postalCode: '87665',
        country: 'USA',
        isSelected: true,
      ),
      Address(
        id: '2',
        name: 'Jane Smith',
        phoneNumber: '(+234) 123 4567',
        street: '123 Oak Street',
        city: 'Downtown',
        state: 'California',
        postalCode: '90210',
        country: 'USA',
        isSelected: false,
      ),
    ]);
    
    // Set the first address as selected
    if (allAddresses.isNotEmpty) {
      selectedAddress.value = allAddresses.first;
    }
  }

  // Add new address
  Future<void> addNewAddress(Address address) async {
    try {
      // Generate a unique ID
      final newAddress = address.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      );
      
      allAddresses.add(newAddress);
      
      // Show success message
      Get.snackbar(
        'Success',
        'Address added successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF4CAF50),
        colorText: const Color(0xFFFFFFFF),
        duration: const Duration(seconds: 2),
      );
      
      // Go back to address list
      Get.back();
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add address. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFF44336),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }

  // Select an address
  void selectAddress(Address address) {
    // Update all addresses to unselected
    final updatedAddresses = allAddresses.map((addr) => 
      addr.copyWith(isSelected: false)
    ).toList();
    
    // Select the chosen address
    final selectedIndex = updatedAddresses.indexWhere((addr) => addr.id == address.id);
    if (selectedIndex != -1) {
      updatedAddresses[selectedIndex] = updatedAddresses[selectedIndex].copyWith(isSelected: true);
      selectedAddress.value = updatedAddresses[selectedIndex];
    }
    
    // Update the list
    allAddresses.assignAll(updatedAddresses);
  }

  // Delete address
  void deleteAddress(String addressId) {
    allAddresses.removeWhere((address) => address.id == addressId);
    
    // If deleted address was selected, select first available
    if (selectedAddress.value?.id == addressId && allAddresses.isNotEmpty) {
      selectAddress(allAddresses.first);
    } else if (allAddresses.isEmpty) {
      selectedAddress.value = null;
    }
  }

  // Get selected address
  Address? get getSelectedAddress => selectedAddress.value;
}