  /// Enhanced bottom panel with improved design
import 'package:flutter/material.dart';
import 'package:healio_version_2/app/modules/auth/controllers/patientsignupcontroller.dart';
import 'package:healio_version_2/shared/widgets/buildpanelcontentwidget.dart';
  Widget buildBottomPanel(PatientSignupController controller) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SlideTransition(
        position: controller.slideAnimation,
        child: Container(
          margin: const EdgeInsets.all(16), // Add margin for better appearance
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24), // More rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: FadeTransition(
            opacity: controller.fadeAnimation,
            child: buildPanelContent(controller),
          ),
        ),
      ),
    );
  }