import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/modules/patients/controllers/connectIOTcontroller.dart';

class ConnectIOTPage extends StatelessWidget {
  const ConnectIOTPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(ConnectIOTController());
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF0B2A7D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 8, top: 8),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 20),
            onPressed: () => Get.back(),
          ),
        ),
        title: const Text(
          "IOT Integration",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'NotoSans',
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        actions: [
          // Reset button
          Obx(() => controller.isConnecting.value
              ? IconButton(
                  icon: const Icon(Icons.stop, color: Colors.white),
                  onPressed: () => controller.resetConnection(),
                )
              : const SizedBox.shrink()),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Background gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF3B5BDB),
                    Color(0xFF0B2A7D),
                  ],
                ),
              ),
            ),
            // Main content - Use SingleChildScrollView to prevent overflow
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.08),
                  
                  // Connection Status
                  Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          controller.connectionStatus.value,
                          style: TextStyle(
                            color: _getStatusColor(controller.connectionStatus.value),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'NotoSans',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (controller.isConnecting.value)
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            width: 200,
                            child: const LinearProgressIndicator(
                              backgroundColor: Colors.white24,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                      ],
                    ),
                  )),
                  
                  const SizedBox(height: 25),
                  
                  // Animated Connect Button with Beeping
                  Center(child: _buildConnectButton(controller, size)),
                  
                  const SizedBox(height: 35),
                  
                  // Bluetooth Section
                  _buildBluetoothSection(controller),
                  
                  const SizedBox(height: 25),
                  
                  // Instructions
                  _buildInstructions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    if (status.contains('Connected Successfully') || status.contains('Bluetooth Enabled')) {
      return Colors.greenAccent;
    } else if (status.contains('Failed') || status.contains('Disabled')) {
      return Colors.redAccent;
    } else if (status.contains('Connecting') || status.contains('Scanning') || status.contains('Pairing')) {
      return Colors.orangeAccent;
    }
    return Colors.white70;
  }

  Widget _buildConnectButton(ConnectIOTController controller, Size size) {
    final double circleMax = size.width * 0.85;
    final double circleMid = size.width * 0.65;
    final double circleInner = size.width * 0.50;

    return Obx(() => Transform.scale(
      scale: controller.isConnecting.value ? controller.beepScale.value : 1.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outermost animated circle with beeping effect
          Container(
            width: circleMax,
            height: circleMax,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withOpacity(
                    controller.isConnecting.value 
                        ? controller.beepOpacity.value * 0.6
                        : controller.outerOpacity * 0.8
                  ),
                  Colors.white.withOpacity(
                    controller.isConnecting.value 
                        ? controller.beepOpacity.value * 0.3
                        : controller.outerOpacity * 0.4
                  ),
                  Colors.transparent,
                ],
                stops: const [0.6, 0.85, 1.0],
              ),
            ),
          ),
          
          // Middle animated circle with beeping effect
          Container(
            width: circleMid,
            height: circleMid,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withOpacity(
                    controller.isConnecting.value 
                        ? controller.beepOpacity.value * 0.5
                        : controller.middleOpacity * 0.7
                  ),
                  Colors.white.withOpacity(
                    controller.isConnecting.value 
                        ? controller.beepOpacity.value * 0.25
                        : controller.middleOpacity * 0.35
                  ),
                  Colors.transparent,
                ],
                stops: const [0.6, 0.85, 1.0],
              ),
            ),
          ),
          
          // Inner connect button with enhanced beeping
          GestureDetector(
            onTap: controller.isConnecting.value 
                ? null 
                : () => controller.startConnection(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: circleInner,
              height: circleInner,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: controller.isConnecting.value 
                      ? Color.lerp(Colors.orange, Colors.deepOrange, controller.beepOpacity.value)!
                      : const Color(0xFF1CBF7A),
                  width: controller.isConnecting.value ? 3.0 : 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                  if (controller.isConnecting.value)
                    BoxShadow(
                      color: Colors.orange.withOpacity(controller.beepOpacity.value * 0.6),
                      blurRadius: 25,
                      spreadRadius: controller.beepOpacity.value * 3,
                      offset: const Offset(0, 0),
                    ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.isConnecting.value
                      ? SizedBox(
                          width: 48,
                          height: 48,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color.lerp(Color(0xFF002180), Colors.orange, controller.beepOpacity.value * 0.3)!,
                            ),
                          ),
                        )
                      : const Icon(
                          Icons.power_outlined,
                          size: 48,
                          color: Color(0xFF002180),
                        ),
                  const SizedBox(height: 8),
                  Text(
                    controller.isConnecting.value ? "Connecting" : "Connect",
                    style: TextStyle(
                      color: controller.isConnecting.value 
                          ? Color.lerp(Color(0xFF002180), Colors.orange.shade800, controller.beepOpacity.value * 0.2)!
                          : Color(0xFF002180),
                      fontWeight: FontWeight.w500,
                      fontSize: 30, // Reduced from 34 to prevent overflow
                      fontFamily: 'NotoSans',
                    ),
                  ),
                  Text(
                    "IOT",
                    style: TextStyle(
                      color: controller.isConnecting.value 
                          ? Color.lerp(Color(0xFF002180), Colors.orange.shade800, controller.beepOpacity.value * 0.2)!
                          : Color(0xFF002180),
                      fontWeight: FontWeight.w500,
                      fontSize: 30, // Reduced from 34 to prevent overflow
                      fontFamily: 'NotoSans',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildBluetoothSection(ConnectIOTController controller) {
    return Obx(() => Column(
      children: [
        // Bluetooth Icon with enhanced beeping animation
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          transform: Matrix4.identity()
            ..scale(controller.isBluetoothEnabled.value && controller.isConnecting.value
                ? controller.beepScale.value * 0.15 + 1.0  // Increased effect
                : 1.0),
          child: GestureDetector(
            onTap: () => controller.toggleBluetooth(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: controller.isBluetoothEnabled.value 
                    ? Colors.blue.shade400 
                    : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                  if (controller.isBluetoothEnabled.value && controller.isConnecting.value)
                    BoxShadow(
                      color: Colors.blue.withOpacity(controller.beepOpacity.value * 0.9), // Increased intensity
                      blurRadius: 25,
                      spreadRadius: controller.beepOpacity.value * 6, // Increased spread
                      offset: const Offset(0, 0),
                    ),
                ],
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  key: ValueKey(controller.isBluetoothEnabled.value),
                  controller.isConnecting.value && controller.isBluetoothEnabled.value
                      ? Icons.bluetooth_searching
                      : Icons.bluetooth,
                  color: controller.isBluetoothEnabled.value 
                      ? Colors.white 
                      : Colors.grey.shade600,
                  size: 36,
                ),
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Animated status text with beeping color effect
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            key: ValueKey('${controller.isBluetoothEnabled.value}-${controller.isConnecting.value}'),
            controller.isConnecting.value && controller.isBluetoothEnabled.value
                ? "Searching for devices..."
                : controller.isBluetoothEnabled.value
                    ? "Bluetooth is enabled"
                    : "Tap to enable Bluetooth",
            style: TextStyle(
              color: controller.isConnecting.value && controller.isBluetoothEnabled.value
                  ? Color.lerp(Colors.white, Colors.orange, controller.beepOpacity.value * 0.6)! // Increased effect
                  : controller.isBluetoothEnabled.value 
                      ? Colors.greenAccent 
                      : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'NotoSans',
            ),
          ),
        ),
        
        // Enable Bluetooth Button
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: !controller.isBluetoothEnabled.value
              ? Padding(
                  key: const ValueKey('bluetooth_button'),
                  padding: const EdgeInsets.only(top: 16),
                  child: ElevatedButton.icon(
                    onPressed: () => controller.toggleBluetooth(),
                    icon: const Icon(Icons.bluetooth, size: 20),
                    label: const Text("Enable Bluetooth"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      elevation: 4,
                    ),
                  ),
                )
              : const SizedBox.shrink(key: ValueKey('empty')),
        ),
      ],
    ));
  }

  Widget _buildInstructions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.white.withOpacity(0.8),
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                "Instructions:",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontFamily: 'NotoSans',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...[ 
            "Enable Bluetooth on your device",
            "Make sure your IOT device is in pairing mode", 
            "Tap the Connect IOT button to start pairing",
            "Wait for the connection to establish"
          ].asMap().entries.map((entry) => 
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "${entry.key + 1}",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NotoSans',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Fixed spacing
                  Expanded(
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                        fontFamily: 'NotoSans',
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).toList(),
        ],
      ),
    );
  }
}