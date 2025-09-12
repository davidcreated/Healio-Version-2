import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/videocall.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class Message {
  final String id;
  final String text;
  final bool isFromUser;
  final DateTime timestamp;
  final String? attachmentPath;
  final MessageType type;

  Message({
    required this.id,
    required this.text,
    required this.isFromUser,
    required this.timestamp,
    this.attachmentPath,
    this.type = MessageType.text,
  });
}

enum MessageType {
  text,
  image,
  audio,
  file,
}

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  
  // Reactive variables
  final RxList<Message> messages = <Message>[].obs;
  final RxBool isTyping = false.obs;
  final RxBool isRecording = false.obs;
  final RxBool isOnline = true.obs;
  final RxString connectionStatus = 'Online'.obs;
  
  // Doctor info
  final RxString doctorName = 'Dr. Sarah U.'.obs;
  final RxString doctorSpecialty = 'Cardiologist'.obs;
  final RxString doctorLocation = 'Uyo Nigeria'.obs;
  final RxString doctorImage = 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=150'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialMessages();
    _simulateTypingStatus();
  }

  /// Load initial chat messages
  void _loadInitialMessages() {
    messages.addAll([
      Message(
        id: '1',
        text: 'Hello Mr. Uduak Samson, please wait for a while. Dr. Sarah will join you soon.',
        isFromUser: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      Message(
        id: '2',
        text: 'Good morning. I\'m Dr. Sarah, how can I help you today?',
        isFromUser: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
      ),
      Message(
        id: '3',
        text: 'Can you please describe your symptoms?',
        isFromUser: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
      ),
      Message(
        id: '4',
        text: 'Good morning dr. I feel pain in my head. It feels like someone hit my head with hammer.',
        isFromUser: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      ),
      Message(
        id: '5',
        text: 'When did it start?',
        isFromUser: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      ),
      Message(
        id: '6',
        text: 'Dr. please can we have a video call? I can\'t type very well now.',
        isFromUser: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
      ),
      Message(
        id: '7',
        text: 'Okay, alright then.',
        isFromUser: false,
        timestamp: DateTime.now().subtract(const Duration(seconds: 30)),
      ),
    ]);
    
    // Auto scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  /// Simulate doctor typing status
  void _simulateTypingStatus() {
    // Simulate random typing indicators
    Timer.periodic(const Duration(seconds: 15), (timer) {
      if (messages.length > 7) {
        isTyping.value = true;
        Future.delayed(const Duration(seconds: 3), () {
          isTyping.value = false;
          // Occasionally add a doctor response
          if (DateTime.now().millisecond % 3 == 0) {
            _addDoctorResponse();
          }
        });
      }
    });
  }

  /// Add automatic doctor responses
  void _addDoctorResponse() {
    final responses = [
      'I understand your concern. Let me help you with that.',
      'Can you tell me more about when this started?',
      'Have you experienced this before?',
      'Let me check your symptoms.',
      'I\'d like to schedule a follow-up for you.',
    ];
    
    final randomResponse = responses[DateTime.now().millisecond % responses.length];
    
    Future.delayed(const Duration(seconds: 2), () {
      final message = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: randomResponse,
        isFromUser: false,
        timestamp: DateTime.now(),
      );
      
      messages.add(message);
      _scrollToBottom();
    });
  }

  /// Send a text message
  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isFromUser: true,
      timestamp: DateTime.now(),
    );

    messages.add(message);
    messageController.clear();
    _scrollToBottom();

    // Simulate doctor response after user message
    Future.delayed(const Duration(seconds: 2), () {
      isTyping.value = true;
      Future.delayed(const Duration(seconds: 2), () {
        isTyping.value = false;
        _addDoctorResponse();
      });
    });
  }

  /// Handle file attachment
  Future<void> attachFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        final file = result.files.single;
        final message = Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: 'Shared a file: ${file.name}',
          isFromUser: true,
          timestamp: DateTime.now(),
          attachmentPath: file.path,
          type: _getMessageType(file.extension ?? ''),
        );

        messages.add(message);
        _scrollToBottom();

        Get.snackbar(
          'File Shared',
          'File "${file.name}" has been shared successfully',
          backgroundColor: Colors.green.shade400,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to attach file. Please try again.',
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  /// Get message type based on file extension
  MessageType _getMessageType(String extension) {
    switch (extension.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return MessageType.image;
      case 'mp3':
      case 'wav':
      case 'm4a':
        return MessageType.audio;
      default:
        return MessageType.file;
    }
  }

  /// Start/stop voice recording
  void toggleRecording() {
    if (isRecording.value) {
      // Stop recording
      isRecording.value = false;
      _sendVoiceMessage();
    } else {
      // Start recording
      isRecording.value = true;
      Get.snackbar(
        'Recording',
        'Voice recording started. Tap the mic again to stop.',
        backgroundColor: Colors.blue.shade400,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  /// Send voice message
  void _sendVoiceMessage() {
    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: 'Voice message (${DateTime.now().second}s)',
      isFromUser: true,
      timestamp: DateTime.now(),
      type: MessageType.audio,
    );

    messages.add(message);
    _scrollToBottom();

    Get.snackbar(
      'Voice Message',
      'Voice message sent successfully',
      backgroundColor: Colors.green.shade400,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  /// Start video call with real Agora SDK integration
  Future<void> startVideoCall() async {
    try {
      // Show connecting dialog
      Get.dialog(
        AlertDialog(
          title: const Text('Connecting Call'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(doctorImage.value),
              ),
              const SizedBox(height: 16),
              Text('Connecting to ${doctorName.value}...'),
              const SizedBox(height: 16),
              const CircularProgressIndicator(),
            ],
          ),
        ),
        barrierDismissible: false,
      );

      // Simulate connection delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Close connecting dialog
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      // Navigate to video call page with payment info
      final result = await Get.to(
        () => const VideoCallPage(),
        arguments: {
          'doctorName': doctorName.value,
          'doctorImage': doctorImage.value,
          'doctorSpecialty': doctorSpecialty.value,
          'amount': 10000.0, // Default ₦10,000 for 10 minutes
          'channelName': 'chat_${DateTime.now().millisecondsSinceEpoch}',
          'userId': 'user_123', // In real app, get from auth
          'doctorId': 'doctor_456', // In real app, get from chat
        },
      );

      // Handle call result
      if (result != null && result is Map<String, dynamic>) {
        final duration = result['duration'] ?? '00:00';
        final cost = result['cost']?.toStringAsFixed(0) ?? '0';
        final successful = result['successful'] ?? false;

        if (successful) {
          // Add call summary message to chat
          final callSummaryMessage = Message(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            text: 'Video call completed\nDuration: $duration\nCost: ₦$cost',
            isFromUser: false,
            timestamp: DateTime.now(),
            type: MessageType.text,
          );
          
          messages.add(callSummaryMessage);
          _scrollToBottom();

          Get.snackbar(
            'Call Completed',
            'Call duration: $duration - Cost: ₦$cost',
            backgroundColor: Colors.green.shade400,
            colorText: Colors.white,
            duration: const Duration(seconds: 5),
          );
        }
      }
      
    } catch (e) {
      // Close any open dialogs
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      
      Get.snackbar(
        'Call Failed',
        'Unable to start video call. Please try again.',
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  /// Start voice call
  Future<void> startVoiceCall() async {
    try {
      // In a real app, you would use a calling service
      final Uri telUri = Uri(scheme: 'tel', path: '+234-XXX-XXX-XXXX');
      
      if (await canLaunchUrl(telUri)) {
        await launchUrl(telUri);
      } else {
        Get.snackbar(
          'Voice Call',
          'Starting voice call with ${doctorName.value}...',
          backgroundColor: Colors.green.shade400,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to start voice call. Please try again.',
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  /// Navigate back
  void goBack() {
    Get.back();
  }

  /// Scroll to bottom of chat
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// Format time for display
  String formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    
    if (messageDate == today) {
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      return '${dateTime.day}/${dateTime.month} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}