import 'package:cristalteacher/features/diary/presentation/screens/creatediarydetails_screen.dart';
import 'package:flutter/material.dart';

class CreateDiaryScreen extends StatefulWidget {
  const CreateDiaryScreen({super.key});

  @override
  State<CreateDiaryScreen> createState() => _CreateDiaryScreenState();
}

class _CreateDiaryScreenState extends State<CreateDiaryScreen> {
  String? selectedStandard;
  String? selectedDivision;
  String? selectedSubject;
  String? selectedPriority;

  DateTime? diaryDate;
  DateTime? dueDate;

  final List<String> standards = ["I", "II", "III", "IV", "V", "VI"];

  final List<String> divisions = ["A", "B", "C", "D"];

  final List<String> subjects = [
    "English",
    "Arabic",
    "Maths",
    "Science",
    "Social Science",
  ];

  final List<String> priorities = ["Low", "Medium", "High"];

  Future<void> pickDate({required bool isDiaryDate}) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (selectedDate != null) {
      setState(() {
        if (isDiaryDate) {
          diaryDate = selectedDate;
        } else {
          dueDate = selectedDate;
        }
      });
    }
  }

  String formatDate(DateTime? date, String placeholder) {
    if (date == null) {
      return placeholder;
    }

    final String day = date.day.toString().padLeft(2, "0");
    final String month = date.month.toString().padLeft(2, "0");
    final String year = date.year.toString();

    return "$day-$month-$year";
  }

  void goNext() {
    debugPrint("Standard: $selectedStandard");
    debugPrint("Division: $selectedDivision");
    debugPrint("Subject: $selectedSubject");
    debugPrint("Diary Date: $diaryDate");
    debugPrint("Due Date: $dueDate");
    debugPrint("Priority: $selectedPriority");

    // Navigate to next create diary page here
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SelectYourClassScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8FF),
      body: SafeArea(
        child: Column(
          children: [
            const _TopBar(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(28, 22, 28, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDropdownField(
                      hint: "Standard",
                      value: selectedStandard,
                      items: standards,
                      onChanged: (value) {
                        setState(() {
                          selectedStandard = value;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    CustomDropdownField(
                      hint: "Division",
                      value: selectedDivision,
                      items: divisions,
                      onChanged: (value) {
                        setState(() {
                          selectedDivision = value;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    CustomDropdownField(
                      hint: "Subject",
                      value: selectedSubject,
                      items: subjects,
                      onChanged: (value) {
                        setState(() {
                          selectedSubject = value;
                        });
                      },
                    ),

                    const SizedBox(height: 26),

                    const Text(
                      "Expiry Date",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 14),

                    CustomDateField(
                      text: formatDate(diaryDate, "Diary Date"),
                      onTap: () {
                        pickDate(isDiaryDate: true);
                      },
                    ),

                    const SizedBox(height: 20),

                    CustomDateField(
                      text: formatDate(dueDate, "Due Date"),
                      onTap: () {
                        pickDate(isDiaryDate: false);
                      },
                    ),

                    const SizedBox(height: 28),

                    CustomDropdownField(
                      hint: "Priority",
                      value: selectedPriority,
                      items: priorities,
                      onChanged: (value) {
                        setState(() {
                          selectedPriority = value;
                        });
                      },
                    ),

                    const SizedBox(height: 112),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: goNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff9D75E8),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: const Color(0xffFCF8FF),
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.maybePop(context);
            },
            child: const Icon(Icons.arrow_back, size: 24, color: Colors.black),
          ),

          const Expanded(
            child: Center(
              child: Text(
                "Create Diary",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff222222),
                ),
              ),
            ),
          ),

          const SizedBox(width: 24),
        ],
      ),
    );
  }
}

class CustomDropdownField extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CustomDropdownField({
    super.key,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xffEEF3FC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xff8B8B8B), width: 0.8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xff5F6368),
            size: 24,
          ),
          hint: Text(
            hint,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(8),
          items: items.map((item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class CustomDateField extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomDateField({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xffEEF3FC),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xff8B8B8B), width: 0.8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),

            const Icon(
              Icons.calendar_month,
              size: 22,
              color: Color(0xff5F6368),
            ),
          ],
        ),
      ),
    );
  }
}
