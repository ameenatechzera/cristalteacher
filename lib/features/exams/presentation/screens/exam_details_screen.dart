// import 'package:cristalteacher/core/appdata/appdata.dart';
// import 'package:cristalteacher/features/attendance/domain/entities/fetch_attendancedetails_entity.dart';
// import 'package:cristalteacher/features/attendance/domain/parameters/fetch_attendancedetails_parameter.dart';
// import 'package:cristalteacher/features/attendance/presentation/cubit/attendance_cubit.dart';
// import 'package:cristalteacher/features/exams/domain/parameters/save_exam_parameter.dart';
// import 'package:cristalteacher/features/exams/domain/parameters/update_exam_parameter.dart';
// import 'package:cristalteacher/features/exams/presentation/cubit/exam_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class ExamDetailsScreen extends StatefulWidget {
//   final AttendanceDetailsRequest request;

//   final int examId;
//   final String examName;

//   final int examTermId;
//   final int examTypeId;

//   final int gradePlanId;
//   final String gradePlanName;

//   final DateTime examDate;

//   final int standardId;
//   final String standardName;

//   final int divisionId;
//   final String divisionName;

//   final int subjectId;
//   final String subjectName;

//   final int maxTe;
//   final int maxCe;

//   final bool isEditMode;

//   // Kept because your existing edit flow may use this
//   // to fetch existing mark entry details.
//   final int? markEntryId;

//   const ExamDetailsScreen({
//     super.key,
//     required this.request,
//     required this.examId,
//     required this.examName,
//     required this.examTermId,
//     required this.examTypeId,
//     required this.gradePlanId,
//     required this.gradePlanName,
//     required this.examDate,
//     required this.standardId,
//     required this.standardName,
//     required this.divisionId,
//     required this.divisionName,
//     required this.subjectId,
//     required this.subjectName,
//     required this.maxTe,
//     required this.maxCe,
//     this.isEditMode = false,
//     this.markEntryId,
//   });

//   @override
//   State<ExamDetailsScreen> createState() => _ExamDetailsScreenState();
// }

// class _ExamDetailsScreenState extends State<ExamDetailsScreen> {
//   static const Color primaryBlue = Color(0xFF0758C9);
//   static const Color purple = Color(0xFF5C20F4);
//   static const Color lightPurple = Color(0xFFF7F3FF);
//   static const Color green = Color(0xFF22C900);

//   final TextEditingController searchController = TextEditingController();

//   final List<StudentMark> students = [];

//   bool isLoading = true;
//   bool isSaving = false;

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       loadStudents();
//     });
//   }

//   void loadStudents() {
//     if (!mounted) return;

//     setState(() {
//       isLoading = true;
//     });

//     if (widget.isEditMode) {
//       if (widget.markEntryId == null) {
//         setState(() {
//           isLoading = false;
//         });

//         showMessage('Mark entry ID is unavailable');
//         return;
//       }

//       print('==========================================');
//       print('✏️ EDIT MODE');
//       print('Fetching Mark Entry Details');
//       print('MarkEntryId: ${widget.markEntryId}');
//       print('ExamId: ${widget.examId}');
//       print('==========================================');

//       context.read<ExamCubit>().fetchMarkEntryDetails(widget.markEntryId!);
//     } else {
//       print('==========================================');
//       print('📝 NEW EXAM MODE');
//       print('Fetching Attendance Details');
//       print('==========================================');
//       debugPrint('ADD MODE STUDENT REQUEST: ${widget.request.toJson()}');
//       context.read<AttendanceCubit>().fetchAttendanceDetails(widget.request);
//     }
//   }

//   void showMessage(String message) {
//     if (!mounted) return;

//     ScaffoldMessenger.of(context)
//       ..hideCurrentSnackBar()
//       ..showSnackBar(
//         SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
//       );
//   }

//   String formatExamDate() {
//     return '${widget.examDate.year.toString().padLeft(4, '0')}-'
//         '${widget.examDate.month.toString().padLeft(2, '0')}-'
//         '${widget.examDate.day.toString().padLeft(2, '0')}';
//   }

//   void saveDetails() {
//     if (students.isEmpty) {
//       showMessage('No students available');
//       return;
//     }

//     // Validate marks
//     for (final student in students) {
//       final te = int.tryParse(student.teController.text.trim());

//       final ce = int.tryParse(student.ceController.text.trim());

//       if (te != null && te > widget.maxTe) {
//         showMessage(
//           'TE mark for ${student.name} cannot exceed ${widget.maxTe}',
//         );
//         return;
//       }

//       if (ce != null && ce > widget.maxCe) {
//         showMessage(
//           'CE mark for ${student.name} cannot exceed ${widget.maxCe}',
//         );
//         return;
//       }
//     }

//     final examDate = formatExamDate();

//     if (widget.isEditMode) {
//       updateExam(examDate);
//     } else {
//       saveExam(examDate);
//     }
//   }

//   // ============================================================
//   // UPDATE EXAM
//   // ============================================================

//   void updateExam(String examDate) {
//     print('');
//     print('==========================================');
//     print('✏️ UPDATE MARK ENTRY');
//     print('==========================================');

//     print('employeeId: ${AppData.employeeId ?? 0}');
//     print('AccYear: ${AppData.accYear ?? ''}');
//     print('examId: ${widget.examId}');
//     print('StandardId: ${widget.standardId}');
//     print('DivisionId: ${widget.divisionId}');
//     print('SubjectId: ${widget.subjectId}');
//     print('GradePlanId: ${widget.gradePlanId}');
//     print('MaxTE: ${widget.maxTe}');
//     print('MaxCE: ${widget.maxCe}');
//     print('ExamDate: $examDate');
//     print('Status: true');
//     print('branchId: ${AppData.branchId ?? 1}');
//     print('ModifiedUser: ${AppData.userId ?? 0}');
//     print('Student count: ${students.length}');

//     final details = students.map((student) {
//       final detail = MarkEntryDetailParameter(
//         admno: student.id,
//         te: student.teController.text.trim(),
//         ce: student.ceController.text.trim(),
//         grade: student.grade,
//         absent: student.isPresent ? 'N' : 'Y',
//         isOptional: false,
//         status: true,
//         narration: student.narrationController.text.trim(),
//       );

