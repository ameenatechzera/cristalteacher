import 'package:cristalteacher/core/appdata/appdata.dart';
import 'package:cristalteacher/features/attendance/domain/entities/fetch_attendancedetails_entity.dart';
import 'package:cristalteacher/features/attendance/domain/parameters/fetch_attendancedetails_parameter.dart';
import 'package:cristalteacher/features/attendance/presentation/cubit/attendance_cubit.dart';
import 'package:cristalteacher/features/exams/domain/parameters/save_exam_parameter.dart';
import 'package:cristalteacher/features/exams/presentation/cubit/exam_cubit.dart';
import 'package:cristalteacher/features/exams/presentation/screens/exam_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExamDetailsScreen extends StatefulWidget {
  final AttendanceDetailsRequest request;
  final int examId;
  final String examName;

  final int gradePlanId;
  final String gradePlanName;

  final DateTime examDate;

  final int standardId;
  final String standardName;

  final int divisionId;
  final String divisionName;

  final int subjectId;
  final String subjectName;

  final int maxTe;
  final int maxCe;

  const ExamDetailsScreen({
    super.key,
    required this.request,
    required this.examId,
    required this.examName,
    required this.gradePlanId,
    required this.gradePlanName,
    required this.examDate,
    required this.standardId,
    required this.standardName,
    required this.divisionId,
    required this.divisionName,
    required this.subjectId,
    required this.subjectName,
    required this.maxTe,
    required this.maxCe,
  });

  @override
  State<ExamDetailsScreen> createState() => _ExamDetailsScreenState();
}

class _ExamDetailsScreenState extends State<ExamDetailsScreen> {
  static const Color primaryBlue = Color(0xFF0758C9);
  static const Color purple = Color(0xFF5C20F4);
  static const Color lightPurple = Color(0xFFF7F3FF);
  static const Color green = Color(0xFF22C900);
  bool _isSaving = false;
  final TextEditingController searchController = TextEditingController();

  final List<StudentMark> students = [];

  bool _studentsLoaded = false;

  List<StudentMark> get filteredStudents {
    final String query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      return students;
    }

