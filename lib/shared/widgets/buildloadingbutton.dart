 import "package:flutter/material.dart";
import "package:healio_version_2/Screens/PatientSection/signup/signup2.dart" as AppColors;
import "package:healio_version_2/core/constants/appsizes.dart";


  /// Loading button with spinner
  Widget buildLoadingButton() {
    return ElevatedButton(
      onPressed: null, // Disabled during loading
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor.withOpacity(0.7),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.buttonBorderRadius),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          SizedBox(width: 12),
          Text('Creating Account...'),
        ],
      ),
    );
  }
