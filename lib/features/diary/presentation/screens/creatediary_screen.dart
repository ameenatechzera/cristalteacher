import 'package:cristalteacher/core/appdata/appdata.dart';
import 'package:cristalteacher/features/authentication/domain/entities/class_details_entity.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/fetch_tutorshipclass_parameter.dart';
import 'package:cristalteacher/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:cristalteacher/features/diary/presentation/screens/creatediarydetails_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateDiaryScreen extends StatefulWidget {
  const CreateDiaryScreen({super.key});

  @override
  State<CreateDiaryScreen> createState() => _CreateDiaryScreenState();
}

class _CreateDiaryScreenState extends State<CreateDiaryScreen> {
  int? selectedStandardId;
  int? selectedDivisionId;
  int? selectedSubjectId;

  String? selectedStandard;
  String? selectedDivision;
  String? selectedSubject;
  String? selectedPriority;

  DateTime? diaryDate;
  DateTime? dueDate;
  bool isFavourite = false;
  List<TutorshipClass> tutorshipClasses = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchTutorshipClasses();
    });
  }

  void _fetchTutorshipClasses() {
    context.read<AuthenticationCubit>().fetchTutorshipClass(
      FetchTutorshipClassRequest(
        accyear: AppData.accYear,
        employeeId: AppData.employeeId,
        userId: AppData.userId,
      ),
    );
  }

  // All unique standards from the API.
  List<TutorshipClass> get standards {
    final Map<int, TutorshipClass> uniqueItems = {};

    for (final standard in tutorshipClasses) {
      final id = standard.standardId;

      if (id != null) {
        uniqueItems[id] = standard;
      }
    }

    return uniqueItems.values.toList();
  }

  List<DivisionDetails> divisions = [];
  List<SubjectDetails> subjects = [];

  void _selectStandard(int? standardId) {
    if (standardId == null) return;

    final standard = tutorshipClasses.firstWhere(
      (e) => e.standardId == standardId,
    );

    setState(() {
      selectedStandardId = standard.standardId;
      selectedStandard = standard.standard;

      // Load only this standard's divisions
      divisions = standard.division ?? [];

      // Reset lower selections
      selectedDivisionId = null;
      selectedDivision = null;

      subjects = [];

      selectedSubjectId = null;
      selectedSubject = null;
    });
  }

  void _selectDivision(int? divisionId) {
    if (divisionId == null) return;

    final division = divisions.firstWhere((e) => e.divisionId == divisionId);

    setState(() {
      selectedDivisionId = division.divisionId;
      selectedDivision = division.division;

      // Load only this division's subjects
      subjects = division.subject ?? [];

      selectedSubjectId = null;
      selectedSubject = null;
    });
  }

  void _selectSubject(int? subjectId) {
    if (subjectId == null) return;

    final subject = subjects.firstWhere((e) => e.subjectId == subjectId);

    setState(() {
      selectedSubjectId = subject.subjectId;
      selectedSubject = subject.subject;
    });
  }

  Future<void> pickDate({required bool isDiaryDate}) async {
    final DateTime initialDate = isDiaryDate
        ? diaryDate ?? DateTime.now()
        : dueDate ?? diaryDate ?? DateTime.now();

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (selectedDate == null || !mounted) {
      return;
    }

    if (!isDiaryDate &&
        diaryDate != null &&
        selectedDate.isBefore(diaryDate!)) {
      _showMessage('Due Date cannot be before Diary Date');
      return;
    }

    setState(() {
      if (isDiaryDate) {
        diaryDate = selectedDate;

        if (dueDate != null && dueDate!.isBefore(selectedDate)) {
          dueDate = null;
        }
      } else {
        dueDate = selectedDate;
      }
    });
  }

  String formatDate(DateTime? date, String placeholder) {
    if (date == null) {
      return placeholder;
    }

    final String day = date.day.toString().padLeft(2, '0');
    final String month = date.month.toString().padLeft(2, '0');
    final String year = date.year.toString();

    return '$day-$month-$year';
  }

  String formatApiDate(DateTime date) {
    final String year = date.year.toString();
    final String month = date.month.toString().padLeft(2, '0');
    final String day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  void goNext() {
    if (selectedStandardId == null) {
      _showMessage('Please select Standard');
      return;
    }

    if (selectedDivisionId == null) {
      _showMessage('Please select Division');
      return;
    }

    if (selectedSubjectId == null) {
      _showMessage('Please select Subject');
      return;
    }

    if (diaryDate == null) {
      _showMessage('Please select Diary Date');
      return;
    }

    if (dueDate == null) {
      _showMessage('Please select Due Date');
      return;
    }

    debugPrint('Standard: $selectedStandard ($selectedStandardId)');

    debugPrint('Division: $selectedDivision ($selectedDivisionId)');

    debugPrint('Subject: $selectedSubject ($selectedSubjectId)');

    debugPrint('Diary Date: ${formatApiDate(diaryDate!)}');

    debugPrint('Due Date: ${formatApiDate(dueDate!)}');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SelectYourClassScreen(
          standardId: selectedStandardId!,
          standardName: selectedStandard!,
          divisionId: selectedDivisionId!,
          divisionName: selectedDivision!,
          subjectId: selectedSubjectId!,
          subjectName: selectedSubject!,
          diaryDate: diaryDate!,
          dueDate: dueDate!,
          isFavourite: isFavourite,
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
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
              child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
                listenWhen: (previous, current) {
                  return current is FetchTutorshipClassSuccess;
                },
                listener: (context, state) {
                  if (state is FetchTutorshipClassSuccess) {
                    setState(() {
                      tutorshipClasses =
                          state.response.data?.tutorshipClass ?? [];

                      divisions = [];
                      subjects = [];

                      selectedStandardId = null;
                      selectedStandard = null;

                      selectedDivisionId = null;
                      selectedDivision = null;

                      selectedSubjectId = null;
                      selectedSubject = null;
                    });
                  }
                },
                builder: (context, state) {
                  if (state is FetchTutorshipClassLoading &&
                      tutorshipClasses.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff9D75E8),
                      ),
                    );
                  }

                  if (state is FetchTutorshipClassFailure &&
                      tutorshipClasses.isEmpty) {
                    return _ApiErrorView(
                      message: state.message,
                      onRetry: _fetchTutorshipClasses,
                    );
                  }

                  if (state is FetchTutorshipClassSuccess) {
                    tutorshipClasses =
                        state.response.data?.tutorshipClass ?? [];
                  }

                  if (tutorshipClasses.isEmpty) {
                    return _ApiErrorView(
                      message: 'No class details found',
                      onRetry: _fetchTutorshipClasses,
                    );
                  }

                  return _buildForm();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(28, 22, 28, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDropdownField<int>(
            hint: 'Standard',
            value: selectedStandardId,
            items: standards.map((item) {
              return DropdownMenuItem<int>(
                value: item.standardId,
                child: Text(item.standard ?? ''),
              );
            }).toList(),
            onChanged: _selectStandard,
          ),

          const SizedBox(height: 20),

          CustomDropdownField<int>(
            hint: 'Division',
            value: selectedDivisionId,
            items: divisions.map((item) {
              return DropdownMenuItem<int>(
                value: item.divisionId,
                child: Text(item.division ?? ''),
              );
            }).toList(),
            onChanged: _selectDivision,
          ),

          const SizedBox(height: 20),

          CustomDropdownField<int>(
            hint: 'Subject',
            value: selectedSubjectId,
            items: subjects.map((item) {
              return DropdownMenuItem<int>(
                value: item.subjectId,
                child: Text(item.subject ?? ''),
              );
            }).toList(),
            onChanged: _selectSubject,
          ),

          const SizedBox(height: 26),

          const Text(
            'Expiry Date',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 14),

          CustomDateField(
            text: formatDate(diaryDate, 'Diary Date'),
            onTap: () {
              pickDate(isDiaryDate: true);
            },
          ),

          const SizedBox(height: 20),

          CustomDateField(
            text: formatDate(dueDate, 'Due Date'),
            onTap: () {
              pickDate(isDiaryDate: false);
            },
          ),

          const SizedBox(height: 28),

          Container(
            height: 58,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xffEEF3FC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xff8B8B8B), width: 0.8),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: isFavourite,
                  activeColor: const Color(0xff9D75E8),
                  checkColor: Colors.white,
                  side: const BorderSide(color: Color(0xff5F6368), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  onChanged: (value) {
                    setState(() {
                      isFavourite = value ?? false;
                    });
                  },
                ),
                const SizedBox(width: 2),
                const Expanded(
                  child: Text(
                    'Is Favourite',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
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
                'Next',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
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
                'Create Diary',
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

class CustomDropdownField<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  const CustomDropdownField({
    super.key,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasValidValue =
        value == null || items.any((item) => item.value == value);

    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xffEEF3FC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xff8B8B8B), width: 0.8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: hasValidValue ? value : null,
          items: items,
          onChanged: onChanged,
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

class _ApiErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ApiErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Colors.red),
            ),

            const SizedBox(height: 12),

            TextButton(
              onPressed: onRetry,
              child: const Text(
                'Retry',
                style: TextStyle(color: Color(0xff9D75E8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
