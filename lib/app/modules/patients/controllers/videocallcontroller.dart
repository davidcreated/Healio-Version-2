import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';


class VideoCallController extends GetxController {
  // Agora RTC Engine
  RtcEngine? _agoraEngine;
  final RxInt remoteUid = 0.obs;
  final RxBool isJoined = false.obs;
  
  // Getter for agoraEngine - THIS IS WHAT WAS MISSING
  RtcEngine? get agoraEngine => _agoraEngine;
  
  // Camera and video controls
  CameraController? cameraController;
  final RxBool isCameraInitialized = false.obs;
  final RxBool isFrontCamera = true.obs;
  final RxBool isVideoEnabled = true.obs;
  final RxBool isAudioEnabled = true.obs;
  final RxBool isCallConnected = false.obs;
  
  // Call timing and payment
  final RxInt remainingSeconds = 0.obs;
  final RxString callDuration = '00:00'.obs;
  final RxDouble paymentAmount = 0.0.obs;
  Timer? callTimer;
  Timer? paymentTimer;
  int totalCallSeconds = 0;
  
  // Call participants data from chat
  final RxString doctorName = 'Dr. Sarah Udy'.obs;
  final RxString doctorSpecialty = 'Certified Cardiologist'.obs;
  final RxString doctorImage = 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400'.obs;
  final RxString patientName = 'You'.obs;
  
  // Agora credentials - Replace with your actual Agora credentials
  static const String appId = "YOUR_AGORA_APP_ID"; // Replace with your Agora App ID
  static const String token = ""; // Use empty string for testing, generate token for production
  String channelName = 'default_channel';
  int userId = 12345;
  
  // Getter for channelName to access from UI
  String get currentChannelName => channelName;
  
  // UI States
  final RxBool showControls = true.obs;
  final RxBool isMinimized = false.obs;
  final RxBool isCallEnding = false.obs;
  
  // Payment rates (per minute)
  static const double RATE_PER_MINUTE = 1000.0; // ₦1000 per minute
  static const int WARNING_TIME_SECONDS = 60; // Warning 1 minute before end

  @override
  void onInit() {
    super.onInit();
    _initializeCall();
  }

  /// Initialize video call with data from chat
  Future<void> _initializeCall() async {
    try {
      // Get data from chat controller
      final arguments = Get.arguments as Map<String, dynamic>?;
      
      if (arguments != null) {
        doctorName.value = arguments['doctorName'] ?? 'Dr. Sarah Udy';
        doctorImage.value = arguments['doctorImage'] ?? doctorImage.value;
        doctorSpecialty.value = arguments['doctorSpecialty'] ?? doctorSpecialty.value;
        paymentAmount.value = arguments['amount']?.toDouble() ?? 10000.0;
        channelName = arguments['channelName'] ?? 'default_channel';
        userId = arguments['userId']?.hashCode ?? 12345;
      }
      
      // Calculate call duration based on payment
      final maxMinutes = paymentAmount.value / RATE_PER_MINUTE;
      remainingSeconds.value = (maxMinutes * 60).floor();
      
      // Request permissions
      await _requestPermissions();
      
      // Initialize Agora
      await _initializeAgora();
      
      // Initialize camera for local preview
      await _initializeCamera();
      
      // Start call
      await _startCall();
      
    } catch (e) {
      _handleCallError('Failed to initialize call: $e');
    }
  }

  /// Request camera and microphone permissions
  Future<void> _requestPermissions() async {
    final permissions = [
      Permission.camera,
      Permission.microphone,
    ];

    Map<Permission, PermissionStatus> statuses = await permissions.request();
    
    for (var permission in permissions) {
      if (statuses[permission] != PermissionStatus.granted) {
        throw Exception('${permission.toString().split('.').last} permission denied');
      }
    }
  }

