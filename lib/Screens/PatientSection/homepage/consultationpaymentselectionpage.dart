import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/modules/payments/controllers/paymentcontroller.dart';

// Remove local PaymentMethod enum and import the shared one

/// Payment selection page widget
class Consultationpaymentselectionpage extends StatelessWidget {
  const Consultationpaymentselectionpage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller using GetX dependency injection
    final controller = Get.put(PaymentController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(controller),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildPageHeader(controller),
                    const SizedBox(height: 32),
                    _buildPaymentMethods(controller),
                    const SizedBox(height: 24),
                    _buildWalletInfo(controller),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            _buildBottomSection(controller),
          ],
        ),
      ),
    );
  }

  /// Build app bar with back button and title
  Widget _buildAppBar(PaymentController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Back button with blue background
          InkWell(
            onTap: controller.goBack,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF002180),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF061234),
            ),
          ),
        ],
      ),
    );
  }

  /// Build page header with payment amount
  Widget _buildPageHeader(PaymentController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Payment Method',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF061234),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Choose how you\'d like to pay for your consultation',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF686868),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          
          // Payment amount card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [const Color(0xFF002180), const Color(0xFF002180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Amount',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() => Text(
                  controller.formatCurrency(controller.totalAmount.value),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                )),
                const SizedBox(height: 8),
                Obx(() => Text(
                  '${controller.selectedDuration.value} hour consultation with ${controller.doctorName}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build payment method options
  Widget _buildPaymentMethods(PaymentController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Options',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF061234),
            ),
          ),
          const SizedBox(height: 16),
          
          // Payment method cards
          ...PaymentMethod.values.map((method) => 
            _buildPaymentMethodCard(controller, method)
          ).toList(),
        ],
      ),
    );
  }

  /// Build individual payment method card
  Widget _buildPaymentMethodCard(PaymentController controller, PaymentMethod method) {
    return Obx(() {
      final isSelected = controller.selectedPaymentMethod.value == method;
      final isWalletMethod = method == PaymentMethod.wallet;
      final isWalletAvailable = controller.isWalletAvailable.value;
      final isEnabled = !isWalletMethod || isWalletAvailable;

      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: GestureDetector(
          onTap: () => controller.selectPaymentMethod(method),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected 
                    ? const Color(0xFF002180)
                    : const Color(0xFFE0E6ED),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected ? [
                BoxShadow(
                  color: const Color(0xFF002180).withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ] : null,
            ),
            child: Row(
              children: [
                // Payment method icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isEnabled
                        ? const Color(0xFF002180).withOpacity(0.1)
                        : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    controller.getPaymentMethodIcon(method),
                    color: isEnabled 
                        ? const Color(0xFF002180)
                        : Colors.grey,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Payment method details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.getPaymentMethodName(method),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isEnabled 
                              ? const Color(0xFF061234)
                              : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.getPaymentMethodDescription(method),
                        style: TextStyle(
                          fontSize: 12,
                          color: isEnabled 
                              ? const Color(0xFF686868)
                              : Colors.grey,
                        ),
                      ),
                      
                      // Show wallet balance if wallet method
                      if (isWalletMethod) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              isWalletAvailable 
                                  ? Icons.check_circle 
                                  : Icons.warning,
                              color: isWalletAvailable 
                                  ? Colors.green 
                                  : Colors.orange,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Balance: ${controller.formatCurrency(controller.walletInfo.value.balance)}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isWalletAvailable 
                                    ? Colors.green 
                                    : Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                
                // Selection indicator
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected 
                          ? const Color(0xFF002180)
                          : const Color(0xFFE0E6ED),
                      width: 2,
                    ),
                    color: isSelected 
                        ? const Color(0xFF002180)
                        : Colors.transparent,
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  /// Build wallet information section
  Widget _buildWalletInfo(PaymentController controller) {
    return Obx(() {
      if (controller.selectedPaymentMethod.value != PaymentMethod.wallet) {
        return const SizedBox.shrink();
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: controller.isWalletAvailable.value 
                ? const Color(0xFFF0F8FF)
                : const Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: controller.isWalletAvailable.value 
                  ? const Color(0xFF2196F3)
                  : const Color(0xFFFF9800),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    controller.isWalletAvailable.value 
                        ? Icons.info_outline
                        : Icons.warning_amber,
                    color: controller.isWalletAvailable.value 
                        ? const Color(0xFF2196F3)
                        : const Color(0xFFFF9800),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    controller.isWalletAvailable.value 
                        ? 'Wallet Payment Available'
                        : 'Insufficient Wallet Balance',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: controller.isWalletAvailable.value 
                          ? const Color(0xFF2196F3)
                          : const Color(0xFFFF9800),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                controller.walletStatusMessage,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF686868),
                ),
              ),
              
              if (!controller.isWalletAvailable.value) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: controller.addFundsToWallet,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFFF9800),
                      side: const BorderSide(color: Color(0xFFFF9800)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Add Funds to Wallet'),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    });
  }

  /// Build bottom section with continue button
  Widget _buildBottomSection(PaymentController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE0E6ED)),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Error message if any
            Obx(() {
              if (controller.paymentError.value.isNotEmpty) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          controller.paymentError.value,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
            
            // Continue button
            Obx(() => SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: controller.canContinue && !controller.isProcessingPayment.value
                    ? controller.processPayment
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF002180),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(0xFFE0E6ED),
                  disabledForegroundColor: const Color(0xFF686868),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                child: controller.isProcessingPayment.value
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        controller.selectedPaymentMethod.value == null
                            ? 'Select a Payment Method'
                            : 'Continue to Payment',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}