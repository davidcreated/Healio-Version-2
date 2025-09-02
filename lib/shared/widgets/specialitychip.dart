
// lib/shared/widgets/specialty_chip.dart
import 'package:flutter/material.dart';
import 'package:healio_version_2/core/constants/appcolors.dart';
import 'package:healio_version_2/core/constants/appconstants.dart';


class SpecialtyChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;

  const SpecialtyChip({
    Key? key,
    required this.label,
    required this.icon,
    this.isSelected = false,
    this.onTap,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingMD,
          vertical: AppConstants.spacingSM,
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? 
              (isSelected 
                  ? AppColors.primaryBlue 
                  : AppColors.surface),
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          border: Border.all(
            color: isSelected 
                ? AppColors.primaryBlue 
                : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: AppConstants.iconSizeSM,
              color: textColor ?? 
                  (isSelected 
                      ? AppColors.textOnPrimary 
                      : AppColors.iconPrimary),
            ),
            const SizedBox(width: AppConstants.spacingSM),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: textColor ?? 
                    (isSelected 
                        ? AppColors.textOnPrimary 
                        : AppColors.textPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}