//       print('------------------------------------------');
//       print('Student: ${student.name}');
//       print('Admno: ${detail.admno}');
//       print('TE: ${detail.te}');
//       print('CE: ${detail.ce}');
//       print('GRADE: ${detail.grade}');
//       print('Absent: ${detail.absent}');
//       print('isOptional: ${detail.isOptional}');
//       print('Status: ${detail.status}');
//       print('Narration: ${detail.narration}');

//       return detail;
//     }).toList();

//     final parameter = UpdateMarkEntryParameter(
//       employeeId: AppData.employeeId ?? 0,
//       accYear: AppData.accYear ?? '',
//       examId: widget.examId,
//       standardId: widget.standardId,
//       divisionId: widget.divisionId,
//       subjectId: widget.subjectId,
//       gradePlanId: widget.gradePlanId,
//       maxTE: widget.maxTe,
//       maxCE: widget.maxCe,
//       examDate: examDate,
//       status: true,
//       branchId: AppData.branchId ?? 1,
//       modifiedUser: AppData.userId ?? 0,
//       details: details,
//     );

//     print('');
//     print('==========================================');
//     print('📤 FINAL UPDATE REQUEST');
//     print(parameter.toJson());
//     print('==========================================');
//     print('');

//     context.read<ExamCubit>().updateMarkEntry(parameter, widget.markEntryId!);
//   }

//   // ============================================================
//   // SAVE EXAM
//   // ============================================================

//   void saveExam(String examDate) {
//     print('');
//     print('==========================================');
//     print('💾 SAVE EXAM MARKS');
//     print('==========================================');

//     final details = students.map((student) {
//       return ExamMarkDetailParameter(
//         admno: student.id,
//         te: student.teController.text.trim(),
//         ce: student.ceController.text.trim(),
//         grade: student.grade,
//         absent: student.isPresent ? 'N' : 'Y',
//         status: true,
//         narration: student.narrationController.text.trim(),
//         isOptional: false,
//       );
//     }).toList();

//     final parameter = SaveExamMarksParameter(
//       employeeId: AppData.employeeId ?? 0,
//       accYear: AppData.accYear ?? '',
//       standardId: widget.standardId,
//       divisionId: widget.divisionId,
//       subjectId: widget.subjectId,
//       gradePlanId: widget.gradePlanId,
//       maxTE: widget.maxTe,
//       maxCE: widget.maxCe,
//       examDate: examDate,
//       status: true,
//       branchId: AppData.branchId ?? 1,
//       createdUser: AppData.userId?.toString() ?? '',
//       examId: widget.examId,
//       details: details,
//     );

//     print('📤 SAVE REQUEST');
//     print(parameter.toJson());
//     print('==========================================');

//     context.read<ExamCubit>().saveExamMarks(parameter);
//   }

//   @override
//   void dispose() {
//     searchController.dispose();

