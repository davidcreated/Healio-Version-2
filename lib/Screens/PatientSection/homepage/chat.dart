import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:healio_version_2/app/modules/patients/controllers/chatcontrollers.dart';

// Import your controller file
// import 'chat_controller.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: _buildAppBar(controller),
      body: Column(
        children: [
          // Chat messages area
          Expanded(
            child: _buildMessagesArea(controller),
          ),
          
          // Typing indicator
          _buildTypingIndicator(controller),
          
          // Message input area
          _buildMessageInput(controller),
        ],
      ),
    );
  }

  /// Build app bar with doctor info and call buttons
  PreferredSizeWidget _buildAppBar(ChatController controller) {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Container(
           padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF002180),
                borderRadius: BorderRadius.circular(8),
              ),
          child: const Icon(Icons.arrow_back, color: Colors.white)),
        onPressed: controller.goBack,
      ),
      title: Obx(() => Row(
        children: [
          // Doctor avatar
          Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(controller.doctorImage.value),
              ),
              // Online status indicator
              if (controller.isOnline.value)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          
          // Doctor info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      controller.doctorName.value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF061234),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.verified,
                      size: 16,
                      color:const Color(0xFF002180),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        controller.doctorSpecialty.value,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.red.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.location_on,
                      size: 12,
                      color: Color(0xff007F67),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      controller.doctorLocation.value,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
      actions: [
        // Voice call button
        IconButton(
          icon: const Icon(
            Icons.phone,
            color: Color(0xFF007F67),
            size: 24,
          ),
          onPressed: controller.startVoiceCall,
        ),
        
        // Video call button
        IconButton(
          icon: const Icon(
            Icons.videocam,
            color: Color(0xFF007F67),
            size: 26,
          ),
          onPressed: controller.startVideoCall,
        ),
        
        const SizedBox(width: 8),
      ],
    );
  }

  /// Build messages area
  Widget _buildMessagesArea(ChatController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Today indicator
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: const Text(
              'Today',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          
          // Messages list
          Expanded(
            child: Obx(() {
              if (controller.messages.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 64,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Start your conversation with ${controller.doctorName.value}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Send a message to begin your consultation',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              
              return ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return _buildMessageBubble(message, controller);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  /// Build individual message bubble
  Widget _buildMessageBubble(Message message, ChatController controller) {
    final isFromUser = message.isFromUser;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isFromUser 
            ? MainAxisAlignment.end 
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isFromUser) ...[
            // Doctor avatar for doctor messages
            CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(controller.doctorImage.value),
            ),
            const SizedBox(width: 8),
          ],
          
          // Message bubble
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: Get.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: isFromUser 
                    ? const Color(0xFF002180)
                    : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Message content based on type
                  _buildMessageContent(message, isFromUser),
                  
                  const SizedBox(height: 4),
                  
                  // Timestamp
                  Text(
                    controller.formatTime(message.timestamp),
                    style: TextStyle(
                      fontSize: 10,
                      color: isFromUser 
                          ? Colors.white70 
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          if (isFromUser) const SizedBox(width: 40),
        ],
      ),
    );
  }

  /// Build message content based on type
  Widget _buildMessageContent(Message message, bool isFromUser) {
    switch (message.type) {
      case MessageType.image:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 40, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message.text,
              style: TextStyle(
                fontSize: 14,
                color: isFromUser ? Colors.white : Colors.black87,
              ),
            ),
          ],
        );
        
      case MessageType.audio:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.mic,
              size: 16,
              color: isFromUser ? Colors.white : const Color(0xFF002180),
            ),
            const SizedBox(width: 8),
            Text(
              message.text,
              style: TextStyle(
                fontSize: 14,
                color: isFromUser ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.play_arrow,
              size: 16,
              color: isFromUser ? Colors.white : const Color(0xFF002180),
            ),
          ],
        );
        
      case MessageType.file:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.attachment,
              size: 16,
              color: isFromUser ? Colors.white : const Color(0xFF002180),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                message.text,
                style: TextStyle(
                  fontSize: 14,
                  color: isFromUser ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ],
        );
        
      default:
        return Text(
          message.text,
          style: TextStyle(
            fontSize: 14,
            color: isFromUser ? Colors.white : Colors.black87,
            height: 1.4,
          ),
        );
    }
  }

  /// Build typing indicator
  Widget _buildTypingIndicator(ChatController controller) {
    return Obx(() => AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: controller.isTyping.value ? 40 : 0,
      child: controller.isTyping.value
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(controller.doctorImage.value),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildTypingDot(0),
                        const SizedBox(width: 4),
                        _buildTypingDot(1),
                        const SizedBox(width: 4),
                        _buildTypingDot(2),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox(),
    ));
  }

  /// Build animated typing dots
  Widget _buildTypingDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + (index * 200)),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.5 + (value * 0.5),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  /// Build message input area
  Widget _buildMessageInput(ChatController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE0E6ED), width: 1),
        ),
      ),
      child: Row(
        children: [
          // Attachment button
          IconButton(
            onPressed: controller.attachFile,
            icon: const Icon(
              Icons.attach_file,
              color: Colors.grey,
              size: 24,
            ),
          ),
          
          // Message input field
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F2F5),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: controller.messageController,
                decoration: const InputDecoration(
                  hintText: 'Type your message here...',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                ),
                maxLines: null,
                textInputAction: TextInputAction.send,
                onSubmitted: (value) => controller.sendMessage(),
              ),
            ),
          ),
          
          const SizedBox(width: 8),
          
          // Voice recording / Send button
          Obx(() => GestureDetector(
            onTap: controller.messageController.text.trim().isNotEmpty
                ? controller.sendMessage
                : controller.toggleRecording,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: controller.isRecording.value 
                    ? Colors.red 
                    : const Color(0xFF002180),
                shape: BoxShape.circle,
              ),
              child: Icon(
                controller.messageController.text.trim().isNotEmpty
                    ? Icons.send
                    : controller.isRecording.value
                        ? Icons.stop
                        : Icons.mic,
                color: Colors.white,
                size: 20,
              ),
            ),
          )),
        ],
      ),
    );
  }
}

// Add this to your pubspec.yaml dependencies:
// dependencies:
//   get: ^4.6.6
//   file_picker: ^6.1.1
//   url_launcher: ^6.2.5