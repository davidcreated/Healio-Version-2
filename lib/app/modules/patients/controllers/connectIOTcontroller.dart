import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ConnectIOTController extends GetxController {
  // Observable variables
  var isConnecting = false.obs;
  var isBluetoothEnabled = false.obs;
  var connectionStatus = 'Disconnected'.obs;
  var pulseValue = 0.0.obs;
  var beepScale = 1.0.obs;
  var beepOpacity = 0.3.obs;

  // Timer for custom animation
  late Worker _animationWorker;

  @override
  void onInit() {
    super.onInit();
    _setupCustomAnimation();
  }

  void _setupCustomAnimation() {
    // Custom animation using GetX's ever() method
    _animationWorker = ever(pulseValue, (_) {});
    
    // Start continuous pulse animation
    _startPulseAnimation();
  }

  void _startPulseAnimation() async {
    while (!isClosed) {
      // Forward animation
      for (double i = 0; i <= 1; i += 0.02) {
        if (isClosed) break;
        pulseValue.value = i;
        beepOpacity.value = 0.18 + (i * 0.2);
        await Future.delayed(const Duration(milliseconds: 20));
      }
      
      // Reverse animation
      for (double i = 1; i >= 0; i -= 0.02) {
        if (isClosed) break;
        pulseValue.value = i;
        beepOpacity.value = 0.18 + (i * 0.2);
        await Future.delayed(const Duration(milliseconds: 20));
      }
    }
  }

  // Getters for animations (computed values)
  double get outerOpacity => 0.18 + (pulseValue.value * 0.2);
  double get middleOpacity => 0.18 + (pulseValue.value * 0.14);

  void startConnection() {
    if (!isBluetoothEnabled.value) {
      Get.snackbar(
        'Bluetooth Required',
        'Please enable Bluetooth first',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isConnecting.value = true;
    connectionStatus.value = 'Connecting...';
    
    // Simulate connection process with beeping
    _simulateConnectionProcess();
  }

  void _simulateConnectionProcess() async {
    try {
      // Simulate scanning for devices
      connectionStatus.value = 'Scanning for devices...';
      await Future.delayed(const Duration(milliseconds: 1000));
      _triggerBeep();

      // Simulate device found
      connectionStatus.value = 'Device found...';
      await Future.delayed(const Duration(milliseconds: 800));
      _triggerBeep();

      // Simulate pairing
      connectionStatus.value = 'Pairing...';
      await Future.delayed(const Duration(milliseconds: 1000));
      _triggerBeep();

      // Simulate establishing connection
      connectionStatus.value = 'Establishing connection...';
      await Future.delayed(const Duration(milliseconds: 1200));
      
      // Simulate successful connection
      isConnecting.value = false;
      connectionStatus.value = 'Connected Successfully!';
      
      Get.snackbar(
        'Success!',
        'IOT device connected successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      
      // Navigate to next page after successful connection
      await Future.delayed(const Duration(milliseconds: 1500));
      //Get.to(() => const CheckVitalsPage());
      
    } catch (e) {
      // Handle connection failure
      isConnecting.value = false;
      connectionStatus.value = 'Connection Failed';
      
      Get.snackbar(
        'Connection Failed',
        'Unable to connect to IOT device. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _triggerBeep() async {
    // Create a quick beep animation
    beepScale.value = 1.2;
    await Future.delayed(const Duration(milliseconds: 200));
    beepScale.value = 1.0;
  }

  void toggleBluetooth() {
    isBluetoothEnabled.toggle();
    if (isBluetoothEnabled.value) {
      connectionStatus.value = 'Bluetooth Enabled - Ready to Connect';
      Get.snackbar(
        'Bluetooth Enabled',
        'You can now connect to IOT devices',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } else {
      connectionStatus.value = 'Bluetooth Disabled';
      isConnecting.value = false;
      Get.snackbar(
        'Bluetooth Disabled',
        'Enable Bluetooth to connect to IOT devices',
        backgroundColor: Colors.grey,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void resetConnection() {
    isConnecting.value = false;
    connectionStatus.value = isBluetoothEnabled.value 
        ? 'Bluetooth Enabled - Ready to Connect'
        : 'Disconnected';
  }

  @override
  void onClose() {
    _animationWorker.dispose();
    super.onClose();
  }
}