import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/connectIOT.dart';
import 'package:healio_version_2/app/modules/patients/controllers/iot_requirement_controller.dart';


class IOTSystemRequirementPage extends StatelessWidget {
  const IOTSystemRequirementPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller using GetX dependency management
    final IotRequirementController controller = Get.put(IotRequirementController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            // Top bar
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF002180),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 16),
                    // Use GetX for back navigation
                    onPressed: () => Get.back(),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Checkout",
                  style: TextStyle(
                    color: Color(0xFF061234),
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    fontFamily: 'NotoSans',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            // Card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 18),
              child: Column(
                children: [
                  const Text(
                    "System Requirements",
                    style: TextStyle(
                      color: Color(0xFF4B4B4B),
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      fontFamily: 'NotoSans',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        color: Color(0xFF686868),
                        fontSize: 16,
                        fontFamily: 'NotoSans',
                      ),
                      children: [
                        const TextSpan(
                          text:
                              "You need a smart watch version of not less than ",
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            // Call the controller method to launch URL
                            onTap: () => controller.launchProductUrl(
                                'https://www.apple.com/apple-watch-series-7/'),
                            child: const Text(
                              "Apple Watch Series 7",
                              style: TextStyle(
                                color: Color(0xFF2735FD),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        const TextSpan(
                          text: " and\n",
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            // Call the controller method to launch URL
                            onTap: () => controller.launchProductUrl(
                                'https://www.samsung.com/global/galaxy/galaxy-watch6-classic/'),
                            child: const Text(
                              "Galaxy Watch6 Classic",
                              style: TextStyle(
                                color: Color(0xFF2735FD),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Image.asset(  
                    'lib/assets/images/patient/watch.png',
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 40,
                    width: 250,
                    child: ElevatedButton(
                      // Call the controller method for navigation
                      onPressed: () => Get.to(() => const ConnectIOTPage()),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF002180),
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'NotoSans',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}