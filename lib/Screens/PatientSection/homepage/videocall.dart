
        import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:healio_version_2/app/modules/patients/controllers/videocallcontroller.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';



// Import your controller
// import 'video_call_controller.dart';

class VideoCallPage extends StatelessWidget {
  const VideoCallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VideoCallController controller = Get.put(VideoCallController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() => controller.isMinimized.value 
          ? _buildMinimizedCall(controller)
          : _buildFullScreenCall(controller)
      ),
    );
  }

  /// Build full screen call interface
  Widget _buildFullScreenCall(VideoCallController controller) {
    return Stack(
      children: [
        // Main video area (Doctor's video)
        _buildMainVideoArea(controller),
        
        // User's video (picture-in-picture)
        _buildUserVideoPreview(controller),
        
        // Top bar with timer and controls
        _buildTopBar(controller),
        
        // Bottom controls
        _buildBottomControls(controller),
        
        // Call status overlay
        _buildCallStatusOverlay(controller),
      ],
    );
  }

  /// Build main video area showing doctor's video
  Widget _buildMainVideoArea(VideoCallController controller) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.1),
              Colors.black.withOpacity(0.3),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Doctor's video (simulated with image)
            Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(controller.doctorImage.value),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            
            // Tap to show/hide controls
            GestureDetector(
              onTap: controller.toggleControls,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build user's video preview using Agora local video view
  Widget _buildUserVideoPreview(VideoCallController controller) {
    return Positioned(
      top: 100,
      right: 16,
      child: Obx(() => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 120,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: controller.isVideoEnabled.value && controller.agoraEngine != null
              ? AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: controller.agoraEngine!,
                    canvas: const VideoCanvas(uid: 0), // 0 for local user
                    //connection: RtcConnection(channelId: controller.currentChannelName),
                  ),
                )
              : Container(
                
                  color: Colors.grey.shade800,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.videocam_off,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'You',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      )),
    );
  }

  /// Build top bar with timer and status
  Widget _buildTopBar(VideoCallController controller) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Obx(() => AnimatedOpacity(
        opacity: controller.showControls.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(Get.context!).padding.top + 8,
            left: 16,
            right: 16,
            bottom: 16,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.7),
                Colors.transparent,
              ],
            ),
          ),
          child: Row(
            children: [
              // Back button
              IconButton(
                onPressed: controller.endCall,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              
              const Spacer(),
              
              // Call timer with remaining time
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: controller.remainingSeconds.value <= 60 
                      ? Colors.red.withOpacity(0.8)
                      : Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: controller.remainingSeconds.value <= 60 
                          ? Colors.white 
                          : Colors.green,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      controller.formattedRemainingTime,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              
              // Minimize button
              IconButton(
                onPressed: controller.minimizeCall,
                icon: const Icon(
                  Icons.minimize,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  /// Build bottom controls
  Widget _buildBottomControls(VideoCallController controller) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Obx(() => AnimatedOpacity(
        opacity: controller.showControls.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(Get.context!).padding.bottom + 16,
            left: 16,
            right: 16,
            top: 16,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.transparent,
              ],
            ),
          ),
          child: Column(
            children: [
              // Doctor info
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      controller.doctorName.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      controller.doctorSpecialty.value,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Control buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Chat button
                  _buildControlButton(
                    icon: Icons.chat_bubble,
                    onPressed: () {
                      // Open chat overlay
                      Get.snackbar(
                        'Chat',
                        'Chat feature coming soon!',
                        backgroundColor: Colors.blue,
                        colorText: Colors.white,
                      );
                    },
                    backgroundColor: Colors.blue.withOpacity(0.3),
                  ),
                  
                  // Camera toggle
                  _buildControlButton(
                    icon: controller.isVideoEnabled.value 
                        ? Icons.videocam 
                        : Icons.videocam_off,
                    onPressed: controller.toggleVideo,
                    backgroundColor: controller.isVideoEnabled.value 
                        ? Colors.white.withOpacity(0.2)
                        : Colors.red.withOpacity(0.3),
                  ),
                  
                  // Microphone toggle
                  _buildControlButton(
                    icon: controller.isAudioEnabled.value 
                        ? Icons.mic 
                        : Icons.mic_off,
                    onPressed: controller.toggleAudio,
                    backgroundColor: controller.isAudioEnabled.value 
                        ? Colors.white.withOpacity(0.2)
                        : Colors.red.withOpacity(0.3),
                  ),
                  
                  // Camera flip
                  _buildControlButton(
                    icon: Icons.flip_camera_ios,
                    onPressed: controller.toggleCamera,
                    backgroundColor: Colors.white.withOpacity(0.2),
                  ),
                  
                  // End call
                  _buildControlButton(
                    icon: Icons.call_end,
                    onPressed: controller.endCall,
                    backgroundColor: Colors.red,
                    isEndCall: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  /// Build control button
  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color backgroundColor,
    bool isEndCall = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: isEndCall ? 64 : 56,
        height: isEndCall ? 64 : 56,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: isEndCall ? null : Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: isEndCall ? 32 : 28,
        ),
      ),
    );
  }

  /// Build call status overlay
  Widget _buildCallStatusOverlay(VideoCallController controller) {
    return Obx(() {
      if (controller.isCallConnected.value) {
        return const SizedBox.shrink();
      }
      
      return Container(
        color: Colors.black.withOpacity(0.8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(controller.doctorImage.value),
              ),
              const SizedBox(height: 24),
              Text(
                'Connecting to ${controller.doctorName.value}...',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    });
  }

  /// Build minimized call window with real video
  Widget _buildMinimizedCall(VideoCallController controller) {
    return Positioned(
      top: 100,
      right: 16,
      child: GestureDetector(
        onTap: controller.maximizeCall,
        child: Container(
          width: 120,
          height: 160,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Stack(
            children: [
              // Doctor's video (minimized) using Agora
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Obx(() => controller.remoteUid.value != 0 && controller.agoraEngine != null
                    ? AgoraVideoView(
                        controller: VideoViewController.remote(
                          rtcEngine: controller.agoraEngine!,
                          canvas: VideoCanvas(uid: controller.remoteUid.value),
                          connection: RtcConnection(channelId: controller.currentChannelName),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(controller.doctorImage.value),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                ),
              ),
              
              // Timer overlay
              Positioned(
                top: 8,
                left: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    controller.callDuration.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              
              // End call button
              Positioned(
                bottom: 8,
                right: 8,
                child: GestureDetector(
                  onTap: controller.endCall,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.call_end,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Add this to your pubspec.yaml dependencies:
// dependencies:
//   get: ^4.6.6
//   camera: ^0.10.5+5
//   permission_handler: ^11.2.0