  /// Initialize Agora RTC Engine
  Future<void> _initializeAgora() async {
    try {
      // Create RTC engine
      _agoraEngine = createAgoraRtcEngine();
      
      // Initialize engine
      await _agoraEngine!.initialize(RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ));

      // Register event handlers
      _agoraEngine!.registerEventHandler(RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("Local user ${connection.localUid} joined channel");
          isJoined.value = true;
          isCallConnected.value = true;
        },
        onUserJoined: (RtcConnection connection, int uid, int elapsed) {
          debugPrint("Remote user $uid joined");
          remoteUid.value = uid;
        },
        onUserOffline: (RtcConnection connection, int uid, UserOfflineReasonType reason) {
          debugPrint("Remote user $uid left channel");
          remoteUid.value = 0;
          if (reason == UserOfflineReasonType.userOfflineDropped) {
            Get.snackbar(
              'Connection Lost',
              'The doctor has disconnected from the call',
              backgroundColor: Colors.orange,
              colorText: Colors.white,
            );
          }
        },
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          debugPrint("Left channel");
          isJoined.value = false;
          remoteUid.value = 0;
        },
        onConnectionStateChanged: (RtcConnection connection, 
            ConnectionStateType state, ConnectionChangedReasonType reason) {
          debugPrint("Connection state changed: $state, reason: $reason");
          
          if (state == ConnectionStateType.connectionStateConnected) {
            isCallConnected.value = true;
          } else if (state == ConnectionStateType.connectionStateFailed) {
            _handleCallError('Connection failed');
          }
        },
      ));

      // Enable video and audio
      await _agoraEngine!.enableVideo();
      await _agoraEngine!.enableAudio();
      
      // Set video configuration
      await _agoraEngine!.setVideoEncoderConfiguration(
        const VideoEncoderConfiguration(
          dimensions: VideoDimensions(width: 640, height: 480),
          frameRate: 15,
          bitrate: 400,
        ),
      );
      
    } catch (e) {
      debugPrint('Agora initialization error: $e');
      throw Exception('Failed to initialize video calling service');
    }
  }

  /// Initialize camera for local preview
  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        debugPrint('No cameras available');
        return; // Don't throw error - video call can work without local camera preview
      }

      // Start with front camera
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false, // Audio handled by Agora
      );

      await cameraController!.initialize();
      isCameraInitialized.value = true;
      
    } catch (e) {
      debugPrint('Camera initialization error: $e');
      // Don't throw error - video call can work without local camera preview
    }
  }

  /// Start the video call by joining Agora channel
  Future<void> _startCall() async {
    try {
      if (_agoraEngine == null) {
        throw Exception('Agora engine not initialized');
      }

      // Join channel
      await _agoraEngine!.joinChannel(
        token: token.isEmpty ? "" : token,
        channelId: channelName,
        uid: userId,
        options: const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
          channelProfile: ChannelProfileType.channelProfileCommunication,
        ),
      );

      // Start call timer
      _startCallTimer();
      
      // Hide controls after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        showControls.value = false;
      });
      
    } catch (e) {
      throw Exception('Failed to join video call: $e');
    }
  }

  /// Start call duration timer
  void _startCallTimer() {
    callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      totalCallSeconds++;
      remainingSeconds.value--;
      
      // Update call duration display
      final minutes = totalCallSeconds ~/ 60;
      final seconds = totalCallSeconds % 60;
      callDuration.value = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      
      // Check for warnings and call end
      _checkCallTimeWarnings();
    });
  }

  /// Check for time warnings and call end
  void _checkCallTimeWarnings() {
    if (remainingSeconds.value <= 0) {
      // Time's up - end call
      _endCallDueToTimeout();
    } else if (remainingSeconds.value == WARNING_TIME_SECONDS) {
      // Show 1-minute warning
      _showTimeWarning('1 minute remaining');
    } else if (remainingSeconds.value == 30) {
      // Show 30-second warning
      _showTimeWarning('30 seconds remaining');
    } else if (remainingSeconds.value <= 10 && remainingSeconds.value > 0) {
      // Show countdown for last 10 seconds
      _showTimeWarning('${remainingSeconds.value} seconds remaining');
    }
  }

  /// Show time warning popup
  void _showTimeWarning(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text('Call Time Warning'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.access_time,
              size: 48,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Add more credit to continue the call',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
          if (remainingSeconds.value > 30)
            ElevatedButton(
              onPressed: _extendCallTime,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Add Credit'),
            ),
        ],
      ),
      barrierDismissible: false,
    );

    // Auto dismiss warning after 3 seconds
    if (remainingSeconds.value > 10) {
      Future.delayed(const Duration(seconds: 3), () {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      });
    }
  }

  /// End call due to timeout
  void _endCallDueToTimeout() {
    Get.dialog(
      AlertDialog(
        title: const Text('Call Ended'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.call_end,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'Your call time has expired',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Call duration: ${callDuration.value}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Amount used: ₦${(totalCallSeconds / 60 * RATE_PER_MINUTE).toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close dialog
              endCall(); // End call
            },
            child: const Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  /// Extend call time (add more credit)
  void _extendCallTime() {
    Get.back(); // Close warning dialog
    
    // Show credit addition dialog
    Get.dialog(
      AlertDialog(
        title: const Text('Add Credit'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select additional call time:'),
            const SizedBox(height: 16),
            ...[5000, 10000, 15000].map((amount) => 
              ListTile(
                title: Text('₦$amount (${amount ~/ RATE_PER_MINUTE} minutes)'),
                onTap: () {
                  _addCallCredit(amount.toDouble());
                  Get.back();
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  /// Add call credit
  void _addCallCredit(double amount) {
    final additionalMinutes = amount / RATE_PER_MINUTE;
    final additionalSeconds = (additionalMinutes * 60).floor();
    
    remainingSeconds.value += additionalSeconds;
    paymentAmount.value += amount;
    
    Get.snackbar(
      'Credit Added',
      '${additionalMinutes.floor()} minutes added to your call',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  /// Toggle video on/off
  Future<void> toggleVideo() async {
    if (_agoraEngine == null) return;
    
    try {
      isVideoEnabled.value = !isVideoEnabled.value;
      
      if (isVideoEnabled.value) {
        await _agoraEngine!.enableLocalVideo(true);
        await _initializeCamera();
      } else {
        await _agoraEngine!.enableLocalVideo(false);
        cameraController?.dispose();
        isCameraInitialized.value = false;
      }
    } catch (e) {
      debugPrint('Error toggling video: $e');
    }
  }

  /// Toggle audio mute
  Future<void> toggleAudio() async {
    if (_agoraEngine == null) return;
    
    try {
      isAudioEnabled.value = !isAudioEnabled.value;
      await _agoraEngine!.muteLocalAudioStream(!isAudioEnabled.value);
    } catch (e) {
      debugPrint('Error toggling audio: $e');
    }
  }

  /// Toggle camera (front/back)
  Future<void> toggleCamera() async {
    if (_agoraEngine == null) return;
    
    try {
      await _agoraEngine!.switchCamera();
      isFrontCamera.value = !isFrontCamera.value;
      
      // Also update local camera preview if available
      if (isCameraInitialized.value) {
        final cameras = await availableCameras();
        final newCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == 
              (isFrontCamera.value ? CameraLensDirection.front : CameraLensDirection.back),
          orElse: () => cameras.first,
        );

        await cameraController!.dispose();
        
        cameraController = CameraController(
          newCamera,
          ResolutionPreset.medium,
          enableAudio: false,
        );

        await cameraController!.initialize();
        update();
      }
    } catch (e) {
      debugPrint('Error switching camera: $e');
    }
  }

  /// Toggle controls visibility
  void toggleControls() {
    showControls.value = !showControls.value;
    
    // Auto hide controls after 3 seconds if shown
    if (showControls.value) {
      Future.delayed(const Duration(seconds: 3), () {
        if (showControls.value) {
          showControls.value = false;
        }
      });
    }
  }

  /// Minimize call window
  void minimizeCall() {
    isMinimized.value = true;
  }

  /// Maximize call window
  void maximizeCall() {
    isMinimized.value = false;
  }

  /// End call and cleanup Agora resources
  Future<void> endCall() async {
    isCallEnding.value = true;
    
    try {
      // Leave Agora channel
      if (_agoraEngine != null && isJoined.value) {
        await _agoraEngine!.leaveChannel();
      }
    } catch (e) {
      debugPrint('Error leaving channel: $e');
    }
    
    // Clean up resources
    callTimer?.cancel();
    paymentTimer?.cancel();
    cameraController?.dispose();
    
    // Destroy Agora engine
    if (_agoraEngine != null) {
      await _agoraEngine!.release();
    }
    
    // Calculate final cost
    final finalCost = (totalCallSeconds / 60 * RATE_PER_MINUTE);
    
    // Show call summary and return to chat
    Future.delayed(const Duration(milliseconds: 500), () {
      Get.back(result: {
        'duration': callDuration.value,
        'cost': finalCost,
        'successful': true,
      });
    });
  }

  /// Handle call errors
  void _handleCallError(String error) {
    Get.snackbar(
      'Call Error',
      error,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 5),
    );
    
    // End call on error
    Future.delayed(const Duration(seconds: 2), () {
      endCall();
    });
  }

  /// Format remaining time
  String get formattedRemainingTime {
    final minutes = remainingSeconds.value ~/ 60;
    final seconds = remainingSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    callTimer?.cancel();
    paymentTimer?.cancel();
    cameraController?.dispose();
    
    // Clean up Agora resources
    if (_agoraEngine != null) {
      _agoraEngine!.leaveChannel();
      _agoraEngine!.release();
    }
    
    super.onClose();
  }
}