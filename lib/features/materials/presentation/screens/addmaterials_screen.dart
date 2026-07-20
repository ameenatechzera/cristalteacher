import 'dart:ui';

import 'package:flutter/material.dart';

class AddMaterialPage extends StatefulWidget {
  const AddMaterialPage({super.key});

  @override
  State<AddMaterialPage> createState() => _AddMaterialPageState();
}

class _AddMaterialPageState extends State<AddMaterialPage> {
  int selectedTab = 0;

  final List<String> tabs = ["Documents", "Links", "Notes"];

  final Color primaryColor = const Color(0xFF9B73E6);
  final Color fieldColor = const Color(0xFFF0F4FF);
  final Color darkColor = Colors.black;

  String? selectedStandard;
  String? selectedDivision;
  String? selectedSubject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 18),
            _buildTabBar(),
            const SizedBox(height: 18),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: selectedTab == 0
                    ? _buildDocumentsTab()
                    : selectedTab == 1
                    ? _buildLinksTab()
                    : _buildNotesTab(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 58),
              child: _buildSaveButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, size: 22, color: Colors.black),
          ),
          const Expanded(
            child: Center(
              child: Text(
                "Add Material",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(width: 22),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 42,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: darkColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final bool isSelected = selectedTab == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTab = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                height: double.infinity,
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Center(
                  child: Text(
                    tabs[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDocumentsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildUploadBox(),

        const SizedBox(height: 14),

        Row(
          children: const [
            Icon(Icons.info, size: 16, color: Colors.grey),
            SizedBox(width: 6),
            Text(
              "Allow Pdf , Doc, Docx, Jpg ,.Png",
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ],
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: _buildDropdownField(
                hint: "Standard",
                value: selectedStandard,
                items: const ["Class 8", "Class 9", "Class 10"],
                onChanged: (value) {
                  setState(() {
                    selectedStandard = value;
                  });
                },
                isRequired: true,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildDropdownField(
                hint: "Division",
                value: selectedDivision,
                items: const ["A", "B", "C"],
                onChanged: (value) {
                  setState(() {
                    selectedDivision = value;
                  });
                },
                isRequired: true,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        _buildDropdownField(
          hint: "Subject",
          value: selectedSubject,
          items: const ["Mathematics", "Physics", "Chemistry", "English"],
          onChanged: (value) {
            setState(() {
              selectedSubject = value;
            });
          },
        ),

        const SizedBox(height: 14),

        _buildTextField(
          hint: "Notes",
          height: 110,
          maxLines: 5,
          showBoldIcon: true,
        ),
      ],
    );
  }

  Widget _buildLinksTab() {
    return Column(
      children: [
        _buildTextField(hint: "Links", height: 48, maxLines: 1),

        const SizedBox(height: 14),

        _buildTextField(
          hint: "Notes",
          height: 118,
          maxLines: 5,
          showBoldIcon: true,
        ),
      ],
    );
  }

  Widget _buildNotesTab() {
    return _buildTextField(
      hint: "Enter Your Not here",
      height: 330,
      maxLines: 15,
      showBoldIcon: true,
    );
  }

  Widget _buildUploadBox() {
    return CustomPaint(
      painter: DashedBorderPainter(),
      child: Container(
        width: double.infinity,
        height: 108,
        decoration: BoxDecoration(
          color: fieldColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                color: Colors.blue.shade600,
                size: 28,
              ),
              const SizedBox(height: 4),
              Text(
                "Choose File",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue.shade700,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    bool isRequired = false,
  }) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.black54,
          ),
          hint: _requiredText(hint, isRequired),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(fontSize: 13, color: Colors.black),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _requiredText(String text, bool isRequired) {
    if (!isRequired) {
      return Text(
        text,
        style: const TextStyle(fontSize: 13, color: Colors.black),
      );
    }

    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(fontSize: 13, color: Colors.black),
        children: const [
          TextSpan(
            text: "*",
            style: TextStyle(
              color: Colors.red,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required double height,
    required int maxLines,
    bool showBoldIcon = false,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        maxLines: maxLines,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 12, color: Colors.black87),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
          suffixIcon: showBoldIcon
              ? Padding(
                  padding: const EdgeInsets.only(top: 10, right: 8),
                  child: Align(
                    alignment: Alignment.topRight,
                    widthFactor: 1,
                    heightFactor: 1,
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text(
                          "B",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        onPressed: () {},
        child: const Text(
          "Save",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double dashWidth = 7;
    const double dashSpace = 5;

    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final RRect roundedRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(8),
    );

    final Path path = Path()..addRRect(roundedRect);

    for (final PathMetric metric in path.computeMetrics()) {
      double distance = 0;

      while (distance < metric.length) {
        final Path extractPath = metric.extractPath(
          distance,
          distance + dashWidth,
        );

        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