    return students.where((student) {
      return student.name.toLowerCase().contains(query) ||
          student.id.toLowerCase().contains(query) ||
          student.grade.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _fetchStudents();
    });
  }

  void _fetchStudents() {
    context.read<AttendanceCubit>().fetchAttendanceDetails(widget.request);
  }

  void _retryFetch() {
    _studentsLoaded = false;
    _fetchStudents();
  }

  void _setStudents(List<AttendanceDetailsData> attendanceStudents) {
    for (final StudentMark student in students) {
      student.dispose();
    }

    students
      ..clear()
      ..addAll(
        attendanceStudents.map((attendanceStudent) {
          final String name = attendanceStudent.name?.trim() ?? '';
          final String admissionNumber = attendanceStudent.admno?.trim() ?? '';

          return StudentMark(
            admissionId: attendanceStudent.admissionId,
            id: admissionNumber.isNotEmpty
                ? admissionNumber
                : attendanceStudent.admissionId?.toString() ?? '',
            name: name.isNotEmpty ? name : 'Unknown Student',
            grade: '',
            isPresent: true,
            teMark: '',
            ceMark: '',
            narration: '',
          );
        }),
      );

    _studentsLoaded = true;
  }

  // void _saveDetails() {
  //   if (students.isEmpty) {
  //     _showMessage('No students available');
  //     return;
  //   }

  //   for (final StudentMark student in students) {
  //     final int? teMark = int.tryParse(student.teController.text.trim());
  //     final int? ceMark = int.tryParse(student.ceController.text.trim());

  //     if (teMark != null && teMark > widget.maxTe) {
  //       _showMessage(
  //         'TE mark for ${student.name} cannot exceed ${widget.maxTe}',
  //       );
  //       return;
  //     }

  //     if (ceMark != null && ceMark > widget.maxCe) {
  //       _showMessage(
  //         'CE mark for ${student.name} cannot exceed ${widget.maxCe}',
  //       );
  //       return;
  //     }
  //   }

  //   for (final StudentMark student in students) {
  //     debugPrint('==========================================');
  //     debugPrint('Admission ID: ${student.admissionId}');
  //     debugPrint('Admission Number: ${student.id}');
  //     debugPrint('Name: ${student.name}');
  //     debugPrint('Present: ${student.isPresent}');
  //     debugPrint('TE Mark: ${student.teController.text.trim()}');
  //     debugPrint('CE Mark: ${student.ceController.text.trim()}');
  //     debugPrint('Narration: ${student.narrationController.text.trim()}');
  //     debugPrint('==========================================');
  //   }

  //   _showMessage('Student mark details are ready to save');
  // }
  Future<void> _saveDetails() async {
    if (students.isEmpty) {
      _showMessage('No students available');
      return;
    }

    // Validate marks
    for (final StudentMark student in students) {
      final int? teMark = int.tryParse(student.teController.text.trim());
      final int? ceMark = int.tryParse(student.ceController.text.trim());

      if (teMark != null && teMark > widget.maxTe) {
        _showMessage(
          'TE mark for ${student.name} cannot exceed ${widget.maxTe}',
        );
        return;
      }

      if (ceMark != null && ceMark > widget.maxCe) {
        _showMessage(
          'CE mark for ${student.name} cannot exceed ${widget.maxCe}',
        );
        return;
      }
    }

    // Prepare exam date
    final String examDate =
        '${widget.examDate.year.toString().padLeft(4, '0')}-'
        '${widget.examDate.month.toString().padLeft(2, '0')}-'
        '${widget.examDate.day.toString().padLeft(2, '0')}';

    // Prepare student details
    final List<ExamMarkDetailParameter> details = students.map((student) {
      return ExamMarkDetailParameter(
        admno: student.id,
        te: student.teController.text.trim(),
        ce: student.ceController.text.trim(),
        grade: student.grade,
        absent: student.isPresent ? '0' : '1',
        status: true,
        narration: student.narrationController.text.trim(),
        isOptional: null,
      );
    }).toList();

    final request = SaveExamMarksParameter(
      employeeId: AppData.employeeId ?? 0,
      accYear: AppData.accYear ?? '',
      standardId: widget.standardId,
      divisionId: widget.divisionId,
      subjectId: widget.subjectId,
      gradePlanId: widget.gradePlanId,
      maxTE: widget.maxTe,
      maxCE: widget.maxCe,
      examDate: examDate,
      status: true,
      branchId: AppData.branchId ?? 1,
      createdUser: AppData.userId?.toString() ?? '',
      examId: widget.examId,
      details: details,
    );

    // Debug request
    debugPrint('==========================================');
    debugPrint('📘 SAVE EXAM MARKS');
    debugPrint('Exam ID: ${widget.examId}');
    debugPrint('Exam Name: ${widget.examName}');
    debugPrint('Request: ${request.toJson()}');
    debugPrint('==========================================');

    // Call Cubit
    context.read<ExamCubit>().saveExamMarks(request);
  }

  void _changeAttendance(StudentMark student) {
    setState(() {
      student.isPresent = !student.isPresent;
    });
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  @override
  void dispose() {
    searchController.dispose();

    for (final StudentMark student in students) {
      student.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExamCubit, ExamState>(
      listener: (context, examState) {
        if (examState is SaveExamMarksLoading) {
          setState(() {
            _isSaving = true;
          });
        }

        if (examState is SaveExamMarksSuccess) {
          setState(() {
            _isSaving = true;
          });
          Navigator.pop(context);
          Navigator.pop(context);
        }

        if (examState is SaveExamMarksFailure) {
          setState(() {
            _isSaving = false;
          });
          _showMessage(examState.message);
        }
      },
      child: BlocConsumer<AttendanceCubit, AttendanceState>(
        listener: (context, state) {
          if (state is AttendanceSuccess) {
            _setStudents(state.response.data ?? []);
          }

          if (state is AttendanceFailure) {
            _showMessage(state.message);
          }
        },
        builder: (context, state) {
          final List<StudentMark> studentList = filteredStudents;

          return Scaffold(
            backgroundColor: const Color(0xFFFAFAFA),
            appBar: AppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 23,
                ),
              ),
              title: const Text(
                'Details',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: Center(
                    child: GestureDetector(
                      onTap: (students.isEmpty || _isSaving)
                          ? null
                          : _saveDetails,
                      child: Container(
                        width: 65,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: (students.isEmpty || _isSaving)
                              ? Colors.grey
                              : primaryBlue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: _isSaving
                            ? const SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Save',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              top: false,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(18, 14, 18, 13),
                    child: Column(
                      children: [
                        _buildExamSummaryCard(),
                        const SizedBox(height: 13),
                        _buildSearchField(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _buildStudentListBody(
                      state: state,
                      studentList: studentList,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStudentListBody({
    required AttendanceState state,
    required List<StudentMark> studentList,
  }) {
    if (state is AttendanceLoading && !_studentsLoaded) {
      return const Center(child: CircularProgressIndicator(color: primaryBlue));
    }

    if (state is AttendanceFailure && !_studentsLoaded) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                state.message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 13),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(onPressed: _retryFetch, child: const Text('Retry')),
          ],
        ),
      );
    }

    if (students.isEmpty) {
      return RefreshIndicator(
        color: primaryBlue,
        onRefresh: () async {
          _retryFetch();
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            SizedBox(height: 180),
            Center(
              child: Text(
                'No students found',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
          ],
        ),
      );
    }

    if (studentList.isEmpty) {
      return const Center(
        child: Text(
          'No students found',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
      );
    }

    return RefreshIndicator(
      color: primaryBlue,
      onRefresh: () async {
        _retryFetch();
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(27, 7, 27, 30),
        itemCount: studentList.length,
        separatorBuilder: (_, __) => const SizedBox(height: 13),
        itemBuilder: (context, index) {
          final StudentMark student = studentList[index];

          return _buildStudentCard(
            student: student,
            number: students.indexOf(student) + 1,
          );
        },
      ),
    );
  }

  Widget _buildExamSummaryCard() {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF2A0A0A), Color(0xFF902222)],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Text(
            widget.examName,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 19),
            child: Row(
              children: [
                Expanded(
                  child: _buildExamInformation(
                    assetPath: 'assets/icons/Group 951.svg',
                    iconBackground: const Color(0xFFFFF4A5),
                    iconColor: const Color(0xFFCB8500),
                    title: 'Standard',
                    value: widget.standardName,
                  ),
                ),
                Expanded(
                  child: _buildExamInformation(
                    assetPath: 'assets/icons/Group (17).svg',
                    iconBackground: const Color(0xFFFF9BE7),
                    iconColor: const Color(0xFFE300AE),
                    title: 'Division',
                    value: widget.divisionName,
                  ),
                ),
                Expanded(
                  child: _buildExamInformation(
                    assetPath: 'assets/icons/Group (19).svg',
                    iconBackground: const Color(0xFF71CFFF),
                    iconColor: const Color(0xFF006AAE),
                    title: 'Subject',
                    value: widget.subjectName,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamInformation({
    required String assetPath,
    required Color iconBackground,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            color: iconBackground,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            assetPath,
            width: 14,
            height: 14,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 9),
              ),
              const SizedBox(height: 1),
              Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      onChanged: (_) {
        setState(() {});
      },
      style: const TextStyle(fontSize: 12, color: Colors.black),
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: const TextStyle(color: Color(0xFF777777), fontSize: 11),
        prefixIcon: const Icon(
          Icons.search,
          color: Color(0xFF777777),
          size: 19,
        ),
        suffixIcon: searchController.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  searchController.clear();
                  setState(() {});
                },
                icon: const Icon(Icons.close, size: 17, color: Colors.grey),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 11,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: Color(0xFFD7D7D7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: primaryBlue),
        ),
      ),
    );
  }

  Widget _buildStudentCard({
    required StudentMark student,
    required int number,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(7, 7, 7, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFFDCDCDC)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F0FF),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          '#$number',
                          style: const TextStyle(
                            color: purple,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        student.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        student.id,
                        style: const TextStyle(
                          color: Color(0xFF777777),
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
                if (student.grade.isNotEmpty) ...[
                  Text(
                    student.grade,
                    style: const TextStyle(
                      color: green,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
                GestureDetector(
                  onTap: () => _changeAttendance(student),
                  child: Container(
                    margin: const EdgeInsets.only(top: 3),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: student.isPresent
                          ? const Color(0xFFF1FCEB)
                          : const Color(0xFFFFEEEE),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            color: student.isPresent ? green : Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          student.isPresent ? 'Present' : 'Absent',
                          style: TextStyle(
                            color: student.isPresent
                                ? const Color(0xFF53A932)
                                : Colors.red,
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          const SizedBox(height: 5),
          _buildMarksContainer(student),
          const SizedBox(height: 4),
          _buildNarrationField(student),
        ],
      ),
    );
  }

  Widget _buildMarksContainer(StudentMark student) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: lightPurple,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildMarkField(
              icon: Icons.assignment_rounded,
              title: 'TE- max ${widget.maxTe}',
              controller: student.teController,
              maximumMark: widget.maxTe,
            ),
          ),
          Container(width: 1, height: 38, color: const Color(0xFFEDE6FA)),
          Expanded(
            child: _buildMarkField(
              icon: Icons.bookmark_rounded,
              title: 'CE- max ${widget.maxCe}',
              controller: student.ceController,
              maximumMark: widget.maxCe,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkField({
    required IconData icon,
    required String title,
    required TextEditingController controller,
    required int maximumMark,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 7),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 25,
                height: 25,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(icon, size: 13, color: purple),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Color(0xFF666666), fontSize: 9),
                ),
              ),
            ],
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                final int? enteredMark = int.tryParse(value);

                if (enteredMark != null && enteredMark > maximumMark) {
                  final String maximumValue = maximumMark.toString();

                  controller.value = TextEditingValue(
                    text: maximumValue,
                    selection: TextSelection.collapsed(
                      offset: maximumValue.length,
                    ),
                  );

                  _showMessage('Maximum allowed mark is $maximumMark');
                }
              },
              style: const TextStyle(
                color: purple,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.only(top: 2),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFCACACA)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: purple),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrationField(StudentMark student) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 1, bottom: 2),
          child: Text(
            'Narration',
            style: TextStyle(color: Color(0xFF555555), fontSize: 8),
          ),
        ),
        TextField(
          controller: student.narrationController,
          maxLines: 2,
          minLines: 2,
          style: const TextStyle(color: Colors.black, fontSize: 9),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF3F5FC),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(color: primaryBlue),
            ),
          ),
        ),
      ],
    );
  }
}

class StudentMark {
  final int? admissionId;
  final String id;
  final String name;
  final String grade;

  bool isPresent;

  final TextEditingController teController;
  final TextEditingController ceController;
  final TextEditingController narrationController;

  StudentMark({
    required this.admissionId,
    required this.id,
    required this.name,
    required this.grade,
    required this.isPresent,
    required String teMark,
    required String ceMark,
    required String narration,
  }) : teController = TextEditingController(text: teMark),
       ceController = TextEditingController(text: ceMark),
       narrationController = TextEditingController(text: narration);

  void dispose() {
    teController.dispose();
    ceController.dispose();
    narrationController.dispose();
  }
}
