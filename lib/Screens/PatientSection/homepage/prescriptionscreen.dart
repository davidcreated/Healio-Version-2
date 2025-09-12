import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/browsedoctors.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/patienthomepage.dart';
import 'package:healio_version_2/app/modules/patients/controllers/prescriptioncontroller.dart';



class Prescriptionpage extends StatelessWidget {
  const Prescriptionpage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final PrescriptionController controller = Get.put(PrescriptionController());
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive design calculations
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;
          final isTablet = screenWidth > 600;
          final cardWidth = isTablet ? screenWidth * 0.8 : screenWidth - 32;
          
          return Column(
            children: [
              // Header section with image background and overlays
              _buildHeaderSection(context, screenWidth, cardWidth, controller),
              
              // Medication cards section - wrapped in Expanded to take remaining space
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.02,
                    bottom: 16.0,
                  ),
                  child: Obx(() => _buildMedicationCards(controller, cardWidth)),
                ),
              ),
            ],
          );
        },
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: Obx(() => _buildBottomNavigationBar(context, controller)),
    );
  }
  
  // Header section with background image and overlays
  Widget _buildHeaderSection(BuildContext context, double screenWidth, double cardWidth, PrescriptionController controller) {
    final bool isTablet = screenWidth > 600;
    final double horizontalPadding = isTablet ? screenWidth * 0.08 : 20.0;
    final double headerHeight = isTablet ? 220.0 : 180.0;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double totalHeaderHeight = headerHeight + statusBarHeight;

    return Container(
      width: double.infinity,
      height: totalHeaderHeight,
      child: Stack(
        children: [
          // Background image container - starts from absolute top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('lib/assets/images/patient/findlabtopbar.png'),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
              ),
            ),
          ),
          
          // Back button and title - positioned below status bar
          Positioned(
            left: horizontalPadding,
            top: statusBarHeight + 20,
            right: horizontalPadding,
            child: Row(
              children: [
                Container(
                  width: isTablet ? 44 : 36,
                  height: isTablet ? 44 : 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF002180),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: isTablet ? 20 : 20,
                    ),
                    onPressed: () => Get.off(() => const HomePage()),
                    padding: EdgeInsets.zero,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Prescriptions',
                    style: TextStyle(
                      color: const Color(0xFF2D2D2D),
                      fontWeight: FontWeight.w600,
                      fontSize: isTablet ? 22 : 18,
                      fontFamily: 'NotoSans',
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Medication toggle buttons - positioned at bottom of header
          Positioned(
            left: horizontalPadding,
            right: horizontalPadding,
            bottom: 40,
            child: Container(
              height: isTablet ? 56 : 48,
              constraints: BoxConstraints(
                maxWidth: isTablet ? 400 : double.infinity,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(isTablet ? 28.0 : 24.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    // Active Medication Button
                    Expanded(
                      child: Obx(() => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(isTablet ? 24 : 20),
                            onTap: () => controller.switchMedicationTab(true),
                            child: Container(
                              height: isTablet ? 48 : 40,
                              decoration: BoxDecoration(
                                color: controller.isActiveMedicationSelected.value
                                    ? const Color(0xE2190B99)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(isTablet ? 24 : 20),
                              ),
                              child: Center(
                                child: Text(
                                  'Active Medication',
                                  style: TextStyle(
                                    fontFamily: 'InterTight',
                                    fontWeight: FontWeight.w500,
                                    fontSize: isTablet ? 16 : 14,
                                    color: controller.isActiveMedicationSelected.value
                                        ? Colors.white
                                        : Colors.grey[400],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                    ),
                    
                    // Medication History Button
                    Expanded(
                      child: Obx(() => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(isTablet ? 24 : 20),
                            onTap: () {
                              controller.switchMedicationTab(false);
                            },
                            child: Container(
                              height: isTablet ? 48 : 40,
                              decoration: BoxDecoration(
                                color: !controller.isActiveMedicationSelected.value
                                    ? const Color(0xE2190B99)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(isTablet ? 24 : 20),
                              ),
                              child: Center(
                                child: Text(
                                  'Medication History',
                                  style: TextStyle(
                                    fontFamily: 'InterTight',
                                    fontWeight: FontWeight.w600,
                                    fontSize: isTablet ? 16 : 14,
                                    color: !controller.isActiveMedicationSelected.value
                                        ? Colors.white
                                        : Colors.grey[400],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Build medication cards list
  Widget _buildMedicationCards(PrescriptionController controller, double cardWidth) {
    return Column(
      children: controller.medications.map((medication) => 
        _buildMedicationCard(medication, cardWidth)
      ).toList(),
    );
  }
  
  // Individual medication card
  Widget _buildMedicationCard(Medication medication, double cardWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: cardWidth,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F7FB),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              // Add medication detail navigation here
              Get.snackbar(
                'Medication Details',
                'Tapped on ${medication.name}',
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 2),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Medication name and progress
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          medication.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontFamily: 'NotoSans',
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${medication.taken}/${medication.total} taken',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontFamily: 'NotoSans',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Progress bar
                  LinearProgressIndicator(
                    value: medication.taken / medication.total,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      medication.taken / medication.total > 0.8 
                        ? Colors.green 
                        : medication.taken / medication.total > 0.5 
                          ? Colors.orange 
                          : Colors.red,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Dosage and instruction
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        medication.dosage,
                        style: const TextStyle(
                          color: Color(0xFF0057FF),
                          fontSize: 14,
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7B6B6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            medication.instruction,
                            style: const TextStyle(
                              color: Color(0xFFB3261E),
                              fontSize: 12,
                              fontFamily: 'NotoSans',
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  // Bottom Navigation Bar
  Widget _buildBottomNavigationBar(BuildContext context, PrescriptionController controller) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: (index) {
          controller.onBottomNavTap(index);
          
          // Navigation logic with smooth transitions
          if (index == 0) {
            Get.offAll(() => const HomePage());
          } else if (index == 1) {
            Get.offAll(() => const Browsedoctors());
          } else if (index == 2) {
            // Stay on Prescription page (already here)
          } else {
            // Handle other navigation if needed
            Get.snackbar(
              'Feature',
              'Coming Soon!',
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2),
            );
          }
        },
        selectedItemColor: const Color(0xFF007F67),
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: Colors.white,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/home.png')),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/doctor.png')),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/prescription.png')),
            label: 'Prescriptions',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/profile.png')),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}