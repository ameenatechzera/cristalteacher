import 'package:cristalteacher/features/exams/presentation/screens/exam_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectExamScreen extends StatefulWidget {
  const SelectExamScreen({super.key, this.onNext});

  final VoidCallback? onNext;

  @override
  State<SelectExamScreen> createState() => _SelectExamScreenState();
}

class _SelectExamScreenState extends State<SelectExamScreen> {
  static const Color primaryColor = Color(0xFF0758C9);
  static const Color fieldColor = Color(0xFFF0F4FF);
  static const Color purpleColor = Color(0xFF7265FF);
  static const Color textColor = Color(0xFF414141);

  String? selectedExam;
  String? selectedGrade;
  String? selectedClass;
  String? selectedDivision;
  String? selectedSubject;

  DateTime? selectedDate;

  int maxTE = 0;
  int maxCE = 0;

  final List<String> exams = [
    'Mid Term Exam',
    'First Term Exam',
    'Second Term Exam',
    'Final Exam',
  ];

  final List<String> grades = [
    'Grade 1',
    'Grade 2',
    'Grade 3',
    'Grade 4',
    'Grade 5',
    'Grade 6',
    'Grade 7',
    'Grade 8',
    'Grade 9',
    'Grade 10',
  ];

  final List<String> classes = [
    'Class 1',
    'Class 2',
    'Class 3',
    'Class 4',
    'Class 5',
    'Class 6',
    'Class 7',
  ];

  final List<String> divisions = ['A', 'B', 'C', 'D', 'E'];

  final List<String> subjects = [
    'Arabic',
    'English',
    'Mathematics',
    'Science',
    'Social Science',
    'Computer Science',
  ];

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.year}';
  }

  Future<void> _pickDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2040),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date == null) return;

    setState(() {
      selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 65,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 22),
        ),
        title: const Text(
          'Select Exam',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Exam information',
                style: TextStyle(
                  color: textColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),

              _buildDropdown(
                hint: 'Mid Term Exam',
                value: selectedExam,
                items: exams,
                onChanged: (value) {
                  setState(() {
                    selectedExam = value;
                  });
                },
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      hint: 'Grade',
                      value: selectedGrade,
                      items: grades,
                      onChanged: (value) {
                        setState(() {
                          selectedGrade = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: _buildDateField()),
                ],
              ),

              const SizedBox(height: 16),

              const Text(
                'Class And Subject',
                style: TextStyle(
                  color: textColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      hint: 'Class',
                      value: selectedClass,
                      items: classes,
                      onChanged: (value) {
                        setState(() {
                          selectedClass = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildDropdown(
                      hint: 'Division',
                      value: selectedDivision,
                      items: divisions,
                      onChanged: (value) {
                        setState(() {
                          selectedDivision = value;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              _buildDropdown(
                hint: 'Select Subject',
                value: selectedSubject,
                items: subjects,
                onChanged: (value) {
                  setState(() {
                    selectedSubject = value;
                  });
                },
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: _buildNumberField(
                      label: 'MAX TE',
                      value: maxTE,
                      onIncrease: () {
                        setState(() {
                          maxTE++;
                        });
                      },
                      onDecrease: () {
                        if (maxTE == 0) return;

                        setState(() {
                          maxTE--;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildNumberField(
                      label: 'MAX CE',
                      value: maxCE,
                      onIncrease: () {
                        setState(() {
                          maxCE++;
                        });
                      },
                      onDecrease: () {
                        if (maxCE == 0) return;

                        setState(() {
                          maxCE--;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 66),

              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ExamDetailsScreen();
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: purpleColor,
        size: 21,
      ),
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
      menuMaxHeight: 300,
      hint: Text(
        hint,
        style: const TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: fieldColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 11,
          vertical: 13,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: purpleColor, width: 1),
        ),
      ),
      style: const TextStyle(
        color: textColor,
        fontSize: 11,
        fontWeight: FontWeight.w400,
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(color: textColor, fontSize: 11),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildDateField() {
    return InkWell(
      onTap: _pickDate,
      borderRadius: BorderRadius.circular(11),
      child: Container(
        height: 41,
        padding: const EdgeInsets.symmetric(horizontal: 11),
        decoration: BoxDecoration(
          color: fieldColor,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedDate == null ? 'Date' : _formatDate(selectedDate!),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(width: 5),
            buildPurpleIcon(
              'assets/icons/Group (15).svg',
              iconColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPurpleIcon(
    String assetPath, {
    double size = 28,
    double iconSize = 15,
    Color iconColor = primaryColor,
    Color backgroundColor = Colors.transparent,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(7),
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        assetPath,
        width: iconSize,
        height: iconSize,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      ),
    );
  }

  Widget _buildNumberField({
    required String label,
    required int value,
    required VoidCallback onIncrease,
    required VoidCallback onDecrease,
  }) {
    return Container(
      height: 41,
      padding: const EdgeInsets.only(left: 11, right: 8),
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value == 0 ? label : '$label : $value',
              style: const TextStyle(
                color: textColor,
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: onIncrease,
                borderRadius: BorderRadius.circular(10),
                child: const SizedBox(
                  width: 20,
                  height: 16,
                  child: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    size: 17,
                    color: purpleColor,
                  ),
                ),
              ),
              InkWell(
                onTap: onDecrease,
                borderRadius: BorderRadius.circular(10),
                child: const SizedBox(
                  width: 20,
                  height: 16,
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 17,
                    color: purpleColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
