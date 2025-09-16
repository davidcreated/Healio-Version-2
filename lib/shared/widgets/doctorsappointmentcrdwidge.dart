import 'package:flutter/material.dart';

import 'package:healio_version_2/models/appointmentmodel.dart';
import 'package:healio_version_2/shared/widgets/callbuttonwidget.dart';
import 'package:healio_version_2/shared/widgets/chatbuttonwidget.dart';

// Today's Appointment Card Widget
class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;
  final VoidCallback onCall;
  final VoidCallback onChat;
  final VoidCallback onTap;

  const AppointmentCard({
    required this.appointment,
    required this.onCall,
    required this.onChat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 186,
          height: 151,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
            gradient: const LinearGradient(
              colors: [Color(0xFF002180), Color(0xFF003594)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    backgroundImage: appointment.patientImage.isNotEmpty
                        ? AssetImage(appointment.patientImage)
                        : null,
                    child: appointment.patientImage.isEmpty
                        ? const Icon(Icons.person, color: Color(0xFF002180))
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 77,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      appointment.time,
                      style: const TextStyle(
                        color: Color(0xFF002180),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  appointment.patientName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'NotoSans',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CallButton(onPressed: onCall),
                  ChatButton(onPressed: onChat),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
