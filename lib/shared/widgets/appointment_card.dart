// SEPARATE FILE: lib/src/widgets/appointment_card.dart
// ==============================================================================
import 'package:flutter/material.dart';
import 'package:healio_version_2/app/modules/appointments/controllers/appointment.dart';
// import '../models/appointment.dart';

/// Widget for displaying appointment information
class AppointmentCard extends StatelessWidget {
  final Appointment? appointment;
  final VoidCallback? onTap;

  const AppointmentCard({
    super.key,
    this.appointment,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 343,
            height: 171,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: appointment != null
                ? _buildAppointmentContent(appointment!)
                : _buildNoAppointmentContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentContent(Appointment appointment) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row with avatar and name
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(appointment.doctorImage),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.doctorName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      fontFamily: 'NotoSans',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: Text(
                      appointment.specialty,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        fontFamily: 'NotoSans',
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          // Bottom row with calendar and clock info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 100.0),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        color: Colors.green, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      appointment.date,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'NotoSans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.access_time,
                      color: Colors.green, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    appointment.duration,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'NotoSans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoAppointmentContent() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            color: Colors.grey,
            size: 48,
          ),
          SizedBox(height: 16),
          Text(
            'No upcoming appointments',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: 'NotoSans',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}