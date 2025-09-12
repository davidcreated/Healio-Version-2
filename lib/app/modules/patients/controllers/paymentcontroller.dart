import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/models/walletinfo.dart';
import 'package:healio_version_2/models/appointmentcheckout.dart';

// Define PaymentMethod enum if it doesn't exist
enum PaymentMethod {
  card,
  transfer,
  wallet,
}

class PaymentController extends GetxController {
  // Payment method selection
  var selectedPaymentMethod = Rx<PaymentMethod?>(null);
  
  // Appointment and payment details
  var appointmentDetails = Rx<AppointmentCheckout?>(null);
  var appointmentInfo = Rx<Map<String, dynamic>?>(null);
  var totalAmount = 0.0.obs;
  var selectedDuration = 2.obs;
  
  // Wallet information
  var walletInfo = WalletInfo(balance: 45000.0).obs;
  
  // Loading and error states
  var isProcessingPayment = false.obs;
  var paymentError = ''.obs;
  
  // Payment method availability
  var isCardAvailable = true.obs;
  var isTransferAvailable = true.obs;
  var isWalletAvailable = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initializePaymentDetails();
    _checkWalletAvailability();
  }

  /// Initialize payment details from checkout
  void _initializePaymentDetails() {
    try {
      final arguments = Get.arguments as Map<String, dynamic>?;
      
      if (arguments != null) {
        debugPrint('Payment Controller Arguments: $arguments');
        
        // Handle AppointmentCheckout object
        if (arguments['appointmentDetails'] != null) {
          if (arguments['appointmentDetails'] is AppointmentCheckout) {
            appointmentDetails.value = arguments['appointmentDetails'] as AppointmentCheckout;
            
            // Create info map from the object
            appointmentInfo.value = {
              'doctorName': appointmentDetails.value?.doctorName ?? 'Dr. Sarah Udy',
              'appointmentDate': arguments['formattedDate'] ?? 'Tuesday April 13th 2025',
              'appointmentTime': arguments['formattedTime'] ?? '9:30 AM',
              'doctorSpecialization': appointmentDetails.value?.doctorSpecialization ?? 'Cardiologist',
              'doctorLocation': appointmentDetails.value?.doctorLocation ?? 'Uyo Nigeria',
              'doctorHospital': appointmentDetails.value?.doctorHospital ?? 'University of Uyo Teaching Hospital',
            };
          } else if (arguments['appointmentDetails'] is Map<String, dynamic>) {
            appointmentInfo.value = arguments['appointmentDetails'] as Map<String, dynamic>;
          }
        }
        
        totalAmount.value = _safeParseDouble(arguments['totalAmount']) ?? 20000.0;
        selectedDuration.value = _safeParseInt(arguments['selectedDuration']) ?? 2;
        
        debugPrint('Total Amount: ${totalAmount.value}');
        debugPrint('Selected Duration: ${selectedDuration.value}');
        
      } else {
        _setDefaultValues();
      }
    } catch (e) {
      debugPrint('Error initializing payment details: $e');
      _setDefaultValues();
    }
  }

  void _setDefaultValues() {
    totalAmount.value = 20000.0;
    selectedDuration.value = 2;
    appointmentInfo.value = {
      'doctorName': 'Dr. Sarah Udy',
      'appointmentDate': 'Tuesday April 13th 2025',
      'appointmentTime': '9:30 AM GMT+1',
    };
  }

  double? _safeParseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  int? _safeParseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  /// Check if wallet has sufficient balance
  void _checkWalletAvailability() {
    isWalletAvailable.value = walletInfo.value.balance >= totalAmount.value;
  }

  /// Navigate back to previous screen
  void goBack() {
    Get.back();
  }

  /// Select payment method
  void selectPaymentMethod(PaymentMethod method) {
    paymentError.value = '';
    
    if (method == PaymentMethod.wallet && !isWalletAvailable.value) {
      paymentError.value = 'Insufficient wallet balance';
      return;
    }
    
    selectedPaymentMethod.value = method;
  }

  /// Format currency
  String formatCurrency(double amount) {
    return '₦${amount.toInt().toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), 
      (Match m) => '${m[1]},'
    )}';
  }

  /// Get payment method display name
  String getPaymentMethodName(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.card:
        return 'Debit/Credit Card';
      case PaymentMethod.transfer:
        return 'Bank Transfer';
      case PaymentMethod.wallet:
        return 'App Wallet';
    }
  }

  /// Get payment method description
  String getPaymentMethodDescription(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.card:
        return 'Pay securely with your debit or credit card';
      case PaymentMethod.transfer:
        return 'Transfer directly from your bank account';
      case PaymentMethod.wallet:
        return 'Pay instantly from your app wallet balance';
    }
  }

  /// Get payment method icon
  IconData getPaymentMethodIcon(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.card:
        return Icons.credit_card;
      case PaymentMethod.transfer:
        return Icons.account_balance;
      case PaymentMethod.wallet:
        return Icons.account_balance_wallet;
    }
  }

  /// Process payment with selected method
  void processPayment() {
    if (selectedPaymentMethod.value == null) {
      _showErrorMessage('Please select a payment method');
      return;
    }

    paymentError.value = '';
    isProcessingPayment.value = true;

    Future.delayed(const Duration(seconds: 2), () {
      isProcessingPayment.value = false;
      
      switch (selectedPaymentMethod.value!) {
        case PaymentMethod.card:
          _processCardPayment();
          break;
        case PaymentMethod.transfer:
          _processBankTransfer();
          break;
        case PaymentMethod.wallet:
          _processWalletPayment();
          break;
      }
    });
  }

  /// Process card payment
  void _processCardPayment() {
    // For now, show success message
    _showSuccessMessage('Card payment selected. Proceeding to payment gateway...');
    
    // You can implement actual card payment navigation here
    // Get.toNamed('/card-payment', arguments: preparedArguments);
    Get.offAllNamed('/preliminary-questions');
  }

  /// Process bank transfer
  void _processBankTransfer() {
    _showSuccessMessage('Bank transfer selected. Generating transfer details...');
    
    // You can implement actual bank transfer navigation here
    // Get.toNamed('/bank-transfer', arguments: preparedArguments);
    Get.offAllNamed('/preliminary-questions');
  }

  /// Process wallet payment
  void _processWalletPayment() {
    if (!isWalletAvailable.value) {
      _showErrorMessage('Insufficient wallet balance');
      return;
    }

    final newBalance = walletInfo.value.balance - totalAmount.value;
    walletInfo.value = WalletInfo(balance: newBalance);
    
    _showSuccessMessage('Payment successful! Appointment confirmed.');
    
    // Navigate to appointment confirmation or back to home
    Get.offAllNamed('/preliminary-questions');
  }

  /// Add funds to wallet
  void addFundsToWallet() {
    _showSuccessMessage('Add funds feature coming soon!');
  }

  /// Show error message
  void _showErrorMessage(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      snackPosition: SnackPosition.TOP,
    );
  }

  /// Show success message
  void _showSuccessMessage(String message) {
    Get.snackbar(
      'Success',
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      snackPosition: SnackPosition.TOP,
    );
  }

  /// Get wallet status message
  String get walletStatusMessage {
    if (!isWalletAvailable.value) {
      final shortfall = totalAmount.value - walletInfo.value.balance;
      return 'You need ${formatCurrency(shortfall)} more to complete this payment';
    }
    return 'Sufficient balance available';
  }

  /// Check if continue button should be enabled
  bool get canContinue {
    return selectedPaymentMethod.value != null && 
           (selectedPaymentMethod.value != PaymentMethod.wallet || isWalletAvailable.value);
  }

  /// Get appointment display info
  String get doctorName => appointmentInfo.value?['doctorName'] ?? 'Dr. Sarah Udy';
  String get appointmentDate => appointmentInfo.value?['appointmentDate'] ?? 'Date not set';
  String get appointmentTime => appointmentInfo.value?['appointmentTime'] ?? 'Time not set';

  @override
  void onClose() {
    super.onClose();
  }
}