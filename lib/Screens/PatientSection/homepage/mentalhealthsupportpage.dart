import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/browsedoctors.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/mentalhealth.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/privatetherapistconsult.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/therapistpage.dart';
import 'package:healio_version_2/app/modules/patients/controllers/mentalhealtharticlecontroller.dart';


class MentalHealthSupportPage extends StatelessWidget {
  const MentalHealthSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MentalHealthController controller = Get.put(MentalHealthController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
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
                    onPressed: () => Get.back(),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Mental Health Support",
                  style: TextStyle(
                    color: Color(0xFF061234),
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    fontFamily: 'NotoSans',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            // Main banner
            Container(
              width: 370,
              height: 232,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('lib/assets/images/patient/consultation.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.45),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 60, 18, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "One-on-One Therapist\nConsultation",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            fontFamily: 'NotoSans',
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Qorem ipsum dolor sit amet,\nconsectetur adipiscing elit.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: 'NotoSans',
                          ),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            // FIX 1: Wrap the method call in a function
                            onPressed: () => Get.to(() => const  Therapistpage()),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF002180),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 8),
                                minimumSize: const Size(105, 36)),
                            child: const Text(
                              "Find a doctor",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'NotoSans',
                                fontSize: 15,
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
            const SizedBox(height: 26),
            const Text(
              "Anonymity & Private Session",
              style: TextStyle(
                color: Color(0xFF061234),
                fontWeight: FontWeight.w700,
                fontSize: 16,
                fontFamily: 'NotoSans',
              ),
            ),
            const SizedBox(height: 10),
            // Private Session Card
            Container(
              width: 343,
              decoration: BoxDecoration(
                color: const Color(0xFFD6E0F5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Private Session",
                            style: TextStyle(
                              color: Color(0xFF061234),
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              fontFamily: 'NotoSans',
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Qorem ipsum dolor sit amet, consectetur adipiscing elit.",
                            style: TextStyle(
                              color: Color(0xFF686868),
                              fontSize: 13,
                              fontFamily: 'NotoSans',
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            // FIX 2: Wrap the method call in a function
                            onPressed: () => Get.to(() => const Privatetherapistconsult()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF002180),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 6),
                              minimumSize: const Size(0, 32),
                            ),
                            child: const Text(
                              "Book session",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'NotoSans',
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Image.asset(
                        'lib/assets/images/patient/privatesession.png',
                        height: 70,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            const Text(
              "Self-Help Resources & Community Support",
              style: TextStyle(
                color: Color(0xFF061234),
                fontWeight: FontWeight.w700,
                fontSize: 16,
                fontFamily: 'NotoSans',
              ),
            ),
            const SizedBox(height: 10),
            // Resources & Support Card
            Container(
              width: 343,
              decoration: BoxDecoration(
                color: const Color(0xFFB8EBD4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Resources & Support",
                            style: TextStyle(
                              color: Color(0xFF061234),
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              fontFamily: 'NotoSans',
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Qorem ipsum dolor sit amet, consectetur adipiscing elit.",
                            style: TextStyle(
                              color: Color(0xFF686868),
                              fontSize: 13,
                              fontFamily: 'NotoSans',
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            // FIX 3: Wrap the method call in a function
                            onPressed: () => Get.to(() => const MentalHealthResourcesPage()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF002180),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 6),
                              minimumSize: const Size(0, 32),
                            ),
                            child: const Text(
                              "Resources",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'NotoSans',
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Image.asset(
                        'lib/assets/images/patient/resources.png',
                        height: 70,
                        fit: BoxFit.contain,
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