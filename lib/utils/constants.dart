import 'package:flutter/material.dart';

/// Purple color for the app
const Color kPurpleColor = Color(0xFF8862FC);

/// Heading TextStyle for ForeCast Report Modal
const TextStyle kForeCastReportHeaderStyle = TextStyle(
  color: Colors.black,
  fontSize: 22,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.3
);
/// Heading TextStyle for ForeCast Report Modal
const TextStyle kNotificationHeaderStyle = TextStyle(
  color: Color(0xFF737272),
  fontSize: 13,
  fontWeight: FontWeight.w500,
);

/// Container Table Decoration for ForeCast Report Modal
Decoration kContainerDecoration = BoxDecoration(
  borderRadius:  BorderRadius.circular(11.01),
  border: Border.all(
    width: 0.55,
    color:  const Color(0xFFD5C7FF),
  ),
);