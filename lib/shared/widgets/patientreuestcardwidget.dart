// Patient Request Card


import 'package:flutter/material.dart';
import 'package:healio_version_2/models/patientrequetmodel.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/shared/widgets/requestactionbuttonwidget.dart';

class PatientRequestCard extends StatelessWidget {
  final PatientRequestModel request;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final VoidCallback onReschedule;

  const PatientRequestCard({
    required this.request,
    required this.onAccept,
    required this.onDecline,
    required this.onReschedule,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 171,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.grey[300]!, width: 0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(request.patientImage),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.patientName,
                        style: const TextStyle(
                          color: Color(0xFF002180),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'NotoSans',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        request.complaint,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                          fontFamily: 'NotoSans',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, color: Colors.orange, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            request.requestedTime,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                              fontFamily: 'NotoSans',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RequestActionButton(
                  text: 'Accept',
                  onPressed: request.status == PatientRequestStatus.pending 
                      ? onAccept 
                      : null,
                  isAccepted: request.status == PatientRequestStatus.accepted,
                ),
                RequestActionButton(
                  text: 'Decline',
                  onPressed: request.status == PatientRequestStatus.pending 
                      ? onDecline 
                      : null,
                  isDeclined: request.status == PatientRequestStatus.declined,
                ),
                RequestActionButton(
                  text: 'Reschedule',
                  onPressed: request.status == PatientRequestStatus.pending 
                      ? onReschedule 
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}