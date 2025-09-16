import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:healio_version_2/Screens/DoctorSection/homepage/availability.dart';
import 'package:healio_version_2/Screens/DoctorSection/homepage/doctorshome.dart';
import 'package:healio_version_2/Screens/DoctorSection/homepage/patientData.dart';
import 'package:healio_version_2/Screens/DoctorSection/homepage/patientinfo.dart';
import 'package:healio_version_2/Screens/DoctorSection/signup/doctorsignup.dart';
import 'package:healio_version_2/Screens/DoctorSection/signup/doctorsignup2.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/IOT.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/PreliminaryQuestionPage.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/browsedoctors.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/chat.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/appointmentcheckoutpage.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/appointmentpage.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/bookappointment.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/connectIOT.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/consultationpaymentselectionpage.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/consultcheckutpage.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/consultpage.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/mentalhealth.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/mentalhealthsupportpage.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/patienthomepage.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/appointmentpaymentmethod.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/prescriptionscreen.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/privatetherapistconsult.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/therapistpage.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/videocall.dart';
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
  // --- Route Names --- Patient Section
  static const String splashPage1 = '/splash1';
  static const String splashPage2 = '/splash2';
  static const String splashPage3 = '/splash3';
  static const String welcomePage1 = '/welcomePage1';
  static const String welcomePage2 = '/welcomePage2';
  static const String patientSignUp = '/patientSignUp';
  static const String SignUp = '/SignUp';
  static const String SignUp2 = '/SignUp2';
  static const String emailverification = '/emailverification';
  static const String otpVerification = '/otpverification';
  static const String patienthomepage = '/patienthomepage';
  static const String browsedoctors = '/browsedoctorspage';
  static const String therapistconsult = '/therapistconsult';
  static const String therapistpage = '/therapistpage';
  static const String patientsigninpage = '/patientsigninpage';
  static const String prescriptionpage = '/prescriptionpage';
  static const String doctorsprofile = '/dcotorsprofile';
  static const String doctorsappointment = '/dcotorsappointment';
  static const String consultbookingpage = '/consultbookingpage';
  static const String appointmentcheckout = '/appointmentcheckout';
   static const String consultationcheckout = '/consultationcheckout';
  static const String appointmentpaymentselectionpage = '/appointmentpaymentselectionpage';
   static const String consultationpaymentselectionpage = '/consultationpaymentselectionpage';
  static const String mentalhealth = '/mentalhealth';
  static const String mentalhealthsupportpage = '/mentalhealthsupportpage';
  static const String chatpage = '/chatpage';
  static const String videocallpage = '/videocallpage';
  static const String preliminaryQuestions = '/preliminary-questions';
static const String iotRequirementPage = '/iot-requirement';
static const String connectIOTPage = '/connect-iot';






// --- Route Names --- Doctors Section

static const String doctorSignUp = '/doctorSignUp';
static const String doctorSignUp2 = '/doctorSignUp2';
static const String availability = '/availability';
static const String doctorshome = '/doctorshome';
static const String patientinfo = '/patientinfo';
static const String patientdata = '/patientdata';





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
      name: SignUp2,
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
    GetPage(
      name: doctorsprofile,
      page: () => const Bookappointment(),
    ),
    GetPage(
      name: doctorsappointment,
      page: () => const AppointmentBookingPage(),
    ),
    GetPage(
      name: appointmentcheckout,
      page: () => const AppointmentCheckoutPage(),
    ),
   
     GetPage(
      name: consultationcheckout,
      page: () => const ConsultationCheckoutPage(),
    ),
    GetPage(
      name: appointmentpaymentselectionpage,
      page: () => const AppointmentPaymentSelectionPage(),
    ),
    GetPage(
      name: consultationpaymentselectionpage,
      page: () => const Consultationpaymentselectionpage(),
    ),
    GetPage(
      name: mentalhealth,
      page: () => const MentalHealthResourcesPage(),
    ),
      GetPage(
        name: mentalhealthsupportpage,
        page: () => const MentalHealthSupportPage(),
      ),
     GetPage(
      name: chatpage,
      page: () => const ChatPage(),
    ),
    GetPage(name: videocallpage, page: () => const VideoCallPage()),

    GetPage(
      name: preliminaryQuestions,
      page: () => const PreliminaryQuestionPage(),
    ),
     GetPage(
      name: therapistconsult,
      page: () => const Privatetherapistconsult(),
    ),
    GetPage(
      name: therapistpage,
      page: () => const Therapistpage(),
    ),
    GetPage(
      name: consultbookingpage,
      page: () => const ConsultBookingPage(),
    ),
GetPage(
      name: iotRequirementPage,
      page: () => const IOTSystemRequirementPage(),
    ),
    GetPage(
      name: connectIOTPage,
      page: () => const ConnectIOTPage(),
    ),


    // --- Route Pages --- DOCTOR SECTION 
    GetPage(
      name: doctorSignUp,
      page: () => const DoctorSignupPage(),
    ),
    GetPage(
      name: doctorSignUp2,
      page: () => const Doctorsignup2(),
    ),
    GetPage(
      name: availability,
      page: () => const Availability(),
    ),
    GetPage(
      name: doctorshome,
      page: () => const DoctorsHome(),
    ),
    GetPage(
      name: patientinfo,
      page: () => const PatientInformationPage(),
    ),
  GetPage(
      name: patientdata,
      page: () => const PatientDataPage(),
    ),
  ];
} 