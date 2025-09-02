
// lib/shared/widgets/appointment_card.dart
import 'package:flutter/material.dart';
import 'package:healio_version_2/core/constants/appcolors.dart';
import 'package:healio_version_2/core/constants/appconstants.dart' show AppConstants;


enum AppointmentStatus { confirmed, pending, completed, cancelled }

class AppointmentCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String imageUrl;
  final DateTime appointmentDate;
  final String timeSlot;
  final AppointmentStatus status;
  final VoidCallback? onTap;
  final VoidCallback? onJoinPressed;
  final VoidCallback? onReschedulePressed;
  final VoidCallback? onCancelPressed;

  const AppointmentCard({
    Key? key,
    required this.doctorName,
    required this.specialty,
    required this.imageUrl,
    required this.appointmentDate,
    required this.timeSlot,
    required this.status,
    this.onTap,
    this.onJoinPressed,
    this.onReschedulePressed,
    this.onCancelPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: AppConstants.avatarSizeMD / 2,
                    backgroundImage: NetworkImage(imageUrl),
                    backgroundColor: AppColors.surfaceLight,
                  ),
                  const SizedBox(width: AppConstants.spacingMD),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctorName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingXS),
                        Text(
                          specialty,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusChip(),
                ],
              ),
              const SizedBox(height: AppConstants.spacingMD),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: AppConstants.iconSizeSM,
                    color: AppColors.iconPrimary,
                  ),
                  const SizedBox(width: AppConstants.spacingSM),
                  Text(
                    _formatDate(appointmentDate),
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingLG),
                  const Icon(
                    Icons.access_time,
                    size: AppConstants.iconSizeSM,
                    color: AppColors.iconPrimary,
                  ),
                  const SizedBox(width: AppConstants.spacingSM),
                  Text(
                    timeSlot,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spacingMD),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip() {
    Color backgroundColor;
    Color textColor;
    String statusText;

    switch (status) {
      case AppointmentStatus.confirmed:
        backgroundColor = AppColors.appointmentActive.withOpacity(0.1);
        textColor = AppColors.appointmentActive;
        statusText = 'Confirmed';
        break;
      case AppointmentStatus.pending:
        backgroundColor = AppColors.appointmentPending.withOpacity(0.1);
        textColor = AppColors.appointmentPending;
        statusText = 'Pending';
        break;
      case AppointmentStatus.completed:
        backgroundColor = AppColors.appointmentCompleted.withOpacity(0.1);
        textColor = AppColors.appointmentCompleted;
        statusText = 'Completed';
        break;
      case AppointmentStatus.cancelled:
        backgroundColor = AppColors.appointmentCancelled.withOpacity(0.1);
        textColor = AppColors.appointmentCancelled;
        statusText = 'Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingSM,
        vertical: AppConstants.spacingXS,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusXS),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    if (status == AppointmentStatus.completed || status == AppointmentStatus.cancelled) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        if (status == AppointmentStatus.confirmed && onJoinPressed != null) ...[
          Expanded(
            child: ElevatedButton(
              onPressed: onJoinPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: AppColors.textOnPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusSM),
                ),
              ),
              child: const Text('Join Call'),
            ),
          ),
          const SizedBox(width: AppConstants.spacingSM),
        ],
        if (onReschedulePressed != null) ...[
          Expanded(
            child: OutlinedButton(
              onPressed: onReschedulePressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryBlue,
                side: const BorderSide(color: AppColors.primaryBlue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusSM),
                ),
              ),
              child: const Text('Reschedule'),
            ),
          ),
        ],
        if (onCancelPressed != null) ...[
          const SizedBox(width: AppConstants.spacingSM),
          Expanded(
            child: OutlinedButton(
              onPressed: onCancelPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.error),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusSM),
                ),
              ),
              child: const Text('Cancel'),
            ),
          ),
        ],
      ],
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }
}