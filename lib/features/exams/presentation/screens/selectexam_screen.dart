import 'package:cristalteacher/core/appdata/appdata.dart';
import 'package:cristalteacher/features/attendance/domain/parameters/fetch_attendancedetails_parameter.dart';
import 'package:cristalteacher/features/authentication/domain/entities/class_details_entity.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/fetch_tutorshipclass_parameter.dart';
import 'package:cristalteacher/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:cristalteacher/features/exams/domain/entities/fetch_gradeplan_entity.dart';
import 'package:cristalteacher/features/exams/domain/entities/fetchexam_entity.dart';
import 'package:cristalteacher/features/exams/domain/entities/get_all_exam_entity.dart';
import 'package:cristalteacher/features/exams/presentation/cubit/exam_cubit.dart';
import 'package:cristalteacher/features/exams/presentation/screens/exam_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SelectExamScreen extends StatefulWidget {
  const SelectExamScreen({super.key, this.onNext, this.exam});

  final VoidCallback? onNext;
  final MarkEntryEntity? exam;

  @override
  State<SelectExamScreen> createState() => _SelectExamScreenState();
}

class _SelectExamScreenState extends State<SelectExamScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExamCubit>().fetchGradePlan();
      context.read<ExamCubit>().getAllExams();
      _fetchTutorshipClasses();
    });
  }

  @override
  void dispose() {
    maxTeController.dispose();
    maxCeController.dispose();
    super.dispose();
  }

  void _fetchTutorshipClasses() {
    final request = FetchTutorshipClassRequest(
      accyear: AppData.accYear,
      employeeId: AppData.employeeId,
      userId: AppData.userId,
    );

    debugPrint('==========================================');
    debugPrint('📘 FETCH TUTORSHIP CLASS');
    debugPrint('Request: ${request.toJson()}');
    debugPrint('==========================================');

    context.read<AuthenticationCubit>().fetchTutorshipClass(request);
  }

  static const Color primaryColor = Color(0xFF0758C9);
  static const Color fieldColor = Color(0xFFF0F4FF);
  static const Color purpleColor = Color(0xFF7265FF);
  static const Color textColor = Color(0xFF414141);
  bool get isEditMode => widget.exam != null;

  int? markEntryId;
  String? selectedExam;
  String? selectedGrade;

  DateTime? selectedDate;
  final TextEditingController maxTeController = TextEditingController();
  final TextEditingController maxCeController = TextEditingController();
  int maxTE = 0;
  int maxCE = 0;

  List<GradePlanEntity> gradePlans = [];
  List<GetAllExamData> exams = [];
  List<TutorshipClass> tutorshipClasses = [];

  int? selectedStandardId;
  String? selectedStandard;

  int? selectedDivisionId;
  String? selectedDivision;

  int? selectedSubjectId;
  String? selectedSubject;
  int? selectedExamId;
  int? selectedGradePlanId;
  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.year}';
  }

  void _populateEditData() {
    final exam = widget.exam;

    if (exam == null) return;

    setState(() {
      markEntryId = exam.markEntryId;

      selectedExamId = exam.examId;
      selectedExam = exam.examName;

      selectedGradePlanId = exam.gradePlanId;

      selectedStandardId = exam.standardId;
      selectedStandard = exam.standard;

      selectedDivisionId = exam.divisionId;
      selectedDivision = exam.division;

      selectedSubjectId = exam.subjectId;
      selectedSubject = exam.subjectName;

      maxTeController.text = exam.maxTE?.toString() ?? '';
      maxCeController.text = exam.maxCE?.toString() ?? '';

      // Convert String? → DateTime?
      if (exam.examDate != null && exam.examDate!.isNotEmpty) {
        selectedDate = DateTime.tryParse(exam.examDate!.replaceFirst(' ', 'T'));
      }
    });
  }

  List<DivisionDetails> get availableDivisions {
    final Map<int, DivisionDetails> uniqueDivisions = {};

    for (final standard in tutorshipClasses) {
      for (final division in standard.division ?? <DivisionDetails>[]) {
        final id = division.divisionId;

        if (id != null) {
          uniqueDivisions[id] = division;
        }
      }
    }

    return uniqueDivisions.values.toList();
  }

  List<SubjectDetails> get availableSubjects {
    final Map<int, SubjectDetails> uniqueSubjects = {};

    for (final standard in tutorshipClasses) {
      for (final division in standard.division ?? <DivisionDetails>[]) {
        for (final subject in division.subject ?? <SubjectDetails>[]) {
          final id = subject.subjectId;

          if (id != null) {
            uniqueSubjects[id] = subject;
          }
        }
      }
    }

    return uniqueSubjects.values.toList();
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
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is FetchTutorshipClassSuccess) {
          setState(() {
            tutorshipClasses = state.response.data?.tutorshipClass ?? [];

            selectedStandardId = null;
            selectedStandard = null;

            selectedDivisionId = null;
            selectedDivision = null;

            selectedSubjectId = null;
            selectedSubject = null;
          });
        }

        if (state is FetchTutorshipClassFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: BlocConsumer<ExamCubit, ExamState>(
        listenWhen: (previous, current) =>
            current is FetchGradePlanSuccess ||
            current is FetchGradePlanFailure ||
            current is GetAllExamSuccess ||
            current is GetAllExamFailure,
        listener: (context, state) {
          if (state is FetchGradePlanSuccess) {
            setState(() {
              gradePlans = state.response.data ?? [];

              if (gradePlans.isNotEmpty) {
                selectedGradePlanId = gradePlans.first.gradePlanId;
                selectedGrade = gradePlans.first.gradePlanName;
              }
            });
          }
          if (state is FetchGradePlanFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          // if (state is GetAllExamSuccess) {
          //   setState(() {
          //     exams = state.response.data ?? [];

          //     if (exams.isNotEmpty) {
          //       selectedExamId = exams.first.examId;
          //       selectedExam = exams.first.examName;
          //     }
          //   });
          // }
          if (state is GetAllExamSuccess) {
            setState(() {
              exams = state.response.data ?? [];

              // Keep exam unselected until the user selects one.
              selectedExamId = null;
              selectedExam = null;
            });
          }
          if (state is GetAllExamFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final bool isGradeLoading = state is FetchGradePlanLoading;
          final bool isExamLoading = state is GetAllExamLoading;
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
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 22,
                ),
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

                    // _buildDropdown(
                    //   hint: 'Mid Term Exam',
                    //   value: selectedExam,
                    //   items: exams,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       selectedExam = value;
                    //     });
                    //   },
                    // ),
                    _buildExamDropdown(isLoading: isExamLoading),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Expanded(
                          child: _buildGradeDropdown(isLoading: isGradeLoading),
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

                    BlocBuilder<AuthenticationCubit, AuthenticationState>(
                      builder: (context, authState) {
                        final isTutorshipLoading =
                            authState is FetchTutorshipClassLoading;

                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _buildStandardDropdown(
                                    isLoading: isTutorshipLoading,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildDivisionDropdown(
                                    isLoading: isTutorshipLoading,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            _buildSubjectDropdown(
                              isLoading: isTutorshipLoading,
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: maxTeController,
                            hint: 'MAX TE',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildTextField(
                            controller: maxCeController,
                            hint: 'MAX CE',
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
                          _goToExamDetails();
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return ExamDetailsScreen(
                          //         request: AttendanceDetailsRequest(
                          //           accyear: AppData.accYear!,
                          //           standard: 1,
                          //           division: 1,
                          //           sortBy: 'alphabetic',
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // );
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
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _goToExamDetails() {
    final maxTe = int.tryParse(maxTeController.text.trim());
    final maxCe = int.tryParse(maxCeController.text.trim());

    if (selectedExamId == null ||
        selectedExam == null ||
        selectedGradePlanId == null ||
        selectedGrade == null ||
        selectedDate == null ||
        selectedStandardId == null ||
        selectedStandard == null ||
        selectedDivisionId == null ||
        selectedDivision == null ||
        selectedSubjectId == null ||
        selectedSubject == null ||
        maxTe == null ||
        maxCe == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Please fill all the fields'),
            backgroundColor: Colors.red,
          ),
        );

      return;
    }

    if (maxTe <= 0 || maxCe <= 0) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Maximum marks must be greater than zero'),
            backgroundColor: Colors.red,
          ),
        );

      return;
    }

    final request = AttendanceDetailsRequest(
      accyear: AppData.accYear!,
      standard: selectedStandardId!,
      division: selectedDivisionId!,
      sortBy: 'alphabetic',
    );

    debugPrint('Exam ID: $selectedExamId');
    debugPrint('Exam: $selectedExam');
    debugPrint('Grade plan ID: $selectedGradePlanId');
    debugPrint('Grade: $selectedGrade');
    debugPrint('Date: ${_formatDate(selectedDate!)}');
    debugPrint('Standard ID: $selectedStandardId');
    debugPrint('Standard: $selectedStandard');
    debugPrint('Division ID: $selectedDivisionId');
    debugPrint('Division: $selectedDivision');
    debugPrint('Subject ID: $selectedSubjectId');
    debugPrint('Subject: $selectedSubject');
    debugPrint('Max TE: $maxTe');
    debugPrint('Max CE: $maxCe');
    debugPrint('Student request: ${request.toJson()}');

    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (_) => ExamDetailsScreen(
    //       request: request,
    //       examId: selectedExamId!,
    //       examName: selectedExam!,
    //       gradePlanId: selectedGradePlanId!,
    //       gradePlanName: selectedGrade!,
    //       examDate: selectedDate!,
    //       standardId: selectedStandardId!,
    //       standardName: selectedStandard!,
    //       divisionId: selectedDivisionId!,
    //       divisionName: selectedDivision!,
    //       subjectId: selectedSubjectId!,
    //       subjectName: selectedSubject!,
    //       maxTe: maxTe,
    //       maxCe: maxCe,
    //     ),
    //   ),
    // );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ExamDetailsScreen(
          request: request,
          examId: selectedExamId!,
          examName: selectedExam!,
          gradePlanId: selectedGradePlanId!,
          gradePlanName: selectedGrade!,
          examDate: selectedDate!,
          standardId: selectedStandardId!,
          standardName: selectedStandard!,
          divisionId: selectedDivisionId!,
          divisionName: selectedDivision!,
          subjectId: selectedSubjectId!,
          subjectName: selectedSubject!,
          maxTe: maxTe,
          maxCe: maxCe,

          // EDIT
          isEditMode: isEditMode,
          markEntryId: markEntryId,
        ),
      ),
    );
  }

  Widget _buildStandardDropdown({required bool isLoading}) {
    final validValue = tutorshipClasses.any(
      (item) => item.standardId == selectedStandardId,
    );

    return DropdownButtonFormField<int>(
      value: validValue ? selectedStandardId : null,
      isExpanded: true,
      icon: isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: purpleColor,
              ),
            )
          : const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: purpleColor,
              size: 21,
            ),
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
      menuMaxHeight: 300,
      hint: Text(
        isLoading ? 'Loading...' : 'Standard',
        style: const TextStyle(color: textColor, fontSize: 11),
      ),
      decoration: _dropdownDecoration(),
      items: tutorshipClasses.where((item) => item.standardId != null).map((
        item,
      ) {
        return DropdownMenuItem<int>(
          value: item.standardId,
          child: Text(
            item.standard ?? '',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: textColor, fontSize: 11),
          ),
        );
      }).toList(),
      onChanged: isLoading
          ? null
          : (value) {
              if (value == null) return;

              TutorshipClass? selectedItem;

              for (final item in tutorshipClasses) {
                if (item.standardId == value) {
                  selectedItem = item;
                  break;
                }
              }

              setState(() {
                selectedStandardId = value;
                selectedStandard = selectedItem?.standard;

                // Reset child dropdowns.
                selectedDivisionId = null;
                selectedDivision = null;
                selectedSubjectId = null;
                selectedSubject = null;
              });
            },
    );
  }

  Widget _buildDivisionDropdown({required bool isLoading}) {
    final divisions = availableDivisions;

    final validValue = divisions.any(
      (item) => item.divisionId == selectedDivisionId,
    );

    return DropdownButtonFormField<int>(
      value: validValue ? selectedDivisionId : null,
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: purpleColor,
        size: 21,
      ),
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
      menuMaxHeight: 300,
      hint: const Text(
        'Division',
        style: TextStyle(color: textColor, fontSize: 11),
      ),
      decoration: _dropdownDecoration(),
      items: divisions.where((item) => item.divisionId != null).map((item) {
        return DropdownMenuItem<int>(
          value: item.divisionId,
          child: Text(
            item.division ?? '',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: textColor, fontSize: 11),
          ),
        );
      }).toList(),
      onChanged: isLoading
          ? null
          : (value) {
              if (value == null) return;

              DivisionDetails? selectedItem;

              for (final item in divisions) {
                if (item.divisionId == value) {
                  selectedItem = item;
                  break;
                }
              }

              setState(() {
                selectedDivisionId = value;
                selectedDivision = selectedItem?.division;
              });
            },
    );
  }

  Widget _buildSubjectDropdown({required bool isLoading}) {
    final subjects = availableSubjects;

    final validValue = subjects.any(
      (item) => item.subjectId == selectedSubjectId,
    );

    return DropdownButtonFormField<int>(
      value: validValue ? selectedSubjectId : null,
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: purpleColor,
        size: 21,
      ),
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
      menuMaxHeight: 300,
      hint: const Text(
        'Select Subject',
        style: TextStyle(color: textColor, fontSize: 11),
      ),
      decoration: _dropdownDecoration(),
      items: subjects.where((item) => item.subjectId != null).map((item) {
        return DropdownMenuItem<int>(
          value: item.subjectId,
          child: Text(
            item.subject ?? '',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: textColor, fontSize: 11),
          ),
        );
      }).toList(),
      onChanged: isLoading
          ? null
          : (value) {
              if (value == null) return;

              SubjectDetails? selectedItem;

              for (final item in subjects) {
                if (item.subjectId == value) {
                  selectedItem = item;
                  break;
                }
              }

              setState(() {
                selectedSubjectId = value;
                selectedSubject = selectedItem?.subject;
              });
            },
    );
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: fieldColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 11, vertical: 13),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: BorderSide.none,
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: purpleColor),
      ),
    );
  }

  Widget _buildExamDropdown({required bool isLoading}) {
    return DropdownButtonFormField<int>(
      value: selectedExamId,
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: purpleColor,
        size: 21,
      ),
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
      menuMaxHeight: 300,
      hint: const Text(
        'Select Exam',
        style: TextStyle(color: textColor, fontSize: 11),
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
          borderSide: const BorderSide(color: purpleColor),
        ),
      ),
      items: exams.map((exam) {
        return DropdownMenuItem<int>(
          value: exam.examId,
          child: Text(
            exam.examName ?? '',
            style: const TextStyle(color: textColor, fontSize: 11),
          ),
        );
      }).toList(),
      onChanged: isLoading
          ? null
          : (value) {
              final selected = exams.firstWhere((e) => e.examId == value);

              setState(() {
                selectedExamId = selected.examId;
                selectedExam = selected.examName;
              });
            },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
  }) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: textColor,
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
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
      ),
    );
  }

  Widget _buildGradeDropdown({required bool isLoading}) {
    return DropdownButtonFormField<int>(
      value: selectedGradePlanId,
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: purpleColor,
        size: 21,
      ),
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
      menuMaxHeight: 300,
      hint: const Text(
        'Grade',
        style: TextStyle(color: textColor, fontSize: 11),
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
          borderSide: const BorderSide(color: purpleColor),
        ),
      ),
      items: gradePlans.map((grade) {
        return DropdownMenuItem<int>(
          value: grade.gradePlanId,
          child: Text(
            grade.gradePlanName ?? '',
            style: const TextStyle(color: textColor, fontSize: 11),
          ),
        );
      }).toList(),
      onChanged: isLoading
          ? null
          : (value) {
              final selected = gradePlans.firstWhere(
                (e) => e.gradePlanId == value,
              );

              setState(() {
                selectedGradePlanId = selected.gradePlanId;
                selectedGrade = selected.gradePlanName;
              });
            },
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
