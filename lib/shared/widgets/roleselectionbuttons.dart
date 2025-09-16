import 'package:flutter/material.dart';
import 'package:healio_version_2/core/constants/appcolors.dart';
import 'package:healio_version_2/core/constants/appdurations.dart';
import 'package:healio_version_2/core/constants/appsizes.dart';
import 'package:healio_version_2/core/constants/apptextstyles.dart';
/// Custom widget for role selection buttons with improved animations
class RoleSelectionButton extends StatelessWidget {
  const RoleSelectionButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.roleSelectionButtonBorderRadius),
      
      splashColor: AppColors.roleSelectionSelectedColor.withOpacity(0.1),
      highlightColor: AppColors.roleSelectionSelectedColor.withOpacity(0.05),
      
      child: AnimatedContainer(
        duration: AppDurations.roleSelectionAnimationDuration,
        curve: Curves.easeInOut,
        width: double.infinity,
        height: AppSizes.roleSelectionButtonHeight,
        
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.roleSelectionSelectedColor
              : AppColors.roleSelectionUnselectedColor,
          borderRadius: BorderRadius.circular(AppSizes.roleSelectionButtonBorderRadius),
          
          border: Border.all(
            color: isSelected
                ? AppColors.roleSelectionSelectedColor
                : AppColors.roleSelectionUnselectedBorderColor,
            width: AppSizes.roleSelectionButtonBorderWidth,
          ),
          
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.roleSelectionSelectedColor.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                label == 'Doctor' ? Icons.local_hospital : Icons.person,
                color: isSelected ? Colors.black : Colors.black,
                size: 20,
              ),
              const SizedBox(width: 8),
              
              AnimatedDefaultTextStyle(
                duration: AppDurations.roleSelectionAnimationDuration,
                style: AppTextStyles.roleSelectionButtonTextStyle.copyWith(
                  color: isSelected ? Colors.black : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                child: Text(label),
              ),
              
              if (isSelected)
                const SizedBox(width: 8),
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }
}