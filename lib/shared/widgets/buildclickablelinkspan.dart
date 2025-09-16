  import 'package:flutter/material.dart';
import 'package:healio_version_2/core/constants/apptextstyles.dart';
import 'package:flutter/gestures.dart';
/// Clickable link span for terms and policy

  TextSpan buildClickableLinkSpan(String text, VoidCallback onTap) {
    return TextSpan(
      text: text,
      style: AppTextStyles.termsAndPolicyLinkStyle,
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }
