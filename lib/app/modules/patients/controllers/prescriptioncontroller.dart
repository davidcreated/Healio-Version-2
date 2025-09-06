// GetX Controller for managing prescription state

import 'package:get/get.dart';
class PrescriptionController extends GetxController {
  // Checkbox states for medication schedule
  var checkboxValue1 = true.obs;
  var checkboxValue2 = true.obs;
  var checkboxValue3 = true.obs;
  var checkboxValue4 = true.obs;
  
  // Selected bottom navigation index
  var selectedIndex = 2.obs; // Prescriptions tab is selected by default
  
  // Active medication tab selection
  var isActiveMedicationSelected = true.obs;
  
  // Sample medication data - replace with actual data from your backend
  var medications = <Medication>[
    Medication(
      name: 'Amoxicillin 500mg',
      dosage: '1 capsule 3 times daily',
      taken: 12,
      total: 30,
      instruction: 'Take 30 mins after eating',
      imagePath: 'assets/vectors/amox.png',
    ),
    Medication(
      name: 'Linagliptin 5mg',
      dosage: '1 tablet once daily',
      taken: 8,
      total: 30,
      instruction: 'Take with breakfast',
      imagePath: 'assets/vectors/lin.png',
    ),
    Medication(
      name: 'Omeprazole 20mg',
      dosage: '1 capsule before meals',
      taken: 15,
      total: 30,
      instruction: 'Take 1 hour before eating',
      imagePath: 'assets/vectors/ome.png',
    ),
    Medication(
      name: 'Metformin 500mg',
      dosage: '1 tablet twice daily',
      taken: 20,
      total: 30,
      instruction: 'Take with meals',
      imagePath: 'assets/vectors/man.png',
    ),
  ].obs;
  
  // Toggle checkbox values
  void toggleCheckbox(int index, bool value) {
    switch (index) {
      case 1:
        checkboxValue1.value = value;
        break;
      case 2:
        checkboxValue2.value = value;
        break;
      case 3:
        checkboxValue3.value = value;
        break;
      case 4:
        checkboxValue4.value = value;
        break;
    }
  }
  
  // Handle bottom navigation
  void onBottomNavTap(int index) {
    selectedIndex.value = index;
  }
  
  // Switch between Active Medication and Medication History
  void switchMedicationTab(bool isActive) {
    isActiveMedicationSelected.value = isActive;
  }
}

// Medication model
class Medication {
  final String name;
  final String dosage;
  final int taken;
  final int total;
  final String instruction;
  final String imagePath;
  
  Medication({
    required this.name,
    required this.dosage,
    required this.taken,
    required this.total,
    required this.instruction,
    required this.imagePath,
  });
}
