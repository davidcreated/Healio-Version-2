import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healio_version_2/app/modules/doctors/controllers/browsedoctorscontrollers.dart.dart';

// Import your page files here - uncomment and update paths as needed
// import 'package:healio_version_2/Screens/PatientSection/homepage/homepage.dart';
// import 'package:healio_version_2/app/modules/prescriptions/views/prescriptions_page.dart';
// import 'package:healio_version_2/app/modules/profile/views/profile_page.dart';

class Therapistconsult extends StatelessWidget {
  const Therapistconsult ({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrowseDoctorsController());
    // Set current page index to 1 (Doctors) when this page loads
    controller.selectedIndex.value = 1;
    
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    
    // Responsive values based on screen size
    final bool isTablet = screenWidth > 600;
    final double horizontalPadding = isTablet ? screenWidth * 0.08 : 20.0;
    final double headerHeight = isTablet ? 220.0 : 180.0;

    return Scaffold(
      backgroundColor: const Color(0xFF051426),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight - kBottomNavigationBarHeight,
          ),
          child: Column(
            children: [
              // Header image with back button
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: headerHeight,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('lib/assets/images/patient/therapisttopbar.png'),
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
                  // Back button and title - Better aligned
                  Positioned(
                    left: horizontalPadding,
                    top: MediaQuery.of(context).padding.top + 20,
                    right: horizontalPadding,
                    child: Row(
                      children: [
                        Container(
                          width: isTablet ? 44 : 36,
                          height: isTablet ? 44 : 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFFCCD3E6),
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
                              color: Color(0xff002180),
                              size: isTablet ? 20 : 20,
                            ),
                            onPressed: controller.goBack,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Private Session',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: isTablet ? 22 : 18,
                              fontFamily: 'NotoSans',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // "For You" and "Nearby" buttons - Better positioned
                  Positioned(
                    left: horizontalPadding,
                    right: horizontalPadding,
                    bottom: 15,
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
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: [
                            // "For You" button
                            Expanded(
                              child: ElevatedButton(
                                onPressed: controller.navigateToForYou,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2D2D2D),
                                  foregroundColor: Colors.white70,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(isTablet ? 24 : 20),
                                  ),
                                  textStyle: TextStyle(
                                    fontFamily: 'InterTight',
                                    fontWeight: FontWeight.w500,
                                    fontSize: isTablet ? 16 : 14,
                                  ),
                                ),
                                child: const Text('For You'),
                              ),
                            ),
                            // "Nearby" button - Active state
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xE2190B99),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(isTablet ? 24 : 20),
                                  ),
                                  textStyle: TextStyle(
                                    fontFamily: 'InterTight',
                                    fontWeight: FontWeight.w600,
                                    fontSize: isTablet ? 16 : 14,
                                  ),
                                ),
                                child: const Text('Nearby'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: isTablet ? 32 : 24),
              
              // Browse by Specialization section - Better spacing
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Browse by Specialization',
                      style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontWeight: FontWeight.w700,
                        fontSize: isTablet ? 20 : 17,
                        color:  Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.snackbar('Navigation', 'View all specializations');
                      },
                      child: Text(
                        'View all',
                        style: TextStyle(
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.w600,
                          fontSize: isTablet ? 17 : 15,
                          color: const Color(0xFF2735FD),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: isTablet ? 28 : 20),
              
              // Horizontal list of specializations - Better layout
             
              // Nearby Doctors section - Better spacing
              Padding(
                padding: EdgeInsets.only(
                  left: horizontalPadding, 
                  top: isTablet ? 40.0 : 32.0, 
                  right: horizontalPadding
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nearby Doctors',
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                      fontWeight: FontWeight.w700,
                      fontSize: isTablet ? 22 : 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: isTablet ? 28 : 20),
              
              // Doctor cards - Better layout
              sarahudy(isTablet, horizontalPadding, controller),
              SizedBox(height: isTablet ? 20 : 16),
              
              sarahjohnson(isTablet, horizontalPadding, controller),
              SizedBox(height: isTablet ? 20 : 16),
              
              nuurdeen(isTablet, horizontalPadding, controller),
              SizedBox(height: isTablet ? 32 : 24),
            ],
          ),
        ),
      ),
      
   
    );
  }

  /// Handles bottom navigation with proper navigation logic
  

  _card sarahudy(bool isTablet, double horizontalPadding, BrowseDoctorsController controller) {
    return _card(
              imagePath: 'lib/assets/images/doctors/Doctor img.png',
              name: 'Dr. Sarah Udy',
              specialization: 'Cardiologist',
              location: 'Uyo Nigeria',
              description: "Hello, I'm Dr. Sarah. I have been in practice for 8 years handling all forms of heart diseases...",
              rating: '4.9',
              reviews: '2.3k',
              isTablet: isTablet,
              horizontalPadding: horizontalPadding,
              onBookAppointment: () => controller.bookAppointment('Dr. Sarah Udy'),
              onConsultNow: () => controller.consultNow('Dr. Sarah Udy'),
            );
  }

  _card sarahjohnson(bool isTablet, double horizontalPadding, BrowseDoctorsController controller) {
    return _card(
              imagePath: 'lib/assets/images/doctors/sarah.png',
              name: 'Dr. Sarah Johnson',
              specialization: 'Dermatologist',
              location: 'Lagos Nigeria',
              description: "Hello, I'm Dr. Sarah Johnson. I specialize in skin care and have 6 years of experience...",
              rating: '4.8',
              reviews: '1.8k',
              isTablet: isTablet,
              horizontalPadding: horizontalPadding,
              onBookAppointment: () => controller.bookAppointment('Dr. Sarah Johnson'),
              onConsultNow: () => controller.consultNow('Dr. Sarah Johnson'),
            );
  }

  _card nuurdeen(bool isTablet, double horizontalPadding, BrowseDoctorsController controller) {
    return _card(
            imagePath: 'lib/assets/images/doctors/nuurdeen.png',
            name: 'Dr. Nuurdeen Ahmad',
            specialization: 'General Practitioner',
            location: 'Abuja Nigeria',
            description: "Hello, I'm Dr. Nuurdeen. I provide comprehensive healthcare with 10 years experience...",
            rating: '4.7',
            reviews: '3.1k',
            isTablet: isTablet,
            horizontalPadding: horizontalPadding,
            onBookAppointment: () => controller.bookAppointment('Dr. Nuurdeen Ahmad'),
            onConsultNow: () => controller.consultNow('Dr. Nuurdeen Ahmad'),
          );
  }

  _card doctordetailscard(bool isTablet, double horizontalPadding, BrowseDoctorsController controller) {
    return _card(
              imagePath: 'lib/assets/images/doctors/nuurdeen.png',
              name: 'Dr. Nuurdeen Ahmad',
              specialization: 'General Practitioner',
              location: 'Abuja Nigeria',
              description: "Hello, I'm Dr. Nuurdeen. I provide comprehensive healthcare with 10 years experience...",
              rating: '4.7',
              reviews: '3.1k',
              isTablet: isTablet,
              horizontalPadding: horizontalPadding,
              onBookAppointment: () => controller.bookAppointment('Dr. Nuurdeen Ahmad'),
              onConsultNow: () => controller.consultNow('Dr. Nuurdeen Ahmad'),
            );
  }
}

