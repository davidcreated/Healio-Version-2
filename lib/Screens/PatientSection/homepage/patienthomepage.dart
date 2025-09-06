import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/browsedoctors.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/prescriptionscreen.dart';
import 'package:healio_version_2/app/modules/patients/controllers/home_controller.dart';
import 'package:healio_version_2/shared/widgets/doctor_card.dart';
import 'package:healio_version_2/shared/widgets/home_icon_button.dart';

// Import your page files here - uncomment and update paths as needed
// import 'package:healio_version_2/app/modules/doctors/views/doctors_page.dart';
// import 'package:healio_version_2/app/modules/prescriptions/views/prescriptions_page.dart';
// import 'package:healio_version_2/app/modules/profile/views/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize GetX controller
    final HomeController controller = Get.put(HomeController());
    // Set current page index to 0 (Home) when this page loads
    controller.selectedBottomNavIndex.value = 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: _buildBody(controller),
      bottomNavigationBar: _buildBottomNavigationBar(controller),
    );
  }

  /// Builds the app bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Color(0xFF094067)),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('lib/assets/vectors/circleavatar.png'),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the navigation drawer
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 60),
        children: [
          _buildDrawerItem(
            icon: 'lib/assets/vectors/consultation.png',
            title: 'Consultation',
            onTap: () {}
          ),
          const SizedBox(height: 20),
          _buildDrawerItem(
            icon: 'lib/assets/vectors/appointment1.png',
            title: 'Appointment & Scheduling',
            onTap: (){}
          ),
          _buildDivider(),
          const SizedBox(height: 20),
          _buildDrawerItem(
            icon: 'lib/assets/vectors/prescription1.png',
            title: 'Prescription & Medication Mgt',
            onTap: (){}
          ),
          const SizedBox(height: 20),
          _buildDrawerItem(
            icon: 'lib/assets/vectors/maternal1.png',
            title: 'Maternal & Child Health Education',
          ),
          const SizedBox(height: 20),
          _buildDrawerItem(
            icon: 'lib/assets/vectors/mental1.png',
            title: 'Mental Health Support',
            onTap: (){}
          ),
          const SizedBox(height: 20),
          _buildDivider(),
          const SizedBox(height: 20),
          _buildDrawerItem(
            icon: 'lib/assets/vectors/wearable1.png',
            title: 'Wearable Devices & IOT Integration',
            onTap: () {}
          ),
          const SizedBox(height: 20),
          _buildDrawerItem(
            icon: 'lib/assets/vectors/lab1.png',
            title: 'Diagnostic Lab Integration',
            onTap: () {}
          ),
        ],
      ),
    );
  }

  /// Builds individual drawer items
  Widget _buildDrawerItem({
    required String icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Image.asset(
        icon,
        width: 24,
        height: 24,
        fit: BoxFit.contain,
      ),
      title: GestureDetector(
        onTap: onTap,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'NotoSans',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// Builds divider for drawer
  Widget _buildDivider() {
    return Container(
      color: Colors.black,
      width: 40,
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.centerLeft,
    );
  }

  /// Builds the main body content
  Widget _buildBody(HomeController controller) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildGreetingSection(controller),
          _buildSearchBar(controller),
          _buildBannerImage(),
          _buildHorizontalOptions(),
          _buildUpcomingAppointmentSection(controller),
          _buildTopDoctorsSection(controller),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  /// Builds the greeting section
  Widget _buildGreetingSection(HomeController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Using Obx for reactive updates
            Obx(() => Text(
              controller.greeting.value,
              style: const TextStyle(
                fontFamily: 'NotoSans',
                color: Color(0xFF094067),
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            )),
            const Text(
              'David-Paul☀️',
              style: TextStyle(
                fontFamily: 'NotoSans',
                color: Color(0xFF094067),
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'How can we help you today?',
              style: TextStyle(
                fontFamily: 'NotoSans',
                color: Color(0xFF094067),
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the search bar with reactive clear button
  Widget _buildSearchBar(HomeController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Obx(() => TextFormField(
        controller: controller.searchController,
        decoration: InputDecoration(
          hintText: 'Search symptoms or doctor',
          filled: true,
          fillColor: const Color(0xFFE8FEFA),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: controller.searchQuery.value.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: controller.clearSearch,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        ),
      )),
    );
  }

  /// Builds the banner image
  Widget _buildBannerImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Image.asset(
        'lib/assets/vectors/appointment.png',
        width: 343,
        height: 238,
        fit: BoxFit.cover,
      ),
    );
  }

  /// Builds horizontal scrollable options
  Widget _buildHorizontalOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: SizedBox(
        height: 90,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            HomeIconButton(
              image: 'lib/assets/vectors/doctor.png',
              label: 'Doctors',
              onTap: () {}
            ),
            HomeIconButton(
              image: 'lib/assets/vectors/Appointments.png',
              label: 'Appointments',
              onTap: () {}
            ),
            HomeIconButton(
              image: 'lib/assets/vectors/prescription.png',
              label: 'Prescription',
              onTap: (){}
            ),
            const HomeIconButton(
              image: 'lib/assets/vectors/records.png',
              label: 'Records',
            ),
            const HomeIconButton(
              image: 'lib/assets/vectors/maternal child.png',
              label: 'Maternal',
            ),
            HomeIconButton(
              image: 'lib/assets/vectors/mental health.png',
              label: 'Mental Health',
              onTap: () {}
            ),
          ],
        ),
      ),
    );
  }

  /// Builds upcoming appointment section
  Widget _buildUpcomingAppointmentSection(HomeController controller) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Upcoming Appointment',
                style: TextStyle(
                  fontFamily: 'NotoSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              TextButton(
                onPressed: () {
                  // NavigationHelper.navigateWithSlideTransition(const UpcomingAppointmentsPage());
                },
                child: const Text(
                  'View all',
                  style: TextStyle(
                    fontFamily: 'NotoSans',
                    color: Color(0xFF094067),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Reactive doctors list
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Obx(() {
            // Show loading indicator or empty state if needed
            if (controller.filteredDoctors.isEmpty && controller.searchQuery.value.isNotEmpty) {
              return _buildNoSearchResults();
            }
            
            return Column(
              children: controller.filteredDoctors.map((doctor) {
                return Column(
                  children: [
                    DoctorCard(
                      doctor: doctor,
                      onTap: (){}
                    ),
                    const SizedBox(height: 15),
                  ],
                );
              }).toList(),
            );
          }),
        ),
      ],
    );
  }

  /// Builds no search results widget
  Widget _buildNoSearchResults() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No doctors found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
              fontFamily: 'NotoSans',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching with different keywords',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
              fontFamily: 'NotoSans',
            ),
          ),
        ],
      ),
    );
  }

  /// Builds bottom navigation bar with proper navigation logic
  Widget _buildBottomNavigationBar(HomeController controller) {
    return Obx(() => BottomNavigationBar(
      currentIndex: controller.selectedBottomNavIndex.value,
      onTap: (index) {
        // Update the controller's selected index
        controller.onBottomNavTap(index);
        // Handle navigation
        _handleBottomNavigation(index);
      },
      selectedItemColor: const Color(0xFF007F67),
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
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
    ));
  }

  /// Builds the top doctors section
  Widget _buildTopDoctorsSection(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Top Doctors',
                style: TextStyle(
                  fontFamily: 'NotoSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              TextButton(
                onPressed: () {
                  // NavigationHelper.navigateWithSlideTransition(const TopDoctorsPage());
                },
                child: const Text(
                  'View all',
                  style: TextStyle(
                    fontFamily: 'NotoSans',
                    color: Color(0xFF094067),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Obx(() {
            // Show loading indicator or empty state if needed
            if (controller.allDoctors.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(
                      Icons.person_off,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No top doctors found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                        fontFamily: 'NotoSans',
                      ),
                    ),
                  ],
                ),
              );
            }
            // Default: show list of top doctors
            return Column(
              children: controller.allDoctors.map((doctor) {
                return Column(
                  children: [
                    DoctorCard(
                      doctor: doctor,
                      onTap: (){}
                    ),
                    const SizedBox(height: 15),
                  ],
                );
              }).toList(),
            );
          }),
        ),
      ],
    );
  }

  /// Handles bottom navigation with proper navigation logic
  void _handleBottomNavigation(int index) {
    switch (index) {
      case 0:
        // Home - Already on home page, no navigation needed
        // Just update the index in controller if needed
        break;
        
      case 1:
        // Doctors - Navigate to Doctors/Browse Doctors page
        Get.to(
          () => const Browsedoctors(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 300),
        );
        break;
        
      case 2:
        // Prescriptions - Navigate to Prescriptions page
        // Uncomment and update with your actual prescriptions page
        Get.to(
          () => const Prescriptionpage(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 300),
        );

        // Temporary fallback - show snackbar until prescriptions page is ready
        Get.snackbar(
          'Navigation',
          'Prescriptions page - Coming Soon!',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          backgroundColor: const Color(0xFF007F67),
          colorText: Colors.white,
        );
        break;
        
      case 3:
        // Profile - Navigate to Profile page
        // Uncomment and update with your actual profile page
        // Get.to(
        //   () => const ProfilePage(),
        //   transition: Transition.rightToLeftWithFade,
        //   duration: const Duration(milliseconds: 300),
        // );
        
        // Temporary fallback - show snackbar until profile page is ready
        Get.snackbar(
          'Navigation',
          'Profile page - Coming Soon!',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          backgroundColor: const Color(0xFF007F67),
          colorText: Colors.white,
        );
        break;
        
      default:
        // Invalid index - should not happen
        break;
    }
  }
}