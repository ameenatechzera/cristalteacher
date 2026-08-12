import 'package:cristalteacher/core/appdata/appdata.dart';
import 'package:cristalteacher/features/attendance/domain/entities/fetch_attendancedetails_entity.dart';
import 'package:cristalteacher/features/attendance/domain/parameters/fetch_attendancedetails_parameter.dart';
import 'package:cristalteacher/features/attendance/domain/parameters/save_attendance_parameter.dart';
import 'package:cristalteacher/features/attendance/presentation/cubit/attendance_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StudentAttendanceScreen extends StatefulWidget {
  final DateTime attendanceDate;

  final int standardId;
  final String standard;

  final int divisionId;
  final String division;

  final String section;
  final String narration;

  const StudentAttendanceScreen({
    super.key,
    required this.attendanceDate,
    required this.standardId,
    required this.standard,
    required this.divisionId,
    required this.division,
    required this.section,
    required this.narration,
  });

  @override
  State<StudentAttendanceScreen> createState() =>
      _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  final TextEditingController searchController = TextEditingController();

  String searchText = '';
  bool showSearchField = false;

  final Map<int, bool> attendanceStatus = {};
  final Map<int, String?> leaveTypes = {};
  final Map<int, String> remarks = {};

  List<AttendanceDetailsData> students = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchAttendanceDetails();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _fetchAttendanceDetails() {
    final String? accYear = AppData.accYear;

    if (accYear == null || accYear.trim().isEmpty) {
      _showMessage('Academic year is not available');
      return;
    }

    attendanceStatus.clear();
    leaveTypes.clear();
    remarks.clear();

    final request = AttendanceDetailsRequest(
      accyear: accYear,
      standard: widget.standardId,
      division: widget.divisionId,
      gender: AppData.gender,
      sortBy: 'alphabetic',
    );

    debugPrint('==========================================');
    debugPrint('📘 FETCH ATTENDANCE DETAILS');
    debugPrint('Request: ${request.toJson()}');
    debugPrint('Date: ${_formatApiDate(widget.attendanceDate)}');
    debugPrint('Standard: ${widget.standard}');
    debugPrint('Division: ${widget.division}');
    debugPrint('Section: ${widget.section}');
    debugPrint('Narration: ${widget.narration}');
    debugPrint('==========================================');

    context.read<AttendanceCubit>().fetchAttendanceDetails(request);
  }

  int _studentKey(AttendanceDetailsData student, int index) {
    return student.admissionId ?? -(index + 1);
  }

  bool _isPresent(AttendanceDetailsData student, int index) {
    final int key = _studentKey(student, index);

    return attendanceStatus[key] ?? true;
  }

  List<AttendanceDetailsData> _filterStudents(
    List<AttendanceDetailsData> source,
  ) {
    final String query = searchText.trim().toLowerCase();

    if (query.isEmpty) {
      return source;
    }

    return source.where((student) {
      final String name = student.name?.toLowerCase() ?? '';

      final String admissionNumber = student.admno?.toLowerCase() ?? '';

      final String admissionId = student.admissionId?.toString() ?? '';

      return name.contains(query) ||
          admissionNumber.contains(query) ||
          admissionId.contains(query);
    }).toList();
  }

  int _originalIndex(
    List<AttendanceDetailsData> source,
    AttendanceDetailsData student,
  ) {
    return source.indexWhere((item) {
      if (student.admissionId != null && item.admissionId != null) {
        return student.admissionId == item.admissionId;
      }

      return identical(student, item);
    });
  }

  int _presentCount(List<AttendanceDetailsData> source) {
    int count = 0;

    for (int index = 0; index < source.length; index++) {
      if (_isPresent(source[index], index)) {
        count++;
      }
    }

    return count;
  }

  int _absentCount(List<AttendanceDetailsData> source) {
    return source.length - _presentCount(source);
  }

  double _attendancePercentage(List<AttendanceDetailsData> source) {
    if (source.isEmpty) {
      return 0;
    }

    return (_presentCount(source) / source.length) * 100;
  }

  String _formatDisplayDate(DateTime date) {
    final String day = date.day.toString().padLeft(2, '0');

    final String month = date.month.toString().padLeft(2, '0');

    return '$day/$month/${date.year}';
  }

  String _formatApiDate(DateTime date) {
    final String month = date.month.toString().padLeft(2, '0');

    final String day = date.day.toString().padLeft(2, '0');

    return '${date.year}-$month-$day';
  }

  void _saveAttendance() {
    if (students.isEmpty) {
      _showMessage('No students available');
      return;
    }

    final String? accYear = AppData.accYear;
    final int? userId = AppData.userId;

    const int branchId = 1;

    debugPrint('==========================================');
    debugPrint('📘 SAVE ATTENDANCE VALIDATION');
    debugPrint('AccYear: $accYear');
    debugPrint('Branch ID: $branchId');
    debugPrint('User ID: $userId');
    debugPrint('Standard ID: ${widget.standardId}');
    debugPrint('Division ID: ${widget.divisionId}');
    debugPrint('Section: ${widget.section}');
    debugPrint('==========================================');

    if (accYear == null || accYear.trim().isEmpty) {
      _showMessage('Academic year is not available');
      return;
    }

    if (userId == null) {
      _showMessage('User ID is not available');
      return;
    }

    final List<StudentAttendanceDetailRequest> attendanceDetails = [];

    for (int index = 0; index < students.length; index++) {
      final AttendanceDetailsData student = students[index];
      final int key = _studentKey(student, index);
      final bool isPresent = attendanceStatus[key] ?? true;

      final String admissionNo = student.admno?.trim() ?? '';

      if (admissionNo.isEmpty) {
        _showMessage(
          'Admission number is missing for ${student.name ?? 'a student'}',
        );
        return;
      }

      attendanceDetails.add(
        StudentAttendanceDetailRequest(
          admissionNo: admissionNo,
          sessionName: widget.section,
          status: isPresent ? 'Present' : 'Absent',
          leaveTypeId: isPresent ? null : leaveTypes[key],
          remarks: isPresent ? null : (remarks[key] ?? ''),
        ),
      );
    }

    final SaveAttendanceRequest request = SaveAttendanceRequest(
      date: _formatApiDate(widget.attendanceDate),
      accYear: accYear,
      narration: widget.narration,
      standardId: widget.standardId,
      divisionId: widget.divisionId,
      branchId: branchId,
      createdUser: userId.toString(),
      studentAttendanceDetails: attendanceDetails,
    );

    debugPrint('==========================================');
    debugPrint('📘 SAVE ATTENDANCE REQUEST');
    debugPrint(request.toJson().toString());
    debugPrint('==========================================');

    context.read<AttendanceCubit>().saveAttendance(request);
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
  Widget build(BuildContext context) {
    return BlocConsumer<AttendanceCubit, AttendanceState>(
      listener: (context, state) {
        if (state is AttendanceFailure) {
          _showMessage(state.message);
        }

        if (state is SaveAttendanceFailure) {
          _showMessage(state.message);
        }

        if (state is SaveAttendanceSuccess) {
          _showMessage('Attendance saved successfully');

          Future.delayed(const Duration(milliseconds: 500), () {
            if (!mounted) {
              return;
            }
            Navigator.of(context).pop();
            Navigator.of(context).pop(true);
          });
        }
      },
      builder: (context, state) {
        if (state is AttendanceSuccess) {
          students = state.response.data ?? [];
        }

        final bool isSaving = state is SaveAttendanceLoading;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              onPressed: isSaving
                  ? null
                  : () {
                      Navigator.maybePop(context);
                    },
              icon: const Icon(
                Icons.arrow_back,
                size: 27,
                color: Color(0xFF202020),
              ),
            ),
            title: const Text(
              'Attendance',
              style: TextStyle(
                color: Color(0xFF111111),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              TextButton(
                onPressed: students.isEmpty || isSaving
                    ? null
                    : _saveAttendance,
                child: isSaving
                    ? const SizedBox(
                        width: 19,
                        height: 19,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFF8069E8),
                        ),
                      )
                    : Text(
                        'Save',
                        style: TextStyle(
                          color: students.isEmpty
                              ? Colors.grey
                              : const Color(0xFF8069E8),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: SafeArea(
            top: false,
            child: _buildBody(state: state, students: students),
          ),
        );
      },
    );
  }

  Widget _buildBody({
    required AttendanceState state,
    required List<AttendanceDetailsData> students,
  }) {
    if (state is AttendanceLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF8069E8)),
      );
    }

    if (state is AttendanceFailure) {
      return _buildErrorView(state.message);
    }

    if (students.isEmpty) {
      return _buildEmptyView();
    }

    return _buildAttendanceContent(students);
  }

  Widget _buildAttendanceContent(List<AttendanceDetailsData> source) {
    final List<AttendanceDetailsData> filteredStudents = _filterStudents(
      source,
    );

    return RefreshIndicator(
      color: const Color(0xFF8069E8),
      onRefresh: () async {
        _fetchAttendanceDetails();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
        child: Column(
          children: [
            _buildSummaryCard(source),

            const SizedBox(height: 20),

            _buildSearchSection(),

            const SizedBox(height: 18),

            if (filteredStudents.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 70),
                child: Text(
                  'No students found',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredStudents.length,
                separatorBuilder: (_, __) {
                  return const SizedBox(height: 18);
                },
                itemBuilder: (context, index) {
                  final AttendanceDetailsData student = filteredStudents[index];

                  final int originalIndex = _originalIndex(source, student);

                  return _buildStudentCard(
                    student: student,
                    index: originalIndex >= 0 ? originalIndex : index,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(List<AttendanceDetailsData> source) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF102F82), Color(0xFF1C4DA8)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 105,
            top: 6,
            child: Container(
              width: 110,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 125,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
              decoration: BoxDecoration(
                color: const Color(0xFF506FC6).withOpacity(0.88),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem(
                        title: 'Present',
                        value: _presentCount(source).toString(),
                      ),
                      _buildStatItem(
                        title: 'Absent',
                        value: _absentCount(source).toString(),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem(
                        title: 'Total',
                        value: source.length.toString(),
                      ),
                      _buildStatItem(
                        title: 'Attendance',
                        value:
                            '${_attendancePercentage(source).toStringAsFixed(0)}%',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 18,
            right: 125,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: _buildInfoItem(
                        iconPath: 'assets/icons/Group (12).svg',
                        iconColor: const Color(0xFFFCFFBB),
                        label: 'Date',
                        value: _formatDisplayDate(widget.attendanceDate),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 5,
                      child: _buildInfoItem(
                        iconPath: 'assets/icons/Group (13).svg',
                        iconColor: const Color(0xFFC5E5FF),
                        label: 'Section',
                        value: widget.section,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: _buildInfoItem(
                        iconPath: 'assets/icons/Group 950.svg',
                        iconColor: const Color(0xFF98FFEE),
                        label: 'Standard',
                        value: widget.standard,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 5,
                      child: _buildInfoItem(
                        iconPath: 'assets/icons/Vector (2).svg',
                        iconColor: const Color(0xFFFFA5A5),
                        label: 'Division',
                        value: widget.division,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required String iconPath,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: SvgPicture.asset(iconPath, width: 17, height: 17),
        ),
        const SizedBox(width: 7),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  value,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem({required String title, required String value}) {
    final bool isAbsent = title == 'Absent';

    return SizedBox(
      width: 48,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 9)),
          const SizedBox(height: 7),
          SizedBox(
            width: 28,
            height: 28,
            child: isAbsent
                ? Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Color(0xFFFF3B30),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Attendance Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  showSearchField = !showSearchField;

                  if (!showSearchField) {
                    searchController.clear();
                    searchText = '';
                  }
                });
              },
              borderRadius: BorderRadius.circular(24),
              child: Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: Color(0xFF7A6AE6),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  showSearchField ? Icons.close : Icons.search_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        if (showSearchField) ...[
          const SizedBox(height: 14),
          TextField(
            controller: searchController,
            autofocus: true,
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search student',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchText.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        searchController.clear();

                        setState(() {
                          searchText = '';
                        });
                      },
                      icon: const Icon(Icons.close),
                    ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStudentCard({
    required AttendanceDetailsData student,
    required int index,
  }) {
    final int key = _studentKey(student, index);

    final bool isPresent = attendanceStatus[key] ?? true;

    final Color backgroundColor = isPresent
        ? const Color(0xFFF6F6FF)
        : const Color(0xFFFFE3E5);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#${index + 1}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Text(
                      student.name ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Text(
                      student.admno ?? '',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: isPresent
                          ? const Color(0xFFA5FF91)
                          : const Color(0xFFF0222E),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isPresent ? 'Present' : 'Absent',
                      style: TextStyle(
                        color: isPresent
                            ? const Color(0xFF174F0E)
                            : Colors.white,
                      ),
                    ),
                  ),
                  Switch(
                    value: isPresent,
                    activeTrackColor: const Color(0xFF28D10C),
                    inactiveTrackColor: const Color(0xFFF0222E),
                    onChanged: (value) {
                      setState(() {
                        attendanceStatus[key] = value;

                        if (value) {
                          leaveTypes[key] = null;
                          remarks[key] = '';
                        }
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          if (!isPresent) ...[
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: leaveTypes[key],
                    hint: const Text('Select Leave Type'),
                    items: const [
                      DropdownMenuItem(
                        value: 'Sick Leave',
                        child: Text('Sick Leave'),
                      ),
                      DropdownMenuItem(
                        value: 'Casual Leave',
                        child: Text('Casual Leave'),
                      ),
                      DropdownMenuItem(
                        value: 'Emergency Leave',
                        child: Text('Emergency Leave'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        leaveTypes[key] = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    initialValue: remarks[key] ?? '',
                    onChanged: (value) {
                      remarks[key] = value;
                    },
                    decoration: const InputDecoration(hintText: 'Remark'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _fetchAttendanceDetails,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView() {
    return const Center(child: Text('No students found'));
  }
}
