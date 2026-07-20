import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum VoiceState { idle, recording, recorded }

class SelectYourClassScreen extends StatefulWidget {
  const SelectYourClassScreen({super.key});

  @override
  State<SelectYourClassScreen> createState() => _SelectYourClassScreenState();
}

class _SelectYourClassScreenState extends State<SelectYourClassScreen> {
  VoiceState voiceState = VoiceState.idle;

  final Color bgColor = const Color(0xfffbf7ff);
  final Color fieldColor = const Color(0xffeef4ff);
  final Color primaryColor = const Color(0xff9B73E6);
  final Color borderColor = const Color(0xffb7c4d6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              const SizedBox(height: 12),

              // Header
              Row(
                children: [
                  const Icon(Icons.arrow_back, size: 22),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Select Your Class",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 22),
                ],
              ),

              const SizedBox(height: 28),

              _inputBox(hint: "Heading Or Title", height: 44),

              const SizedBox(height: 14),

              _inputBox(hint: "Description", height: 118, maxLines: 5),

              const SizedBox(height: 14),

              _attachmentBox(),

              const SizedBox(height: 10),

              Row(
                children: const [
                  Icon(Icons.info, size: 15, color: Colors.grey),
                  SizedBox(width: 5),
                  Text(
                    "Allow Pdf , Doc, Docx, Jpg ,Png, Mp3",
                    style: TextStyle(fontSize: 11, color: Color(0xff5c5c5c)),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              _voiceWidget(),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 65),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputBox({
    required String hint,
    required double height,
    int maxLines = 1,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: borderColor),
      ),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 12, color: Colors.black),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(10),

            child: SvgPicture.asset(
              "assets/icons/Group (8).svg", // Replace with your SVG path
              width: 25,
              height: 25,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  Widget _attachmentBox() {
    return CustomPaint(
      painter: DashedBorderPainter(),
      child: Container(
        width: double.infinity,
        height: 105,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/Group (9).svg", // Replace with your SVG path
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 6),
            Text(
              "Attachment",
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _voiceWidget() {
    switch (voiceState) {
      case VoiceState.idle:
        return GestureDetector(
          onTap: () {
            setState(() {
              voiceState = VoiceState.recording;
            });
          },
          child: Container(
            height: 46,
            decoration: BoxDecoration(
              color: fieldColor,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                const Text(
                  "Record Your Voice",
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                const Spacer(),
                Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.mic, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 6),
              ],
            ),
          ),
        );

      case VoiceState.recording:
        return GestureDetector(
          onTap: () {
            setState(() {
              voiceState = VoiceState.recorded;
            });
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: fieldColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xffb9b7ff), width: 1.3),
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                const Icon(Icons.mic, size: 18, color: Colors.red),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomPaint(
                    painter: WaveformPainter(color: primaryColor),
                    child: const SizedBox(height: 34),
                  ),
                ),
                const SizedBox(width: 8),
                const Text("0:12", style: TextStyle(fontSize: 10)),
                const SizedBox(width: 10),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.mic, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        );

      case VoiceState.recorded:
        return Container(
          height: 50,
          decoration: BoxDecoration(
            color: fieldColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              const Icon(Icons.play_arrow, size: 24, color: Color(0xff20345c)),
              const SizedBox(width: 8),
              Expanded(
                child: CustomPaint(
                  painter: WaveformPainter(color: primaryColor),
                  child: const SizedBox(height: 34),
                ),
              ),
              const SizedBox(width: 8),
              const Text("0:12", style: TextStyle(fontSize: 10)),
              const SizedBox(width: 14),
              GestureDetector(
                onTap: () {
                  setState(() {
                    voiceState = VoiceState.idle;
                  });
                },
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 19,
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        );
    }
  }
}

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double dashWidth = 8;
    const double dashSpace = 6;

    final paint = Paint()
      ..color = Colors.black54
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(8),
        ),
      );

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final extractPath = metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class WaveformPainter extends CustomPainter {
  final Color color;

  WaveformPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.8)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final Random random = Random(4);
    double x = 0;

    while (x < size.width) {
      final barHeight = 8 + random.nextDouble() * 24;
      final y1 = size.height / 2 - barHeight / 2;
      final y2 = size.height / 2 + barHeight / 2;

      canvas.drawLine(Offset(x, y1), Offset(x, y2), paint);
      x += 5;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