// Specialization Item Widget - Better design with responsive sizing


// Doctor Card Widget - Better alignment and spacing with responsive sizing
// ignore: unused_element
class _card extends StatelessWidget {
  final String imagePath;
  final String name;
  final String specialization;
  final String location;
  final String description;
  final String rating;
  final String reviews;
  final bool isTablet;
  final double horizontalPadding;
  final VoidCallback onBookAppointment;
  final VoidCallback onConsultNow;

  const _card({
    required this.imagePath,
    required this.name,
    required this.specialization,
    required this.location,
    required this.description,
    required this.rating,
    required this.reviews,
    required this.isTablet,
    required this.horizontalPadding,
    required this.onBookAppointment,
    required this.onConsultNow,
  });

  @override
  Widget build(BuildContext context) {
    final double imageSize = isTablet ? 95 : 75;
    final double imageHeight = isTablet ? 115 : 95;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: isTablet ? 600 : double.infinity,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(isTablet ? 20 : 16),
          border: Border.all(
            color: const Color(0xFFDFE8FC),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(isTablet ? 20.0 : 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Doctor image - Better styling
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                      child: Image.asset(
                        imagePath,
                        width: imageSize,
                        height: imageHeight,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: imageSize,
                            height: imageHeight,
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: isTablet ? 48 : 40,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: isTablet ? 20 : 16),
                  
                  // Doctor info - Better layout
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                name,
                                style: TextStyle(
                                  fontFamily: 'NotoSans',
                                  fontWeight: FontWeight.w700,
                                  fontSize: isTablet ? 18 : 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Icon(Icons.verified,
                                color: Colors.white, 
                                size: isTablet ? 22 : 18),
                          ],
                        ),
                        SizedBox(height: isTablet ? 8 : 6),
                        
                        Row(
                          children: [
                            Icon(Icons.medical_services,
                                color: const Color(0xFFE91E63), 
                                size: isTablet ? 18 : 16),
                            SizedBox(width: isTablet ? 8 : 6),
                            Expanded(
                              child: Text(
                                specialization,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isTablet ? 15 : 13,
                                  fontFamily: 'NotoSans',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isTablet ? 6 : 4),
                        
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                color: const Color(0xFF1BF2C9), 
                                size: isTablet ? 18 : 16),
                            SizedBox(width: isTablet ? 8 : 6),
                            Expanded(
                              child: Text(
                                location,
                                style: TextStyle(
                                  color:Colors.white,
                                  fontSize: isTablet ? 15 : 13,
                                  fontFamily: 'NotoSans',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isTablet ? 12 : 8),
                        
                        Text(
                          description,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isTablet ? 15 : 13,
                            fontFamily: 'NotoSans',
                            height: 1.3,
                          ),
                          maxLines: isTablet ? 3 : 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: isTablet ? 16 : 12),
                        
                        // Rating row - Better alignment
                        Row(
                          children: [
                            ...List.generate(
                              5,
                              (index) => Icon(Icons.star,
                                  color: const Color(0xFFFFC107), 
                                  size: isTablet ? 18 : 16),
                            ),
                            SizedBox(width: isTablet ? 12 : 8),
                            Text(
                              rating,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: isTablet ? 15 : 13,
                                fontFamily: 'NotoSans',
                              ),
                            ),
                            SizedBox(width: isTablet ? 6 : 4),
                            Text(
                              '· $reviews',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isTablet ? 15 : 13,
                                fontFamily: 'NotoSans',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Action buttons - Better styling
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: isTablet ? 56 : 48,
                    child: ElevatedButton(
                      onPressed: onBookAppointment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF002180),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(isTablet ? 20 : 16),
                          ),
                        ),
                        textStyle: TextStyle(
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.w600,
                          fontSize: isTablet ? 17 : 15,
                        ),
                      ),
                      child: FittedBox(child: const Text('Book appointment')),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: isTablet ? 56 : 48,
                    child: ElevatedButton(
                      onPressed: onConsultNow,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF5F7FB),
                        foregroundColor: const Color(0xFF002180),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(isTablet ? 20 : 16),
                          ),
                        ),
                        textStyle: TextStyle(
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.w600,
                          fontSize: isTablet ? 17 : 15,
                        ),
                      ),
                      child: const Text('Consult now'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}