import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/browsedoctors.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/patienthomepage.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/prescriptionscreen.dart';
import 'package:healio_version_2/Screens/PatientSection/signin/signin.dart';
import 'package:healio_version_2/Screens/PatientSection/signup/patientsignup.dart';
import 'package:healio_version_2/Screens/PatientSection/signup/signup.dart';
import 'package:healio_version_2/Screens/PatientSection/signup/signup2.dart';
import 'package:healio_version_2/Screens/PatientSection/verification/emailverification.dart';
import 'package:healio_version_2/Screens/PatientSection/verification/otpverification.dart';

import 'package:healio_version_2/Screens/Generalonboarding/splash2.dart';
import 'package:healio_version_2/Screens/Generalonboarding/splashpage1.dart';
import 'package:healio_version_2/Screens/Generalonboarding/splashpage3.dart';
import 'package:healio_version_2/Screens/Generalonboarding/welcomepage1.dart';
import 'package:healio_version_2/Screens/Generalonboarding/welcomepage2.dart';


class AppRoutes {

  AppRoutes._();
  // --- Route Names ---
  static const String splashPage1 = '/splash1';
  static const String splashPage2 = '/splash2';
  static const String splashPage3 = '/splash3';
  static const String welcomePage1 = '/welcomePage1';
  static const String welcomePage2 = '/welcomePage2';
  static const String patientSignUp = '/patientSignUp';
 static const String SignUp = '/SignUp';
 static const String emailverification = '/emailverification';
static const String otpVerification = '/otpverification';
static const String patienthomepage = '/patienthomepage';
static const String browsedoctors = '/browsedoctorspage';
static const String patientsigninpage = '/patientsigninpage';
static const String prescriptionpage = '/prescriptionpage';
 

  // --- Route Pages ---
static final List<GetPage> pages = [
  GetPage(
    name: splashPage1,
    page: () => const splashpage1(),
  ),
  GetPage(
    name: splashPage2,
    page: () => const Splashpage2(),
  ),
  GetPage(
    name: splashPage3,
    page: () => const Splashpage3(),
  ),
  GetPage(
    name: welcomePage1,
    page: () => const WelcomePage1(),
  ),
  GetPage(
    name: welcomePage2,
    page: () => const WelcomePage2(),
  ),
  GetPage(
    name: patientSignUp,
    page: () => const Patientsignup(),
  ),
   GetPage(
    name: SignUp,
    page: () => const PatientSignupPage(),
  ),
  GetPage(
    name: SignUp,
    page: () => const PatientProfileCompletionPage(),
  ),
  GetPage(
    name: emailverification,
    page: () => const EmailVerificationPage(),
  ),
GetPage(
    name: otpVerification,
    page: () => const OtpVerification(),
  ),
  GetPage(
    name: patienthomepage,
    page: () => const HomePage(),
  ),
GetPage(
    name: browsedoctors,
    page: () => const Browsedoctors(),
  ),
GetPage(
    name: patientsigninpage,
    page: () => const PatientSignInPage(),
  ),
GetPage(
    name: prescriptionpage,
    page: () => const Prescriptionpage(),
  ),
];






}
