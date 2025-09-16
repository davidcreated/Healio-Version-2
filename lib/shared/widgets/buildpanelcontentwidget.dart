import 'package:flutter/material.dart';
import 'package:healio_version_2/app/modules/auth/controllers/patientsignupcontroller.dart';
import 'package:healio_version_2/shared/widgets/buildcontinuebutton.dart';
import 'package:healio_version_2/shared/widgets/buildheader.dart';
import 'package:healio_version_2/shared/widgets/buildroleselectionbuttons.dart' show buildRoleSelectionButtons;


  /// Enhanced panel content with better spacing
  Widget buildPanelContent(PatientSignupController controller) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with improved styling
          buildHeader(controller),
          const SizedBox(height: 32),
          // Role selection buttons with better design
          buildRoleSelectionButtons(controller),
          const SizedBox(height: 24),
          // Continue button
          buildContinueButton(controller),
        ],
      ),
    );
  }