//     for (final student in students) {
//       student.dispose();
//     }

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocListener(
//       listeners: [
//         // ========================================================
//         // ATTENDANCE LISTENER
//         // ========================================================
//         BlocListener<AttendanceCubit, AttendanceState>(
//           listener: (context, state) {
//             if (state is AttendanceSuccess) {
//               for (final student in students) {
//                 student.dispose();
//               }

//               students.clear();

//               final List<AttendanceDetailsData> data =
//                   state.response.data ?? [];

//               print('==========================================');
//               print('📚 ATTENDANCE STUDENTS LOADED');
//               print('Student count: ${data.length}');
//               print('==========================================');

//               for (final item in data) {
//                 final name = item.name?.trim() ?? '';
//                 final admissionNumber = item.admno?.trim() ?? '';

//                 students.add(
//                   StudentMark(
//                     id: admissionNumber.isNotEmpty
//                         ? admissionNumber
//                         : item.admissionId?.toString() ?? '',
//                     name: name.isNotEmpty ? name : 'Unknown Student',
//                     grade: '',
//                     isPresent: true,
//                     te: '',
//                     ce: '',
//                     narration: '',
//                   ),
//                 );
//               }

//               if (mounted) {
//                 setState(() {
//                   isLoading = false;
//                 });
//               }
//             }

//             if (state is AttendanceFailure) {
//               if (mounted) {
//                 setState(() {
//                   isLoading = false;
//                 });
//               }

//               showMessage(state.message);
//             }
//           },
//         ),

//         // ========================================================
//         // EXAM LISTENER
//         // ========================================================
//         BlocListener<ExamCubit, ExamState>(
//           listener: (context, state) {
//             // ----------------------------------------------------
//             // FETCH MARK ENTRY
//             // ----------------------------------------------------

//             if (state is FetchMarkEntryDetailsLoading) {
//               if (mounted) {
//                 setState(() {
//                   isLoading = true;
//                 });
//               }
//             }

//             if (state is FetchMarkEntryDetailsSuccess) {
//               for (final student in students) {
//                 student.dispose();
//               }

//               students.clear();

//               final details = state.response.details;

//               print('==========================================');
//               print('✏️ EXISTING MARK ENTRY LOADED');
//               print('Details count: ${details.length}');
//               print('==========================================');

//               for (final item in details) {
//                 final admissionNumber = item.admno?.toString().trim() ?? '';

//                 final name = item.name?.toString().trim() ?? '';

//                 if (admissionNumber.isEmpty && name.isEmpty) {
//                   continue;
//                 }

//                 students.add(
//                   StudentMark(
//                     id: admissionNumber,
//                     name: name.isNotEmpty ? name : 'Unknown Student',
//                     grade: item.grade?.toString().trim() ?? '',
//                     isPresent:
//                         item.absent?.toString().trim().toUpperCase() != 'Y',
//                     te: item.te?.toString().trim() ?? '',
//                     ce: item.ce?.toString().trim() ?? '',
//                     narration: item.narration?.toString().trim() ?? '',
//                   ),
//                 );
//               }

//               if (mounted) {
//                 setState(() {
//                   isLoading = false;
//                 });
//               }
//             }

//             if (state is FetchMarkEntryDetailsFailure) {
//               if (mounted) {
//                 setState(() {
//                   isLoading = false;
//                 });
//               }

//               showMessage(state.message);
//             }

//             // ----------------------------------------------------
//             // SAVE / UPDATE LOADING
//             // ----------------------------------------------------

//             if (state is SaveExamMarksLoading ||
//                 state is UpdateMarkEntryLoading) {
//               if (mounted) {
//                 setState(() {
//                   isSaving = true;
//                 });
//               }
//             }

//             // ----------------------------------------------------
//             // SAVE SUCCESS
//             // ----------------------------------------------------

//             if (state is SaveExamMarksSuccess) {
//               if (mounted) {
//                 setState(() {
//                   isSaving = false;
//                 });
//               }

//               if (Navigator.canPop(context)) {
//                 Navigator.pop(context, true);
//               }
//             }

//             // ----------------------------------------------------
//             // UPDATE SUCCESS
//             // ----------------------------------------------------

//             if (state is UpdateMarkEntrySuccess) {
//               if (mounted) {
//                 setState(() {
//                   isSaving = false;
//                 });
//               }

//               showMessage('Mark entry updated successfully');

//               if (Navigator.canPop(context)) {
//                 Navigator.pop(context, true);
//               }
//             }

//             // ----------------------------------------------------
//             // SAVE FAILURE
//             // ----------------------------------------------------

//             if (state is SaveExamMarksFailure) {
//               if (mounted) {
//                 setState(() {
//                   isSaving = false;
//                 });
//               }

//               showMessage(state.message);
//             }

//             // ----------------------------------------------------
//             // UPDATE FAILURE
//             // ----------------------------------------------------

//             if (state is UpdateMarkEntryFailure) {
//               if (mounted) {
//                 setState(() {
//                   isSaving = false;
//                 });
//               }

//               showMessage(state.message);
//             }
//           },
//         ),
//       ],
//       child: Builder(
//         builder: (context) {
//           final query = searchController.text.trim().toLowerCase();

//           final filteredStudents = query.isEmpty
//               ? students
//               : students.where((student) {
//                   return student.name.toLowerCase().contains(query) ||
//                       student.id.toLowerCase().contains(query) ||
//                       student.grade.toLowerCase().contains(query);
//                 }).toList();

//           return Scaffold(
//             backgroundColor: const Color(0xFFFAFAFA),
//             appBar: AppBar(
//               backgroundColor: Colors.white,
//               surfaceTintColor: Colors.white,
//               elevation: 0,
//               centerTitle: true,
//               leading: IconButton(
//                 onPressed: isSaving ? null : () => Navigator.pop(context),
//                 icon: const Icon(
//                   Icons.arrow_back,
//                   color: Colors.black,
//                   size: 23,
//                 ),
//               ),
//               title: Text(
//                 widget.isEditMode ? 'Edit Details' : 'Details',
//                 style: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 18),
//                   child: Center(
//                     child: GestureDetector(
//                       onTap: students.isEmpty || isSaving || isLoading
//                           ? null
//                           : saveDetails,
//                       child: Container(
//                         width: 65,
//                         height: 30,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: students.isEmpty || isSaving || isLoading
//                               ? Colors.grey
//                               : primaryBlue,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: isSaving
//                             ? const SizedBox(
//                                 width: 14,
//                                 height: 14,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   color: Colors.white,
//                                 ),
//                               )
//                             : Text(
//                                 widget.isEditMode ? 'Update' : 'Save',
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             body: SafeArea(
//               top: false,
//               child: Column(
//                 children: [
//                   Container(
//                     color: Colors.white,
//                     padding: const EdgeInsets.fromLTRB(18, 14, 18, 13),
//                     child: Column(
//                       children: [
//                         Container(
//                           width: double.infinity,
//                           height: 120,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             gradient: const LinearGradient(
//                               begin: Alignment.centerLeft,
//                               end: Alignment.centerRight,
//                               colors: [Color(0xFF2A0A0A), Color(0xFF902222)],
//                             ),
//                           ),
//                           child: Column(
//                             children: [
//                               const SizedBox(height: 12),
//                               Text(
//                                 widget.examName,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               const Spacer(),
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(
//                                   16,
//                                   0,
//                                   16,
//                                   19,
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: ExamInformation(
//                                         assetPath: 'assets/icons/Group 951.svg',
//                                         iconBackground: const Color(0xFFFFF4A5),
//                                         iconColor: const Color(0xFFCB8500),
//                                         title: 'Standard',
//                                         value: widget.standardName,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: ExamInformation(
//                                         assetPath:
//                                             'assets/icons/Group (17).svg',
//                                         iconBackground: const Color(0xFFFF9BE7),
//                                         iconColor: const Color(0xFFE300AE),
//                                         title: 'Division',
//                                         value: widget.divisionName,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: ExamInformation(
//                                         assetPath:
//                                             'assets/icons/Group (19).svg',
//                                         iconBackground: const Color(0xFF71CFFF),
//                                         iconColor: const Color(0xFF006AAE),
//                                         title: 'Subject',
//                                         value: widget.subjectName,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 13),
//                         TextField(
//                           controller: searchController,
//                           onChanged: (_) => setState(() {}),
//                           style: const TextStyle(
//                             fontSize: 12,
//                             color: Colors.black,
//                           ),
//                           decoration: InputDecoration(
//                             hintText: 'Search',
//                             hintStyle: const TextStyle(
//                               color: Color(0xFF777777),
//                               fontSize: 11,
//                             ),
//                             prefixIcon: const Icon(
//                               Icons.search,
//                               color: Color(0xFF777777),
//                               size: 19,
//                             ),
//                             suffixIcon: searchController.text.isNotEmpty
//                                 ? IconButton(
//                                     onPressed: () {
//                                       searchController.clear();
//                                       setState(() {});
//                                     },
//                                     icon: const Icon(
//                                       Icons.close,
//                                       size: 17,
//                                       color: Colors.grey,
//                                     ),
//                                   )
//                                 : null,
//                             filled: true,
//                             fillColor: Colors.white,
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 12,
//                               vertical: 11,
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(11),
//                               borderSide: const BorderSide(
//                                 color: Color(0xFFD7D7D7),
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(11),
//                               borderSide: const BorderSide(color: primaryBlue),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   // ==================================================
//                   // STUDENT LIST
//                   // ==================================================
//                   Expanded(
//                     child: isLoading
//                         ? const Center(
//                             child: CircularProgressIndicator(
//                               color: primaryBlue,
//                             ),
//                           )
//                         : filteredStudents.isEmpty
//                         ? RefreshIndicator(
//                             color: primaryBlue,
//                             onRefresh: () async {
//                               loadStudents();
//                             },
//                             child: ListView(
//                               physics: const AlwaysScrollableScrollPhysics(),
//                               children: const [
//                                 SizedBox(height: 180),
//                                 Center(
//                                   child: Text(
//                                     'No students found',
//                                     style: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 13,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         : RefreshIndicator(
//                             color: primaryBlue,
//                             onRefresh: () async {
//                               loadStudents();
//                             },
//                             child: ListView.separated(
//                               physics: const AlwaysScrollableScrollPhysics(),
//                               keyboardDismissBehavior:
//                                   ScrollViewKeyboardDismissBehavior.onDrag,
//                               padding: const EdgeInsets.fromLTRB(27, 7, 27, 30),
//                               itemCount: filteredStudents.length,
//                               separatorBuilder: (_, __) =>
//                                   const SizedBox(height: 13),
//                               itemBuilder: (context, index) {
//                                 final student = filteredStudents[index];

//                                 final number = students.indexOf(student) + 1;

//                                 return Container(
//                                   padding: const EdgeInsets.fromLTRB(
//                                     7,
//                                     7,
//                                     7,
//                                     8,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(11),
//                                     border: Border.all(
//                                       color: const Color(0xFFDCDCDC),
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black.withValues(
//                                           alpha: 0.06,
//                                         ),
//                                         blurRadius: 5,
//                                         offset: const Offset(0, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                           horizontal: 8,
//                                         ),
//                                         child: Row(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Expanded(
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Container(
//                                                     padding:
//                                                         const EdgeInsets.symmetric(
//                                                           horizontal: 4,
//                                                           vertical: 1,
//                                                         ),
//                                                     decoration: BoxDecoration(
//                                                       color: const Color(
//                                                         0xFFF4F0FF,
//                                                       ),
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                             2,
//                                                           ),
//                                                     ),
//                                                     child: Text(
//                                                       '#$number',
//                                                       style: const TextStyle(
//                                                         color: purple,
//                                                         fontSize: 14,
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   const SizedBox(height: 2),
//                                                   Text(
//                                                     student.name,
//                                                     style: const TextStyle(
//                                                       color: Colors.black,
//                                                       fontSize: 14,
//                                                       fontWeight:
//                                                           FontWeight.w700,
//                                                     ),
//                                                   ),
//                                                   const SizedBox(height: 5),
//                                                   Text(
//                                                     student.id,
//                                                     style: const TextStyle(
//                                                       color: Color(0xFF777777),
//                                                       fontSize: 9,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),

//                                             if (student.grade.isNotEmpty) ...[
//                                               Text(
//                                                 student.grade,
//                                                 style: const TextStyle(
//                                                   color: green,
//                                                   fontSize: 17,
//                                                   fontWeight: FontWeight.w700,
//                                                   fontStyle: FontStyle.italic,
//                                                 ),
//                                               ),
//                                               const SizedBox(width: 15),
//                                             ],

//                                             GestureDetector(
//                                               onTap: () {
//                                                 setState(() {
//                                                   student.isPresent =
//                                                       !student.isPresent;
//                                                 });
//                                               },
//                                               child: Container(
//                                                 margin: const EdgeInsets.only(
//                                                   top: 3,
//                                                 ),
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                       horizontal: 9,
//                                                       vertical: 7,
//                                                     ),
//                                                 decoration: BoxDecoration(
//                                                   color: student.isPresent
//                                                       ? const Color(0xFFF1FCEB)
//                                                       : const Color(0xFFFFEEEE),
//                                                   borderRadius:
//                                                       BorderRadius.circular(18),
//                                                 ),
//                                                 child: Row(
//                                                   children: [
//                                                     Container(
//                                                       width: 7,
//                                                       height: 7,
//                                                       decoration: BoxDecoration(
//                                                         color: student.isPresent
//                                                             ? green
//                                                             : Colors.red,
//                                                         shape: BoxShape.circle,
//                                                       ),
//                                                     ),
//                                                     const SizedBox(width: 5),
//                                                     Text(
//                                                       student.isPresent
//                                                           ? 'Present'
//                                                           : 'Absent',
//                                                       style: TextStyle(
//                                                         color: student.isPresent
//                                                             ? const Color(
//                                                                 0xFF53A932,
//                                                               )
//                                                             : Colors.red,
//                                                         fontSize: 9,
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),

//                                       const SizedBox(height: 12),

//                                       const Divider(
//                                         height: 1,
//                                         color: Color(0xFFEEEEEE),
//                                       ),

//                                       const SizedBox(height: 5),

//                                       Container(
//                                         height: 64,
//                                         decoration: BoxDecoration(
//                                           color: lightPurple,
//                                           borderRadius: BorderRadius.circular(
//                                             10,
//                                           ),
//                                         ),
//                                         child: Row(
//                                           children: [
//                                             Expanded(
//                                               child: MarkField(
//                                                 icon: Icons.assignment_rounded,
//                                                 title:
//                                                     'TE- max ${widget.maxTe}',
//                                                 controller:
//                                                     student.teController,
//                                                 maximumMark: widget.maxTe,
//                                                 onInvalid: showMessage,
//                                               ),
//                                             ),
//                                             Container(
//                                               width: 1,
//                                               height: 38,
//                                               color: const Color(0xFFEDE6FA),
//                                             ),
//                                             Expanded(
//                                               child: MarkField(
//                                                 icon: Icons.bookmark_rounded,
//                                                 title:
//                                                     'CE- max ${widget.maxCe}',
//                                                 controller:
//                                                     student.ceController,
//                                                 maximumMark: widget.maxCe,
//                                                 onInvalid: showMessage,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),

//                                       const SizedBox(height: 4),

//                                       const Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                             left: 1,
//                                             bottom: 2,
//                                           ),
//                                           child: Text(
//                                             'Narration',
//                                             style: TextStyle(
//                                               color: Color(0xFF555555),
//                                               fontSize: 8,
//                                             ),
//                                           ),
//                                         ),
//                                       ),

//                                       TextField(
//                                         controller: student.narrationController,
//                                         minLines: 2,
//                                         maxLines: 2,
//                                         style: const TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 9,
//                                         ),
//                                         decoration: InputDecoration(
//                                           filled: true,
//                                           fillColor: const Color(0xFFF3F5FC),
//                                           contentPadding:
//                                               const EdgeInsets.symmetric(
//                                                 horizontal: 10,
//                                                 vertical: 10,
//                                               ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderRadius: BorderRadius.circular(
//                                               9,
//                                             ),
//                                             borderSide: BorderSide.none,
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderRadius: BorderRadius.circular(
//                                               9,
//                                             ),
//                                             borderSide: const BorderSide(
//                                               color: primaryBlue,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // ================================================================
// // EXAM INFORMATION
// // ================================================================

// class ExamInformation extends StatelessWidget {
//   final String assetPath;
//   final Color iconBackground;
//   final Color iconColor;
//   final String title;
//   final String value;

//   const ExamInformation({
//     super.key,
//     required this.assetPath,
//     required this.iconBackground,
//     required this.iconColor,
//     required this.title,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: 25,
//           height: 25,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: iconBackground,
//             shape: BoxShape.circle,
//           ),
//           child: SvgPicture.asset(
//             assetPath,
//             width: 14,
//             height: 14,
//             colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
//           ),
//         ),
//         const SizedBox(width: 6),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(color: Colors.white, fontSize: 9),
//               ),
//               Text(
//                 value,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 11,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ================================================================
// // MARK FIELD
// // ================================================================

// class MarkField extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final TextEditingController controller;
//   final int maximumMark;
//   final void Function(String message) onInvalid;

//   const MarkField({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.controller,
//     required this.maximumMark,
//     required this.onInvalid,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 7),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 25,
//                 height: 25,
//                 alignment: Alignment.center,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   icon,
//                   size: 13,
//                   color: _ExamDetailsScreenState.purple,
//                 ),
//               ),
//               const SizedBox(width: 6),
//               Expanded(
//                 child: Text(
//                   title,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(color: Color(0xFF666666), fontSize: 9),
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             child: TextField(
//               controller: controller,
//               keyboardType: TextInputType.number,
//               textAlign: TextAlign.center,
//               inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//               onChanged: (value) {
//                 final enteredMark = int.tryParse(value);

//                 if (enteredMark != null && enteredMark > maximumMark) {
//                   final maximumValue = maximumMark.toString();

//                   controller.value = TextEditingValue(
//                     text: maximumValue,
//                     selection: TextSelection.collapsed(
//                       offset: maximumValue.length,
//                     ),
//                   );

//                   onInvalid('Maximum allowed mark is $maximumMark');
//                 }
//               },
//               style: const TextStyle(
//                 color: _ExamDetailsScreenState.purple,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//               decoration: const InputDecoration(
//                 isDense: true,
//                 contentPadding: EdgeInsets.only(top: 2),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Color(0xFFCACACA)),
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: _ExamDetailsScreenState.purple),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ================================================================
// // STUDENT MARK
// // ================================================================

// class StudentMark {
//   final String id;
//   final String name;
//   final String grade;

//   bool isPresent;

//   final TextEditingController teController;
//   final TextEditingController ceController;
//   final TextEditingController narrationController;

//   StudentMark({
//     required this.id,
//     required this.name,
//     required this.grade,
//     required this.isPresent,
//     required String te,
//     required String ce,
//     required String narration,
//   }) : teController = TextEditingController(text: te),
//        ceController = TextEditingController(text: ce),
//        narrationController = TextEditingController(text: narration);

//   void dispose() {
//     teController.dispose();
//     ceController.dispose();
//     narrationController.dispose();
//   }
// }
import 'package:cristalteacher/core/appdata/appdata.dart';
import 'package:cristalteacher/features/attendance/domain/entities/fetch_attendancedetails_entity.dart';
import 'package:cristalteacher/features/attendance/domain/parameters/fetch_attendancedetails_parameter.dart';
import 'package:cristalteacher/features/attendance/presentation/cubit/attendance_cubit.dart';
import 'package:cristalteacher/features/exams/domain/parameters/save_exam_parameter.dart';
import 'package:cristalteacher/features/exams/domain/parameters/update_exam_parameter.dart';
import 'package:cristalteacher/features/exams/domain/entities/fetch_gradeplan_entity.dart';
import 'package:cristalteacher/features/exams/presentation/cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExamDetailsScreen extends StatefulWidget {
  final AttendanceDetailsRequest request;

  final int examId;
  final String examName;

  final int examTermId;
  final int examTypeId;

  final int gradePlanId;
  final String gradePlanName;
  final List<GradeSettingEntity> gradeSettings;

  final DateTime examDate;

  final int standardId;
  final String standardName;

  final int divisionId;
  final String divisionName;

  final int subjectId;
  final String subjectName;

  final int maxTe;
  final int maxCe;

  final bool isEditMode;

  // Kept because your existing edit flow may use this
  // to fetch existing mark entry details.
  final int? markEntryId;

  const ExamDetailsScreen({
    super.key,
    required this.request,
    required this.examId,
    required this.examName,
    required this.examTermId,
    required this.examTypeId,
    required this.gradePlanId,
    required this.gradePlanName,
    required this.gradeSettings,
    required this.examDate,
    required this.standardId,
    required this.standardName,
    required this.divisionId,
    required this.divisionName,
    required this.subjectId,
    required this.subjectName,
    required this.maxTe,
    required this.maxCe,
    this.isEditMode = false,
    this.markEntryId,
  });

  @override
  State<ExamDetailsScreen> createState() => _ExamDetailsScreenState();
}

class _ExamDetailsScreenState extends State<ExamDetailsScreen> {
  static const Color primaryBlue = Color(0xFF0758C9);
  static const Color purple = Color(0xFF5C20F4);
  static const Color lightPurple = Color(0xFFF7F3FF);
  static const Color green = Color(0xFF22C900);

  final TextEditingController searchController = TextEditingController();

  final List<StudentMark> students = [];

  bool isLoading = true;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadStudents();
    });
  }

  void loadStudents() {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    if (widget.isEditMode) {
      if (widget.markEntryId == null) {
        setState(() {
          isLoading = false;
        });

        showMessage('Mark entry ID is unavailable');
        return;
      }

      print('==========================================');
      print('✏️ EDIT MODE');
      print('Fetching Mark Entry Details');
      print('MarkEntryId: ${widget.markEntryId}');
      print('ExamId: ${widget.examId}');
      print('==========================================');

      context.read<ExamCubit>().fetchMarkEntryDetails(widget.markEntryId!);
    } else {
      print('==========================================');
      print('📝 NEW EXAM MODE');
      print('Fetching Attendance Details');
      print('==========================================');
      debugPrint('ADD MODE STUDENT REQUEST: ${widget.request.toJson()}');
      context.read<AttendanceCubit>().fetchAttendanceDetails(widget.request);
    }
  }

  void showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  void calculateStudentGrade(StudentMark student) {
    final double te = double.tryParse(student.teController.text.trim()) ?? 0;
    final double ce = double.tryParse(student.ceController.text.trim()) ?? 0;
    final double maximumTotal = (widget.maxTe + widget.maxCe).toDouble();

    if (maximumTotal <= 0 ||
        (student.teController.text.trim().isEmpty &&
            student.ceController.text.trim().isEmpty)) {
      setState(() {
        student.grade = '';
      });
      return;
    }

    final double percentage = ((te + ce) / maximumTotal) * 100;
    String calculatedGrade = '';

    for (final setting in widget.gradeSettings) {
      final double? minimum = setting.percentageMin?.toDouble();
      final double? maximum = setting.percentageMax?.toDouble();

      if (minimum == null || maximum == null) continue;

      if (percentage >= minimum && percentage <= maximum) {
        calculatedGrade = setting.gradeSettingName?.trim() ?? '';
        break;
      }
    }

    setState(() {
      student.grade = calculatedGrade;
    });
  }

  String formatExamDate() {
    return '${widget.examDate.year.toString().padLeft(4, '0')}-'
        '${widget.examDate.month.toString().padLeft(2, '0')}-'
        '${widget.examDate.day.toString().padLeft(2, '0')}';
  }

  void saveDetails() {
    if (students.isEmpty) {
      showMessage('No students available');
      return;
    }

    // Validate marks
    for (final student in students) {
      final te = int.tryParse(student.teController.text.trim());

      final ce = int.tryParse(student.ceController.text.trim());

      if (te != null && te > widget.maxTe) {
        showMessage(
          'TE mark for ${student.name} cannot exceed ${widget.maxTe}',
        );
        return;
      }

      if (ce != null && ce > widget.maxCe) {
        showMessage(
          'CE mark for ${student.name} cannot exceed ${widget.maxCe}',
        );
        return;
      }
    }

    final examDate = formatExamDate();

    if (widget.isEditMode) {
      updateExam(examDate);
    } else {
      saveExam(examDate);
    }
  }

  // ============================================================
  // UPDATE EXAM
  // ============================================================

  void updateExam(String examDate) {
    print('');
    print('==========================================');
    print('✏️ UPDATE MARK ENTRY');
    print('==========================================');

    print('employeeId: ${AppData.employeeId ?? 0}');
    print('AccYear: ${AppData.accYear ?? ''}');
    print('examId: ${widget.examId}');
    print('StandardId: ${widget.standardId}');
    print('DivisionId: ${widget.divisionId}');
    print('SubjectId: ${widget.subjectId}');
    print('GradePlanId: ${widget.gradePlanId}');
    print('MaxTE: ${widget.maxTe}');
    print('MaxCE: ${widget.maxCe}');
    print('ExamDate: $examDate');
    print('Status: true');
    print('branchId: ${AppData.branchId ?? 1}');
    print('ModifiedUser: ${AppData.userId ?? 0}');
    print('Student count: ${students.length}');

    final details = students.map((student) {
      final detail = MarkEntryDetailParameter(
        admno: student.id,
        te: student.teController.text.trim(),
        ce: student.ceController.text.trim(),
        grade: student.grade,
        absent: student.isPresent ? 'N' : 'Y',
        isOptional: false,
        status: true,
        narration: student.narrationController.text.trim(),
      );

      print('------------------------------------------');
      print('Student: ${student.name}');
      print('Admno: ${detail.admno}');
      print('TE: ${detail.te}');
      print('CE: ${detail.ce}');
      print('GRADE: ${detail.grade}');
      print('Absent: ${detail.absent}');
      print('isOptional: ${detail.isOptional}');
      print('Status: ${detail.status}');
      print('Narration: ${detail.narration}');

      return detail;
    }).toList();

    final parameter = UpdateMarkEntryParameter(
      employeeId: AppData.employeeId ?? 0,
      accYear: AppData.accYear ?? '',
      examId: widget.examId,
      standardId: widget.standardId,
      divisionId: widget.divisionId,
      subjectId: widget.subjectId,
      gradePlanId: widget.gradePlanId,
      maxTE: widget.maxTe,
      maxCE: widget.maxCe,
      examDate: examDate,
      status: true,
      branchId: AppData.branchId ?? 1,
      modifiedUser: AppData.userId ?? 0,
      details: details,
    );

    print('');
    print('==========================================');
    print('📤 FINAL UPDATE REQUEST');
    print(parameter.toJson());
    print('==========================================');
    print('');

    context.read<ExamCubit>().updateMarkEntry(parameter, widget.markEntryId!);
  }

  // ============================================================
  // SAVE EXAM
  // ============================================================

  void saveExam(String examDate) {
    print('');
    print('==========================================');
    print('💾 SAVE EXAM MARKS');
    print('==========================================');

    final details = students.map((student) {
      return ExamMarkDetailParameter(
        admno: student.id,
        te: student.teController.text.trim(),
        ce: student.ceController.text.trim(),
        grade: student.grade,
        absent: student.isPresent ? 'N' : 'Y',
        status: true,
        narration: student.narrationController.text.trim(),
        isOptional: false,
      );
    }).toList();

    final parameter = SaveExamMarksParameter(
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

    print('📤 SAVE REQUEST');
    print(parameter.toJson());
    print('==========================================');

    context.read<ExamCubit>().saveExamMarks(parameter);
  }

  @override
  void dispose() {
    searchController.dispose();

    for (final student in students) {
      student.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // ========================================================
        // ATTENDANCE LISTENER
        // ========================================================
        BlocListener<AttendanceCubit, AttendanceState>(
          listener: (context, state) {
            if (state is AttendanceSuccess) {
              for (final student in students) {
                student.dispose();
              }

              students.clear();

              final List<AttendanceDetailsData> data =
                  state.response.data ?? [];

              print('==========================================');
              print('📚 ATTENDANCE STUDENTS LOADED');
              print('Student count: ${data.length}');
              print('==========================================');

              for (final item in data) {
                final name = item.name?.trim() ?? '';
                final admissionNumber = item.admno?.trim() ?? '';

                students.add(
                  StudentMark(
                    id: admissionNumber.isNotEmpty
                        ? admissionNumber
                        : item.admissionId?.toString() ?? '',
                    name: name.isNotEmpty ? name : 'Unknown Student',
                    grade: '',
                    isPresent: true,
                    te: '',
                    ce: '',
                    narration: '',
                  ),
                );
              }

              if (mounted) {
                setState(() {
                  isLoading = false;
                });
              }
            }

            if (state is AttendanceFailure) {
              if (mounted) {
                setState(() {
                  isLoading = false;
                });
              }

              showMessage(state.message);
            }
          },
        ),

        // ========================================================
        // EXAM LISTENER
        // ========================================================
        BlocListener<ExamCubit, ExamState>(
          listener: (context, state) {
            // ----------------------------------------------------
            // FETCH MARK ENTRY
            // ----------------------------------------------------

            if (state is FetchMarkEntryDetailsLoading) {
              if (mounted) {
                setState(() {
                  isLoading = true;
                });
              }
            }

            if (state is FetchMarkEntryDetailsSuccess) {
              for (final student in students) {
                student.dispose();
              }

              students.clear();

              final details = state.response.details;

              print('==========================================');
              print('✏️ EXISTING MARK ENTRY LOADED');
              print('Details count: ${details.length}');
              print('==========================================');

              for (final item in details) {
                final admissionNumber = item.admno?.toString().trim() ?? '';

                final name = item.name?.toString().trim() ?? '';

                if (admissionNumber.isEmpty && name.isEmpty) {
                  continue;
                }

                students.add(
                  StudentMark(
                    id: admissionNumber,
                    name: name.isNotEmpty ? name : 'Unknown Student',
                    grade: item.grade?.toString().trim() ?? '',
                    isPresent:
                        item.absent?.toString().trim().toUpperCase() != 'Y',
                    te: item.te?.toString().trim() ?? '',
                    ce: item.ce?.toString().trim() ?? '',
                    narration: item.narration?.toString().trim() ?? '',
                  ),
                );
              }

              if (mounted) {
                setState(() {
                  isLoading = false;
                });
              }
            }

            if (state is FetchMarkEntryDetailsFailure) {
              if (mounted) {
                setState(() {
                  isLoading = false;
                });
              }

              showMessage(state.message);
            }

            // ----------------------------------------------------
            // SAVE / UPDATE LOADING
            // ----------------------------------------------------

            if (state is SaveExamMarksLoading ||
                state is UpdateMarkEntryLoading) {
              if (mounted) {
                setState(() {
                  isSaving = true;
                });
              }
            }

            // ----------------------------------------------------
            // SAVE SUCCESS
            // ----------------------------------------------------

            if (state is SaveExamMarksSuccess) {
              if (mounted) {
                setState(() {
                  isSaving = false;
                });
              }

              if (Navigator.canPop(context)) {
                Navigator.pop(context, true);
              }
            }

            // ----------------------------------------------------
            // UPDATE SUCCESS
            // ----------------------------------------------------

            if (state is UpdateMarkEntrySuccess) {
              if (mounted) {
                setState(() {
                  isSaving = false;
                });
              }

              showMessage('Mark entry updated successfully');

              if (Navigator.canPop(context)) {
                Navigator.pop(context, true);
              }
            }

            // ----------------------------------------------------
            // SAVE FAILURE
            // ----------------------------------------------------

            if (state is SaveExamMarksFailure) {
              if (mounted) {
                setState(() {
                  isSaving = false;
                });
              }

              showMessage(state.message);
            }

            // ----------------------------------------------------
            // UPDATE FAILURE
            // ----------------------------------------------------

            if (state is UpdateMarkEntryFailure) {
              if (mounted) {
                setState(() {
                  isSaving = false;
                });
              }

              showMessage(state.message);
            }
          },
        ),
      ],
      child: Builder(
        builder: (context) {
          final query = searchController.text.trim().toLowerCase();

          final filteredStudents = query.isEmpty
              ? students
              : students.where((student) {
                  return student.name.toLowerCase().contains(query) ||
                      student.id.toLowerCase().contains(query) ||
                      student.grade.toLowerCase().contains(query);
                }).toList();

          return Scaffold(
            backgroundColor: const Color(0xFFFAFAFA),
            appBar: AppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                onPressed: isSaving ? null : () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 23,
                ),
              ),
              title: Text(
                widget.isEditMode ? 'Edit Details' : 'Details',
                style: const TextStyle(
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
                      onTap: students.isEmpty || isSaving || isLoading
                          ? null
                          : saveDetails,
                      child: Container(
                        width: 65,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: students.isEmpty || isSaving || isLoading
                              ? Colors.grey
                              : primaryBlue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: isSaving
                            ? const SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                widget.isEditMode ? 'Update' : 'Save',
                                style: const TextStyle(
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
                        Container(
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
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  0,
                                  16,
                                  19,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ExamInformation(
                                        assetPath: 'assets/icons/Group 951.svg',
                                        iconBackground: const Color(0xFFFFF4A5),
                                        iconColor: const Color(0xFFCB8500),
                                        title: 'Standard',
                                        value: widget.standardName,
                                      ),
                                    ),
                                    Expanded(
                                      child: ExamInformation(
                                        assetPath:
                                            'assets/icons/Group (17).svg',
                                        iconBackground: const Color(0xFFFF9BE7),
                                        iconColor: const Color(0xFFE300AE),
                                        title: 'Division',
                                        value: widget.divisionName,
                                      ),
                                    ),
                                    Expanded(
                                      child: ExamInformation(
                                        assetPath:
                                            'assets/icons/Group (19).svg',
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
                        ),
                        const SizedBox(height: 13),
                        TextField(
                          controller: searchController,
                          onChanged: (_) => setState(() {}),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: const TextStyle(
                              color: Color(0xFF777777),
                              fontSize: 11,
                            ),
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
                                    icon: const Icon(
                                      Icons.close,
                                      size: 17,
                                      color: Colors.grey,
                                    ),
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
                              borderSide: const BorderSide(
                                color: Color(0xFFD7D7D7),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide: const BorderSide(color: primaryBlue),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ==================================================
                  // STUDENT LIST
                  // ==================================================
                  Expanded(
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryBlue,
                            ),
                          )
                        : filteredStudents.isEmpty
                        ? RefreshIndicator(
                            color: primaryBlue,
                            onRefresh: () async {
                              loadStudents();
                            },
                            child: ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: const [
                                SizedBox(height: 180),
                                Center(
                                  child: Text(
                                    'No students found',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : RefreshIndicator(
                            color: primaryBlue,
                            onRefresh: () async {
                              loadStudents();
                            },
                            child: ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              padding: const EdgeInsets.fromLTRB(27, 7, 27, 30),
                              itemCount: filteredStudents.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 13),
                              itemBuilder: (context, index) {
                                final student = filteredStudents[index];

                                final number = students.indexOf(student) + 1;

                                return Container(
                                  padding: const EdgeInsets.fromLTRB(
                                    7,
                                    7,
                                    7,
                                    8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(11),
                                    border: Border.all(
                                      color: const Color(0xFFDCDCDC),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.06,
                                        ),
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 4,
                                                          vertical: 1,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                        0xFFF4F0FF,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            2,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      '#$number',
                                                      style: const TextStyle(
                                                        color: purple,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 2),
                                                  Text(
                                                    student.name,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                              onTap: () {
                                                setState(() {
                                                  student.isPresent =
                                                      !student.isPresent;
                                                });
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  top: 3,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 9,
                                                      vertical: 7,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: student.isPresent
                                                      ? const Color(0xFFF1FCEB)
                                                      : const Color(0xFFFFEEEE),
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 7,
                                                      height: 7,
                                                      decoration: BoxDecoration(
                                                        color: student.isPresent
                                                            ? green
                                                            : Colors.red,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      student.isPresent
                                                          ? 'Present'
                                                          : 'Absent',
                                                      style: TextStyle(
                                                        color: student.isPresent
                                                            ? const Color(
                                                                0xFF53A932,
                                                              )
                                                            : Colors.red,
                                                        fontSize: 9,
                                                        fontWeight:
                                                            FontWeight.w500,
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

                                      const Divider(
                                        height: 1,
                                        color: Color(0xFFEEEEEE),
                                      ),

                                      const SizedBox(height: 5),

                                      Container(
                                        height: 64,
                                        decoration: BoxDecoration(
                                          color: lightPurple,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: MarkField(
                                                icon: Icons.assignment_rounded,
                                                title:
                                                    'TE- max ${widget.maxTe}',
                                                controller:
                                                    student.teController,
                                                maximumMark: widget.maxTe,
                                                onChanged: (_) {
                                                  calculateStudentGrade(
                                                    student,
                                                  );
                                                },
                                                onInvalid: showMessage,
                                              ),
                                            ),
                                            Container(
                                              width: 1,
                                              height: 38,
                                              color: const Color(0xFFEDE6FA),
                                            ),
                                            Expanded(
                                              child: MarkField(
                                                icon: Icons.bookmark_rounded,
                                                title:
                                                    'CE- max ${widget.maxCe}',
                                                controller:
                                                    student.ceController,
                                                maximumMark: widget.maxCe,
                                                onChanged: (_) {
                                                  calculateStudentGrade(
                                                    student,
                                                  );
                                                },
                                                onInvalid: showMessage,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 4),

                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 1,
                                            bottom: 2,
                                          ),
                                          child: Text(
                                            'Narration',
                                            style: TextStyle(
                                              color: Color(0xFF555555),
                                              fontSize: 8,
                                            ),
                                          ),
                                        ),
                                      ),

                                      TextField(
                                        controller: student.narrationController,
                                        minLines: 2,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 9,
                                        ),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xFFF3F5FC),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 10,
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              9,
                                            ),
                                            borderSide: BorderSide.none,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              9,
                                            ),
                                            borderSide: const BorderSide(
                                              color: primaryBlue,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
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
}

// ================================================================
// EXAM INFORMATION
// ================================================================

class ExamInformation extends StatelessWidget {
  final String assetPath;
  final Color iconBackground;
  final Color iconColor;
  final String title;
  final String value;

  const ExamInformation({
    super.key,
    required this.assetPath,
    required this.iconBackground,
    required this.iconColor,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 25,
          height: 25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: iconBackground,
            shape: BoxShape.circle,
          ),
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
}

// ================================================================
// MARK FIELD
// ================================================================

class MarkField extends StatelessWidget {
  final IconData icon;
  final String title;
  final TextEditingController controller;
  final int maximumMark;
  final ValueChanged<String> onChanged;
  final void Function(String message) onInvalid;

  const MarkField({
    super.key,
    required this.icon,
    required this.title,
    required this.controller,
    required this.maximumMark,
    required this.onChanged,
    required this.onInvalid,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 7),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 25,
                height: 25,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 13,
                  color: _ExamDetailsScreenState.purple,
                ),
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
                final enteredMark = int.tryParse(value);

                if (enteredMark != null && enteredMark > maximumMark) {
                  final maximumValue = maximumMark.toString();

                  controller.value = TextEditingValue(
                    text: maximumValue,
                    selection: TextSelection.collapsed(
                      offset: maximumValue.length,
                    ),
                  );

                  onInvalid('Maximum allowed mark is $maximumMark');
                  onChanged(maximumValue);
                  return;
                }

                onChanged(value);
              },
              style: const TextStyle(
                color: _ExamDetailsScreenState.purple,
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
                  borderSide: BorderSide(color: _ExamDetailsScreenState.purple),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// STUDENT MARK
// ================================================================

class StudentMark {
  final String id;
  final String name;
  String grade;

  bool isPresent;

  final TextEditingController teController;
  final TextEditingController ceController;
  final TextEditingController narrationController;

  StudentMark({
    required this.id,
    required this.name,
    required this.grade,
    required this.isPresent,
    required String te,
    required String ce,
    required String narration,
  }) : teController = TextEditingController(text: te),
       ceController = TextEditingController(text: ce),
       narrationController = TextEditingController(text: narration);

  void dispose() {
    teController.dispose();
    ceController.dispose();
    narrationController.dispose();
  }
}
