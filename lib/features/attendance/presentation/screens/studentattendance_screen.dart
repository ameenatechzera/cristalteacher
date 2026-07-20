// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class StudentAttendanceScreen extends StatefulWidget {
//   const StudentAttendanceScreen({super.key});

//   @override
//   State<StudentAttendanceScreen> createState() =>
//       _StudentAttendanceScreenState();
// }

// class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
//   final TextEditingController searchController = TextEditingController();

//   final List<StudentAttendance> students = [
//     StudentAttendance(
//       rollNumber: '#1',
//       name: 'Serin Johnson',
//       admissionNumber: '345678',
//       isPresent: false,
//     ),
//     StudentAttendance(
//       rollNumber: '#2',
//       name: 'Serin Johnson',
//       admissionNumber: '345679',
//       isPresent: true,
//     ),
//     StudentAttendance(
//       rollNumber: '#3',
//       name: 'Serin Johnson',
//       admissionNumber: '345680',
//       isPresent: true,
//     ),
//     StudentAttendance(
//       rollNumber: '#4',
//       name: 'Serin Johnson',
//       admissionNumber: '345681',
//       isPresent: true,
//     ),
//     StudentAttendance(
//       rollNumber: '#5',
//       name: 'Serin Johnson',
//       admissionNumber: '345682',
//       isPresent: true,
//     ),
//   ];

//   String searchText = '';

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   List<StudentAttendance> get filteredStudents {
//     if (searchText.trim().isEmpty) {
//       return students;
//     }

//     final String query = searchText.toLowerCase();

//     return students.where((student) {
//       return student.name.toLowerCase().contains(query) ||
//           student.admissionNumber.toLowerCase().contains(query) ||
//           student.rollNumber.toLowerCase().contains(query);
//     }).toList();
//   }

//   int get presentCount {
//     return students.where((student) => student.isPresent).length;
//   }

//   int get absentCount {
//     return students.where((student) => !student.isPresent).length;
//   }

//   double get attendancePercentage {
//     if (students.isEmpty) return 0;

//     return (presentCount / students.length) * 100;
//   }

//   void saveAttendance() {
//     final List<Map<String, dynamic>> attendanceData = students.map((student) {
//       return {
//         'roll_number': student.rollNumber,
//         'name': student.name,
//         'admission_number': student.admissionNumber,
//         'is_present': student.isPresent,
//         'leave_type': student.leaveType,
//         'remark': student.remark,
//       };
//     }).toList();

//     debugPrint(attendanceData.toString());

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Attendance saved successfully'),
//         behavior: SnackBarBehavior.floating,
//         backgroundColor: Color(0xFF4165C5),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         surfaceTintColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.maybePop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             size: 27,
//             color: Color(0xFF202020),
//           ),
//         ),
//         title: const Text(
//           'Attendance',
//           style: TextStyle(
//             color: Color(0xFF111111),
//             fontSize: 20,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: saveAttendance,
//             child: const Text(
//               'Save',
//               style: TextStyle(
//                 color: Color(0xFF8069E8),
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//         ],
//       ),
//       body: SafeArea(
//         top: false,
//         child: SingleChildScrollView(
//           keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//           padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
//           child: Column(
//             children: [
//               _buildSummaryCard(),

//               const SizedBox(height: 20),

//               _buildSearchField(),

//               const SizedBox(height: 22),

//               ListView.separated(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: filteredStudents.length,
//                 separatorBuilder: (_, __) {
//                   return const SizedBox(height: 18);
//                 },
//                 itemBuilder: (context, index) {
//                   final StudentAttendance student = filteredStudents[index];

//                   return _buildStudentCard(student);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSummaryCard() {
//     return Container(
//       width: double.infinity,
//       height: 150,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF102F82), Color(0xFF1C4DA8)],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         ),
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             left: 105,
//             top: 6,
//             child: Container(
//               width: 110,
//               height: 130,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.04),
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//           Positioned(
//             right: 0,
//             top: 0,
//             bottom: 0,
//             child: Container(
//               width: 132,
//               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF506FC6).withOpacity(0.88),
//                 borderRadius: BorderRadius.circular(24),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buildStatItem(
//                         title: 'Present',
//                         value: presentCount.toString(),
//                       ),
//                       _buildStatItem(
//                         title: 'Absent',
//                         value: absentCount.toString(),
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buildStatItem(
//                         title: 'Total',
//                         value: students.length.toString(),
//                       ),
//                       _buildStatItem(
//                         title: 'Attendance',
//                         value: '${attendancePercentage.toStringAsFixed(0)}%',
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             left: 16,
//             top: 18,
//             right: 136,
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildInfoItem(
//                         iconPath: 'assets/icons/Group (12).svg',
//                         iconColor: const Color(0xFFFCFFBB),
//                         label: 'Date',
//                         value: '17/12/2026',
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: _buildInfoItem(
//                         iconPath: 'assets/icons/Group (13).svg',
//                         iconColor: const Color(0xFFC5E5FF),
//                         label: 'Section',
//                         value: 'Morning',
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 28),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildInfoItem(
//                         iconPath: 'assets/icons/Group 950.svg',
//                         iconColor: const Color(0xFF98FFEE),
//                         label: 'Standard',
//                         value: '10',
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: _buildInfoItem(
//                         iconPath: 'assets/icons/Vector (2).svg',
//                         iconColor: const Color(0xFFFFA5A5),
//                         label: 'Division',
//                         value: 'A',
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget _buildInfoItem({
//   //   required IconData icon,
//   //   required Color iconColor,
//   //   required String label,
//   //   required String value,
//   // }) {
//   //   return Row(
//   //     children: [
//   //       Container(
//   //         width: 34,
//   //         height: 34,
//   //         decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
//   //         child: Icon(icon, size: 18, color: Colors.white),
//   //       ),
//   //       const SizedBox(width: 8),
//   //       Expanded(
//   //         child: Column(
//   //           crossAxisAlignment: CrossAxisAlignment.start,
//   //           children: [
//   //             Text(
//   //               label,
//   //               overflow: TextOverflow.ellipsis,
//   //               style: const TextStyle(
//   //                 color: Colors.white,
//   //                 fontSize: 12,
//   //                 fontWeight: FontWeight.w600,
//   //               ),
//   //             ),
//   //             const SizedBox(height: 3),
//   //             Text(
//   //               value,
//   //               overflow: TextOverflow.ellipsis,
//   //               style: const TextStyle(
//   //                 color: Colors.white,
//   //                 fontSize: 12,
//   //                 fontWeight: FontWeight.w400,
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //       ),
//   //     ],
//   //   );
//   // }

//   Widget _buildInfoItem({
//     required String iconPath,
//     required Color iconColor,
//     required String label,
//     required String value,
//   }) {
//     return Row(
//       children: [
//         Container(
//           width: 34,
//           height: 34,
//           decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
//           child: Center(
//             child: SvgPicture.asset(iconPath, width: 18, height: 18),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 3),
//               Text(
//                 value,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatItem({required String title, required String value}) {
//     final bool isAbsent = title == "Absent";

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 10,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         const SizedBox(height: 8),

//         isAbsent
//             ? Container(
//                 width: 28,
//                 height: 28,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.circle,
//                 ),
//                 alignment: Alignment.center,
//                 child: Text(
//                   value,
//                   style: const TextStyle(
//                     color: Color(0xFFFF3B30),
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               )
//             : Text(
//                 value,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//       ],
//     );
//   }
//   // Widget _buildStatItem({required String title, required String value}) {
//   //   return Column(
//   //     mainAxisSize: MainAxisSize.min,
//   //     children: [
//   //       Text(
//   //         title,
//   //         textAlign: TextAlign.center,
//   //         style: const TextStyle(
//   //           color: Colors.white,
//   //           fontSize: 10,
//   //           fontWeight: FontWeight.w400,
//   //         ),
//   //       ),
//   //       const SizedBox(height: 7),
//   //       Text(
//   //         value,
//   //         style: const TextStyle(
//   //           color: Colors.white,
//   //           fontSize: 18,
//   //           fontWeight: FontWeight.w700,
//   //         ),
//   //       ),
//   //     ],
//   //   );
//   // }

//   Widget _buildSearchField() {
//     return SizedBox(
//       height: 52,
//       child: TextField(
//         controller: searchController,
//         onChanged: (value) {
//           setState(() {
//             searchText = value;
//           });
//         },
//         style: const TextStyle(fontSize: 15, color: Color(0xFF222222)),
//         decoration: InputDecoration(
//           hintText: 'Search',
//           hintStyle: const TextStyle(color: Color(0xFF888888), fontSize: 15),
//           prefixIcon: const Icon(
//             Icons.search,
//             size: 22,
//             color: Color(0xFF888888),
//           ),
//           suffixIcon: searchText.isEmpty
//               ? null
//               : IconButton(
//                   onPressed: () {
//                     searchController.clear();

//                     setState(() {
//                       searchText = '';
//                     });
//                   },
//                   icon: const Icon(
//                     Icons.close,
//                     size: 20,
//                     color: Color(0xFF888888),
//                   ),
//                 ),
//           filled: true,
//           fillColor: const Color(0xFFFAFAFA),
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 14,
//             vertical: 14,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(7),
//             borderSide: const BorderSide(color: Color(0xFFBDBDBD)),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(7),
//             borderSide: const BorderSide(color: Color(0xFF8069E8), width: 1.4),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStudentCard(StudentAttendance student) {
//     final Color backgroundColor = student.isPresent
//         ? const Color(0xFFF6F6FF)
//         : const Color(0xFFFFE3E5);

//     final Color statusBackground = student.isPresent
//         ? const Color(0xFFA5FF91)
//         : const Color(0xFFF0222E);

//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 250),
//       width: double.infinity,
//       padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(18),
//       ),
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       student.rollNumber,
//                       style: const TextStyle(
//                         color: Color(0xFF444444),
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 9),
//                     Text(
//                       student.name,
//                       style: const TextStyle(
//                         color: Color(0xFF252525),
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     const SizedBox(height: 9),
//                     Text(
//                       student.admissionNumber,
//                       style: const TextStyle(
//                         color: Color(0xFF555555),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 7,
//                     ),
//                     decoration: BoxDecoration(
//                       color: statusBackground,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       student.isPresent ? 'Present' : 'Absent',
//                       style: TextStyle(
//                         color: student.isPresent
//                             ? const Color(0xFF174F0E)
//                             : Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 14),
//                   Transform.scale(
//                     scale: 0.9,
//                     child: Switch(
//                       value: student.isPresent,
//                       activeThumbColor: Colors.white,
//                       activeTrackColor: const Color(0xFF28D10C),
//                       inactiveThumbColor: Colors.white,
//                       inactiveTrackColor: const Color(0xFFF0222E),
//                       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                       onChanged: (value) {
//                         setState(() {
//                           student.isPresent = value;

//                           if (value) {
//                             student.leaveType = null;
//                             student.remark = '';
//                           }
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           if (!student.isPresent) ...[
//             const SizedBox(height: 18),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Expanded(
//                   child: DropdownButtonFormField<String>(
//                     value: student.leaveType,
//                     isExpanded: true,
//                     isDense: true,
//                     icon: const Icon(
//                       Icons.keyboard_arrow_down_rounded,
//                       size: 23,
//                       color: Color(0xFF8069E8),
//                     ),
//                     hint: const Text(
//                       'Select Leave Type',
//                       style: TextStyle(fontSize: 12, color: Color(0xFF333333)),
//                     ),
//                     decoration: const InputDecoration(
//                       isDense: true,
//                       contentPadding: EdgeInsets.only(bottom: 7),
//                       border: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Color(0xFF999999)),
//                       ),
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Color(0xFF999999)),
//                       ),
//                       focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Color(0xFF8069E8),
//                           width: 1.4,
//                         ),
//                       ),
//                     ),
//                     items: const [
//                       DropdownMenuItem(
//                         value: 'Sick Leave',
//                         child: Text(
//                           'Sick Leave',
//                           style: TextStyle(fontSize: 12),
//                         ),
//                       ),
//                       DropdownMenuItem(
//                         value: 'Casual Leave',
//                         child: Text(
//                           'Casual Leave',
//                           style: TextStyle(fontSize: 12),
//                         ),
//                       ),
//                       DropdownMenuItem(
//                         value: 'Emergency Leave',
//                         child: Text(
//                           'Emergency Leave',
//                           style: TextStyle(fontSize: 12),
//                         ),
//                       ),
//                     ],
//                     onChanged: (value) {
//                       setState(() {
//                         student.leaveType = value;
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 Expanded(
//                   child: TextFormField(
//                     key: ValueKey(
//                       '${student.admissionNumber}-${student.isPresent}',
//                     ),
//                     initialValue: student.remark,
//                     onChanged: (value) {
//                       student.remark = value;
//                     },
//                     style: const TextStyle(
//                       fontSize: 13,
//                       color: Color(0xFF222222),
//                     ),
//                     decoration: const InputDecoration(
//                       hintText: 'Remark',
//                       hintStyle: TextStyle(
//                         fontSize: 12,
//                         color: Color(0xFF555555),
//                       ),
//                       isDense: true,
//                       contentPadding: EdgeInsets.only(bottom: 7),
//                       border: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Color(0xFF999999)),
//                       ),
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Color(0xFF999999)),
//                       ),
//                       focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Color(0xFF8069E8),
//                           width: 1.4,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }

// class StudentAttendance {
//   final String rollNumber;
//   final String name;
//   final String admissionNumber;

//   bool isPresent;
//   String? leaveType;
//   String remark;

//   StudentAttendance({
//     required this.rollNumber,
//     required this.name,
//     required this.admissionNumber,
//     required this.isPresent,
//     this.leaveType,
//     this.remark = '',
//   });
// }
// import 'package:cristalteacher/core/appdata/appdata.dart';
// import 'package:cristalteacher/features/attendance/domain/entities/fetch_attendancedetails_entity.dart';
// import 'package:cristalteacher/features/attendance/domain/parameters/fetch_attendancedetails_parameter.dart';
// import 'package:cristalteacher/features/attendance/presentation/cubit/attendance_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class StudentAttendanceScreen extends StatefulWidget {
//   final DateTime attendanceDate;

//   final int standardId;
//   final String standard;

//   final int divisionId;
//   final String division;

//   final String section;
//   final String narration;

//   const StudentAttendanceScreen({
//     super.key,
//     required this.attendanceDate,
//     required this.standardId,
//     required this.standard,
//     required this.divisionId,
//     required this.division,
//     required this.section,
//     required this.narration,
//   });

//   @override
//   State<StudentAttendanceScreen> createState() =>
//       _StudentAttendanceScreenState();
// }

// class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
//   final TextEditingController searchController = TextEditingController();

//   String searchText = '';
//   bool showSearchField = false;

//   final Map<int, bool> attendanceStatus = {};
//   final Map<int, String?> leaveTypes = {};
//   final Map<int, String> remarks = {};

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _fetchAttendanceDetails();
//     });
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   void _fetchAttendanceDetails() {
//     final String? accYear = AppData.accYear;

//     if (accYear == null || accYear.trim().isEmpty) {
//       _showMessage('Academic year is not available');
//       return;
//     }

//     final request = AttendanceDetailsRequest(
//       accyear: accYear,
//       standard: widget.standardId,
//       division: widget.divisionId,
//       gender: AppData.gender,
//       sortBy: 'alphabetic',
//     );

//     debugPrint('==========================================');
//     debugPrint('📘 FETCH ATTENDANCE DETAILS');
//     debugPrint('Request: ${request.toJson()}');
//     debugPrint('Date: ${_formatApiDate(widget.attendanceDate)}');
//     debugPrint('Standard: ${widget.standard}');
//     debugPrint('Division: ${widget.division}');
//     debugPrint('Section: ${widget.section}');
//     debugPrint('Narration: ${widget.narration}');
//     debugPrint('==========================================');

//     context.read<AttendanceCubit>().fetchAttendanceDetails(request);
//   }

//   int _studentKey(AttendanceDetailsData student, int index) {
//     return student.admissionId ?? -(index + 1);
//   }

//   bool _isPresent(AttendanceDetailsData student, int index) {
//     final int key = _studentKey(student, index);

//     return attendanceStatus[key] ?? true;
//   }

//   List<AttendanceDetailsData> _filterStudents(
//     List<AttendanceDetailsData> students,
//   ) {
//     final String query = searchText.trim().toLowerCase();

//     if (query.isEmpty) {
//       return students;
//     }

//     return students.where((student) {
//       final String name = student.name?.toLowerCase() ?? '';
//       final String admissionNumber = student.admno?.toLowerCase() ?? '';
//       final String admissionId =
//           student.admissionId?.toString().toLowerCase() ?? '';

//       return name.contains(query) ||
//           admissionNumber.contains(query) ||
//           admissionId.contains(query);
//     }).toList();
//   }

//   int _originalIndex(
//     List<AttendanceDetailsData> students,
//     AttendanceDetailsData student,
//   ) {
//     return students.indexWhere((item) {
//       if (student.admissionId != null && item.admissionId != null) {
//         return student.admissionId == item.admissionId;
//       }

//       return identical(student, item);
//     });
//   }

//   int _presentCount(List<AttendanceDetailsData> students) {
//     int count = 0;

//     for (int index = 0; index < students.length; index++) {
//       if (_isPresent(students[index], index)) {
//         count++;
//       }
//     }

//     return count;
//   }

//   int _absentCount(List<AttendanceDetailsData> students) {
//     return students.length - _presentCount(students);
//   }

//   double _attendancePercentage(List<AttendanceDetailsData> students) {
//     if (students.isEmpty) {
//       return 0;
//     }

//     return (_presentCount(students) / students.length) * 100;
//   }

//   String _formatDisplayDate(DateTime date) {
//     final String day = date.day.toString().padLeft(2, '0');
//     final String month = date.month.toString().padLeft(2, '0');
//     final String year = date.year.toString();

//     return '$day/$month/$year';
//   }

//   String _formatApiDate(DateTime date) {
//     final String year = date.year.toString();
//     final String month = date.month.toString().padLeft(2, '0');
//     final String day = date.day.toString().padLeft(2, '0');

//     return '$year-$month-$day';
//   }

//   void _saveAttendance(List<AttendanceDetailsData> students) {
//     final List<Map<String, dynamic>> attendanceData = [];

//     for (int index = 0; index < students.length; index++) {
//       final AttendanceDetailsData student = students[index];
//       final int key = _studentKey(student, index);
//       final bool isPresent = attendanceStatus[key] ?? true;

//       attendanceData.add({
//         'admissionId': student.admissionId,
//         'admissionNumber': student.admno,
//         'name': student.name,
//         'attendanceDate': _formatApiDate(widget.attendanceDate),
//         'standardId': widget.standardId,
//         'divisionId': widget.divisionId,
//         'section': widget.section,
//         'narration': widget.narration,
//         'isPresent': isPresent,
//         'leaveType': isPresent ? null : leaveTypes[key],
//         'remark': isPresent ? '' : remarks[key] ?? '',
//       });
//     }

//     debugPrint('==========================================');
//     debugPrint('📘 ATTENDANCE SAVE DATA');

//     for (final Map<String, dynamic> item in attendanceData) {
//       debugPrint(item.toString());
//     }

//     debugPrint('==========================================');

//     _showMessage('Attendance data prepared successfully');
//   }

//   void _showMessage(String message) {
//     if (!mounted) {
//       return;
//     }

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AttendanceCubit, AttendanceState>(
//       listener: (context, state) {
//         if (state is AttendanceFailure) {
//           _showMessage(state.message);
//         }
//       },
//       builder: (context, state) {
//         final List<AttendanceDetailsData> students = state is AttendanceSuccess
//             ? state.response.data ?? []
//             : [];

//         return Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             surfaceTintColor: Colors.white,
//             elevation: 0,
//             centerTitle: true,
//             leading: IconButton(
//               onPressed: () {
//                 Navigator.maybePop(context);
//               },
//               icon: const Icon(
//                 Icons.arrow_back,
//                 size: 27,
//                 color: Color(0xFF202020),
//               ),
//             ),
//             title: const Text(
//               'Attendance',
//               style: TextStyle(
//                 color: Color(0xFF111111),
//                 fontSize: 20,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: students.isEmpty
//                     ? null
//                     : () {
//                         _saveAttendance(students);
//                       },
//                 child: Text(
//                   'Save',
//                   style: TextStyle(
//                     color: students.isEmpty
//                         ? Colors.grey
//                         : const Color(0xFF8069E8),
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//             ],
//           ),
//           body: SafeArea(
//             top: false,
//             child: _buildBody(state: state, students: students),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildBody({
//     required AttendanceState state,
//     required List<AttendanceDetailsData> students,
//   }) {
//     if (state is AttendanceLoading) {
//       return const Center(
//         child: CircularProgressIndicator(color: Color(0xFF8069E8)),
//       );
//     }

//     if (state is AttendanceFailure) {
//       return _buildErrorView(state.message);
//     }

//     if (state is AttendanceSuccess) {
//       if (students.isEmpty) {
//         return _buildEmptyView();
//       }

//       return _buildAttendanceContent(students);
//     }

//     return const SizedBox.shrink();
//   }

//   Widget _buildAttendanceContent(List<AttendanceDetailsData> students) {
//     final List<AttendanceDetailsData> filteredStudents = _filterStudents(
//       students,
//     );

//     return RefreshIndicator(
//       color: const Color(0xFF8069E8),
//       onRefresh: () async {
//         _fetchAttendanceDetails();
//       },
//       child: SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//         padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
//         child: Column(
//           children: [
//             _buildSummaryCard(students),

//             const SizedBox(height: 20),

//             _buildSearchSection(),

//             const SizedBox(height: 18),

//             if (filteredStudents.isEmpty)
//               const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 70),
//                 child: Text(
//                   'No students found',
//                   style: TextStyle(color: Colors.grey, fontSize: 14),
//                 ),
//               )
//             else
//               ListView.separated(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: filteredStudents.length,
//                 separatorBuilder: (_, __) {
//                   return const SizedBox(height: 18);
//                 },
//                 itemBuilder: (context, index) {
//                   final AttendanceDetailsData student = filteredStudents[index];

//                   final int originalIndex = _originalIndex(students, student);

//                   return _buildStudentCard(
//                     student: student,
//                     index: originalIndex >= 0 ? originalIndex : index,
//                   );
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSummaryCard(List<AttendanceDetailsData> students) {
//     return Container(
//       width: double.infinity,
//       height: 150,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF102F82), Color(0xFF1C4DA8)],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         ),
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             left: 105,
//             top: 6,
//             child: Container(
//               width: 110,
//               height: 130,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.04),
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),

//           Positioned(
//             right: 0,
//             top: 0,
//             bottom: 0,
//             child: Container(
//               width: 125,
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF506FC6).withOpacity(0.88),
//                 borderRadius: BorderRadius.circular(24),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildStatItem(
//                         title: 'Present',
//                         value: _presentCount(students).toString(),
//                       ),
//                       _buildStatItem(
//                         title: 'Absent',
//                         value: _absentCount(students).toString(),
//                       ),
//                     ],
//                   ),

//                   const Spacer(),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildStatItem(
//                         title: 'Total',
//                         value: students.length.toString(),
//                       ),
//                       _buildStatItem(
//                         title: 'Attendance',
//                         value:
//                             '${_attendancePercentage(students).toStringAsFixed(0)}%',
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           Positioned(
//             left: 16,
//             top: 18,
//             right: 125,
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 6,
//                       child: _buildInfoItem(
//                         iconPath: 'assets/icons/Group (12).svg',
//                         iconColor: const Color(0xFFFCFFBB),
//                         label: 'Date',
//                         value: _formatDisplayDate(widget.attendanceDate),
//                       ),
//                     ),

//                     const SizedBox(width: 8),

//                     Expanded(
//                       flex: 5,
//                       child: _buildInfoItem(
//                         iconPath: 'assets/icons/Group (13).svg',
//                         iconColor: const Color(0xFFC5E5FF),
//                         label: 'Section',
//                         value: widget.section,
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 28),

//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 6,
//                       child: _buildInfoItem(
//                         iconPath: 'assets/icons/Group 950.svg',
//                         iconColor: const Color(0xFF98FFEE),
//                         label: 'Standard',
//                         value: widget.standard,
//                       ),
//                     ),

//                     const SizedBox(width: 8),

//                     Expanded(
//                       flex: 5,
//                       child: _buildInfoItem(
//                         iconPath: 'assets/icons/Vector (2).svg',
//                         iconColor: const Color(0xFFFFA5A5),
//                         label: 'Division',
//                         value: widget.division,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoItem({
//     required String iconPath,
//     required Color iconColor,
//     required String label,
//     required String value,
//   }) {
//     return Row(
//       children: [
//         Container(
//           width: 32,
//           height: 32,
//           decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
//           alignment: Alignment.center,
//           child: SvgPicture.asset(iconPath, width: 17, height: 17),
//         ),

//         const SizedBox(width: 7),

//         Flexible(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 maxLines: 1,
//                 softWrap: false,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 11,
//                   fontWeight: FontWeight.w600,
//                   height: 1.1,
//                 ),
//               ),

//               const SizedBox(height: 4),

//               FittedBox(
//                 fit: BoxFit.scaleDown,
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   value,
//                   maxLines: 1,
//                   softWrap: false,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                     height: 1,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatItem({required String title, required String value}) {
//     final bool isAbsent = title == 'Absent';

//     return SizedBox(
//       width: 48,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             title,
//             maxLines: 1,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 9,
//               fontWeight: FontWeight.w400,
//             ),
//           ),

//           const SizedBox(height: 7),

//           SizedBox(
//             width: 28,
//             height: 28,
//             child: isAbsent
//                 ? Container(
//                     alignment: Alignment.center,
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Text(
//                       value,
//                       style: const TextStyle(
//                         color: Color(0xFFFF3B30),
//                         fontSize: 16,
//                         height: 1,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   )
//                 : Center(
//                     child: FittedBox(
//                       fit: BoxFit.scaleDown,
//                       child: Text(
//                         value,
//                         maxLines: 1,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           height: 1,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchSection() {
//     return Column(
//       children: [
//         Row(
//           children: [
//             const Expanded(
//               child: Text(
//                 'Attendance Details',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF333333),
//                 ),
//               ),
//             ),

//             InkWell(
//               onTap: () {
//                 setState(() {
//                   showSearchField = !showSearchField;

//                   if (!showSearchField) {
//                     searchController.clear();
//                     searchText = '';
//                   }
//                 });
//               },
//               borderRadius: BorderRadius.circular(24),
//               child: Container(
//                 width: 42,
//                 height: 42,
//                 decoration: const BoxDecoration(
//                   color: Color(0xFF7A6AE6),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   showSearchField ? Icons.close : Icons.search_rounded,
//                   color: Colors.white,
//                   size: 22,
//                 ),
//               ),
//             ),
//           ],
//         ),

//         if (showSearchField) ...[
//           const SizedBox(height: 14),

//           SizedBox(
//             height: 48,
//             child: TextField(
//               controller: searchController,
//               autofocus: true,
//               onChanged: (value) {
//                 setState(() {
//                   searchText = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 hintText: 'Search student',
//                 prefixIcon: const Icon(Icons.search, color: Color(0xFF888888)),
//                 suffixIcon: searchText.isEmpty
//                     ? null
//                     : IconButton(
//                         onPressed: () {
//                           searchController.clear();

//                           setState(() {
//                             searchText = '';
//                           });
//                         },
//                         icon: const Icon(Icons.close),
//                       ),
//                 filled: true,
//                 fillColor: const Color(0xFFFAFAFA),
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 14,
//                   vertical: 12,
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: const BorderSide(color: Color(0xFFBDBDBD)),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: const BorderSide(
//                     color: Color(0xFF8069E8),
//                     width: 1.4,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ],
//     );
//   }

//   Widget _buildStudentCard({
//     required AttendanceDetailsData student,
//     required int index,
//   }) {
//     final int key = _studentKey(student, index);
//     final bool isPresent = attendanceStatus[key] ?? true;

//     final Color backgroundColor = isPresent
//         ? const Color(0xFFF6F6FF)
//         : const Color(0xFFFFE3E5);

//     final Color statusBackground = isPresent
//         ? const Color(0xFFA5FF91)
//         : const Color(0xFFF0222E);

//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 250),
//       width: double.infinity,
//       padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(18),
//       ),
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '#${index + 1}',
//                       style: const TextStyle(
//                         color: Color(0xFF444444),
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),

//                     const SizedBox(height: 9),

//                     Text(
//                       student.name ?? '',
//                       style: const TextStyle(
//                         color: Color(0xFF252525),
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),

//                     const SizedBox(height: 9),

//                     Text(
//                       student.admno ?? '',
//                       style: const TextStyle(
//                         color: Color(0xFF555555),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 7,
//                     ),
//                     decoration: BoxDecoration(
//                       color: statusBackground,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       isPresent ? 'Present' : 'Absent',
//                       style: TextStyle(
//                         color: isPresent
//                             ? const Color(0xFF174F0E)
//                             : Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 14),

//                   Transform.scale(
//                     scale: 0.9,
//                     child: Switch(
//                       value: isPresent,
//                       activeThumbColor: Colors.white,
//                       activeTrackColor: const Color(0xFF28D10C),
//                       inactiveThumbColor: Colors.white,
//                       inactiveTrackColor: const Color(0xFFF0222E),
//                       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                       onChanged: (value) {
//                         setState(() {
//                           attendanceStatus[key] = value;

//                           if (value) {
//                             leaveTypes[key] = null;
//                             remarks[key] = '';
//                           }
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),

//           if (!isPresent) ...[
//             const SizedBox(height: 18),

//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     height: 46,
//                     padding: const EdgeInsets.symmetric(horizontal: 14),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<String>(
//                         value: leaveTypes[key],
//                         isExpanded: true,
//                         icon: const Icon(
//                           Icons.keyboard_arrow_down_rounded,
//                           color: Color(0xFF8069E8),
//                           size: 24,
//                         ),
//                         hint: const Text(
//                           'Select Leave Type',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Color(0xFF444444),
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         items: const [
//                           DropdownMenuItem(
//                             value: 'Sick Leave',
//                             child: Text('Sick Leave'),
//                           ),
//                           DropdownMenuItem(
//                             value: 'Casual Leave',
//                             child: Text('Casual Leave'),
//                           ),
//                           DropdownMenuItem(
//                             value: 'Emergency Leave',
//                             child: Text('Emergency Leave'),
//                           ),
//                         ],
//                         onChanged: (value) {
//                           setState(() {
//                             leaveTypes[key] = value;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(width: 12),

//                 Expanded(
//                   child: Container(
//                     height: 46,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: TextFormField(
//                       key: ValueKey('$key-$isPresent'),
//                       initialValue: remarks[key] ?? '',
//                       onChanged: (value) {
//                         remarks[key] = value;
//                       },
//                       style: const TextStyle(
//                         fontSize: 12,
//                         color: Color(0xFF333333),
//                       ),
//                       decoration: const InputDecoration(
//                         hintText: 'Remark',
//                         hintStyle: TextStyle(
//                           fontSize: 14,
//                           color: Color(0xFF444444),
//                           fontWeight: FontWeight.w500,
//                         ),
//                         border: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         contentPadding: EdgeInsets.symmetric(
//                           horizontal: 14,
//                           vertical: 13,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildErrorView(String message) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.error_outline, size: 46, color: Colors.redAccent),

//             const SizedBox(height: 12),

//             Text(message, textAlign: TextAlign.center),

//             const SizedBox(height: 18),

//             ElevatedButton(
//               onPressed: _fetchAttendanceDetails,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF8069E8),
//                 foregroundColor: Colors.white,
//               ),
//               child: const Text('Retry'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyView() {
//     return RefreshIndicator(
//       color: const Color(0xFF8069E8),
//       onRefresh: () async {
//         _fetchAttendanceDetails();
//       },
//       child: ListView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         children: const [
//           SizedBox(height: 260),
//           Icon(Icons.people_outline, size: 48, color: Colors.grey),
//           SizedBox(height: 12),
//           Center(
//             child: Text(
//               'No students found',
//               style: TextStyle(fontSize: 14, color: Colors.grey),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
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
          status: isPresent ? 1 : 0,
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
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class StudentAttendanceScreen extends StatefulWidget {
//   final DateTime attendanceDate;

//   final int standardId;
//   final String standard;

//   final int divisionId;
//   final String division;

//   final String section;
//   final String narration;
//   const StudentAttendanceScreen({
//     super.key,

//     required this.attendanceDate,
//     required this.standardId,
//     required this.standard,
//     required this.divisionId,
//     required this.division,
//     required this.section,
//     required this.narration,
//   });

//   @override
//   State<StudentAttendanceScreen> createState() =>
//       _StudentAttendanceScreenState();
// }

// class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
//   final TextEditingController searchController = TextEditingController();

//   final List<StudentAttendance> students = [
//     StudentAttendance(
//       rollNumber: '#1',
//       name: 'Serin Johnson',
//       admissionNumber: '345678',
//       isPresent: false,
//     ),
//     StudentAttendance(
//       rollNumber: '#2',
//       name: 'Serin Johnson',
//       admissionNumber: '345679',
//       isPresent: true,
//     ),
//     StudentAttendance(
//       rollNumber: '#3',
//       name: 'Serin Johnson',
//       admissionNumber: '345680',
//       isPresent: true,
//     ),
//     StudentAttendance(
//       rollNumber: '#4',
//       name: 'Serin Johnson',
//       admissionNumber: '345681',
//       isPresent: true,
//     ),
//     StudentAttendance(
//       rollNumber: '#5',
//       name: 'Serin Johnson',
//       admissionNumber: '345682',
//       isPresent: true,
//     ),
//   ];

//   String searchText = '';

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   List<StudentAttendance> get filteredStudents {
//     if (searchText.trim().isEmpty) {
//       return students;
//     }

//     final String query = searchText.toLowerCase();

//     return students.where((student) {
//       return student.name.toLowerCase().contains(query) ||
//           student.admissionNumber.toLowerCase().contains(query) ||
//           student.rollNumber.toLowerCase().contains(query);
//     }).toList();
//   }

//   int get presentCount {
//     return students.where((student) => student.isPresent).length;
//   }

//   int get absentCount {
//     return students.where((student) => !student.isPresent).length;
//   }

//   double get attendancePercentage {
//     if (students.isEmpty) return 0;

//     return (presentCount / students.length) * 100;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         surfaceTintColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.maybePop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             size: 27,
//             color: Color(0xFF202020),
//           ),
//         ),
//         title: const Text(
//           'Attendance',
//           style: TextStyle(
//             color: Color(0xFF111111),
//             fontSize: 20,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {},
//             child: const Text(
//               'Save',
//               style: TextStyle(
//                 color: Color(0xFF8069E8),
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//         ],
//       ),

//       body: SafeArea(
//         top: false,
//         child: SingleChildScrollView(
//           keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//           padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
//           child: Column(
//             children: [
//               _buildSummaryCard(),

//               const SizedBox(height: 20),

//               _buildSearchField(),

//               const SizedBox(height: 10),

//               ListView.separated(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: filteredStudents.length,
//                 separatorBuilder: (_, __) {
//                   return const SizedBox(height: 18);
//                 },
//                 itemBuilder: (context, index) {
//                   final StudentAttendance student = filteredStudents[index];

//                   return _buildStudentCard(student);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSummaryCard() {
//     return Container(
//       width: double.infinity,
//       height: 150,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF102F82), Color(0xFF1C4DA8)],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         ),
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             left: 105,
//             top: 6,
//             child: Container(
//               width: 110,
//               height: 130,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.04),
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),

//           Positioned(
//             right: 0,
//             top: 0,
//             bottom: 0,
//             child: Container(
//               width: 125,
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF506FC6).withOpacity(0.88),
//                 borderRadius: BorderRadius.circular(24),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildStatItem(
//                         title: 'Present',
//                         value: presentCount.toString(),
//                       ),
//                       _buildStatItem(
//                         title: 'Absent',
//                         value: absentCount.toString(),
//                       ),
//                     ],
//                   ),

//                   const Spacer(),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildStatItem(
//                         title: 'Total',
//                         value: students.length.toString(),
//                       ),
//                       _buildStatItem(
//                         title: 'Attendance',
//                         value: '${attendancePercentage.toStringAsFixed(0)}%',
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           Positioned(
//             left: 16,
//             top: 18,
//             right: 125,
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 6,
//                       child: _buildInfoItem(
//                         iconPath: 'assets/icons/Group (12).svg',
//                         iconColor: const Color(0xFFFCFFBB),
//                         label: 'Date',
//                         value: '17/12/2026',
//                       ),
//                     ),

//                     const SizedBox(width: 8),

//                     Expanded(
//                       flex: 5,
//                       child: _buildInfoItem(
//                         iconPath: 'assets/icons/Group (13).svg',
//                         iconColor: const Color(0xFFC5E5FF),
//                         label: 'Section',
//                         value: 'Morning',
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 28),

//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 6,
//                       child: _buildInfoItem(
//                         iconPath: 'assets/icons/Group 950.svg',
//                         iconColor: const Color(0xFF98FFEE),
//                         label: 'Standard',
//                         value: '10',
//                       ),
//                     ),

//                     const SizedBox(width: 8),

//                     Expanded(
//                       flex: 5,
//                       child: _buildInfoItem(
//                         iconPath: 'assets/icons/Vector (2).svg',
//                         iconColor: const Color(0xFFFFA5A5),
//                         label: 'Division',
//                         value: 'A',
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoItem({
//     required String iconPath,
//     required Color iconColor,
//     required String label,
//     required String value,
//   }) {
//     return Row(
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         Container(
//           width: 32,
//           height: 32,
//           decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
//           alignment: Alignment.center,
//           child: SvgPicture.asset(iconPath, width: 17, height: 17),
//         ),

//         const SizedBox(width: 7),

//         Flexible(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 maxLines: 1,
//                 softWrap: false,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 11,
//                   fontWeight: FontWeight.w600,
//                   height: 1.1,
//                 ),
//               ),

//               const SizedBox(height: 4),

//               FittedBox(
//                 fit: BoxFit.scaleDown,
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   value,
//                   maxLines: 1,
//                   softWrap: false,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                     height: 1,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatItem({required String title, required String value}) {
//     final bool isAbsent = title == 'Absent';

//     return SizedBox(
//       width: 48,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             title,
//             maxLines: 1,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 9,
//               fontWeight: FontWeight.w400,
//             ),
//           ),

//           const SizedBox(height: 7),

//           SizedBox(
//             width: 28,
//             height: 28,
//             child: isAbsent
//                 ? Container(
//                     alignment: Alignment.center,
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Text(
//                       value,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         color: Color(0xFFFF3B30),
//                         fontSize: 16,
//                         height: 1,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   )
//                 : Center(
//                     child: FittedBox(
//                       fit: BoxFit.scaleDown,
//                       child: Text(
//                         value,
//                         textAlign: TextAlign.center,
//                         maxLines: 1,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           height: 1,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget _buildSearchField() {
//   //   return SizedBox(
//   //     height: 52,
//   //     child: TextField(
//   //       controller: searchController,
//   //       onChanged: (value) {
//   //         setState(() {
//   //           searchText = value;
//   //         });
//   //       },
//   //       style: const TextStyle(fontSize: 15, color: Color(0xFF222222)),
//   //       decoration: InputDecoration(
//   //         hintText: 'Search',
//   //         hintStyle: const TextStyle(color: Color(0xFF888888), fontSize: 15),
//   //         prefixIcon: const Icon(
//   //           Icons.search,
//   //           size: 22,
//   //           color: Color(0xFF888888),
//   //         ),
//   //         suffixIcon: searchText.isEmpty
//   //             ? null
//   //             : IconButton(
//   //                 onPressed: () {
//   //                   searchController.clear();

//   //                   setState(() {
//   //                     searchText = '';
//   //                   });
//   //                 },
//   //                 icon: const Icon(
//   //                   Icons.close,
//   //                   size: 20,
//   //                   color: Color(0xFF888888),
//   //                 ),
//   //               ),
//   //         filled: true,
//   //         fillColor: const Color(0xFFFAFAFA),
//   //         contentPadding: const EdgeInsets.symmetric(
//   //           horizontal: 14,
//   //           vertical: 14,
//   //         ),
//   //         enabledBorder: OutlineInputBorder(
//   //           borderRadius: BorderRadius.circular(7),
//   //           borderSide: const BorderSide(color: Color(0xFFBDBDBD)),
//   //         ),
//   //         focusedBorder: OutlineInputBorder(
//   //           borderRadius: BorderRadius.circular(7),
//   //           borderSide: const BorderSide(color: Color(0xFF8069E8), width: 1.4),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//   Widget _buildSearchField() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text(
//           'Attendance Details',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: Color(0xFF333333),
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             // TODO: Open search page or show search field
//           },
//           borderRadius: BorderRadius.circular(24),
//           child: Container(
//             width: 42,
//             height: 42,
//             decoration: const BoxDecoration(
//               color: Color(0xFF7A6AE6),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               Icons.search_rounded,
//               color: Colors.white,
//               size: 22,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStudentCard(StudentAttendance student) {
//     final Color backgroundColor = student.isPresent
//         ? const Color(0xFFF6F6FF)
//         : const Color(0xFFFFE3E5);

//     final Color statusBackground = student.isPresent
//         ? const Color(0xFFA5FF91)
//         : const Color(0xFFF0222E);

//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 250),
//       width: double.infinity,
//       padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(18),
//       ),
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       student.rollNumber,
//                       style: const TextStyle(
//                         color: Color(0xFF444444),
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),

//                     const SizedBox(height: 9),

//                     Text(
//                       student.name,
//                       style: const TextStyle(
//                         color: Color(0xFF252525),
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),

//                     const SizedBox(height: 9),

//                     Text(
//                       student.admissionNumber,
//                       style: const TextStyle(
//                         color: Color(0xFF555555),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 7,
//                     ),
//                     decoration: BoxDecoration(
//                       color: statusBackground,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       student.isPresent ? 'Present' : 'Absent',
//                       style: TextStyle(
//                         color: student.isPresent
//                             ? const Color(0xFF174F0E)
//                             : Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 14),

//                   Transform.scale(
//                     scale: 0.9,
//                     child: Switch(
//                       value: student.isPresent,
//                       activeThumbColor: Colors.white,
//                       activeTrackColor: const Color(0xFF28D10C),
//                       inactiveThumbColor: Colors.white,
//                       inactiveTrackColor: const Color(0xFFF0222E),
//                       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                       onChanged: (value) {
//                         setState(() {
//                           student.isPresent = value;

//                           if (value) {
//                             student.leaveType = null;
//                             student.remark = '';
//                           }
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),

//           if (!student.isPresent) ...[
//             const SizedBox(height: 18),

//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     height: 46,
//                     padding: const EdgeInsets.symmetric(horizontal: 14),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<String>(
//                         value: student.leaveType,
//                         isExpanded: true,
//                         icon: const Icon(
//                           Icons.keyboard_arrow_down_rounded,
//                           color: Color(0xFF8069E8),
//                           size: 24,
//                         ),
//                         hint: const Text(
//                           'Select Leave Type',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Color(0xFF444444),
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         items: const [
//                           DropdownMenuItem(
//                             value: 'Sick Leave',
//                             child: Text('Sick Leave'),
//                           ),
//                           DropdownMenuItem(
//                             value: 'Casual Leave',
//                             child: Text('Casual Leave'),
//                           ),
//                           DropdownMenuItem(
//                             value: 'Emergency Leave',
//                             child: Text('Emergency Leave'),
//                           ),
//                         ],
//                         onChanged: (value) {
//                           setState(() {
//                             student.leaveType = value;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(width: 12),

//                 Expanded(
//                   child: Container(
//                     height: 46,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: TextFormField(
//                       key: ValueKey(
//                         '${student.admissionNumber}-${student.isPresent}',
//                       ),
//                       initialValue: student.remark,
//                       onChanged: (value) {
//                         student.remark = value;
//                       },
//                       style: const TextStyle(
//                         fontSize: 12,
//                         color: Color(0xFF333333),
//                       ),
//                       decoration: const InputDecoration(
//                         hintText: 'Remark',
//                         hintStyle: TextStyle(
//                           fontSize: 14,
//                           color: Color(0xFF444444),
//                           fontWeight: FontWeight.w500,
//                         ),
//                         border: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         contentPadding: EdgeInsets.symmetric(
//                           horizontal: 14,
//                           vertical: 13,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }

// class StudentAttendance {
//   final String rollNumber;
//   final String name;
//   final String admissionNumber;

//   bool isPresent;
//   String? leaveType;
//   String remark;

//   StudentAttendance({
//     required this.rollNumber,
//     required this.name,
//     required this.admissionNumber,
//     required this.isPresent,
//     this.leaveType,
//     this.remark = '',
//   });
// }
// import 'package:cristalteacher/features/attendance/domain/entities/fetch_attendancedetails_entity.dart';
// import 'package:cristalteacher/features/attendance/domain/parameters/fetch_attendancedetails_parameter.dart';
// import 'package:cristalteacher/features/attendance/presentation/cubit/attendance_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class StudentAttendanceScreen extends StatefulWidget {
//   const StudentAttendanceScreen({super.key});

//   @override
//   State<StudentAttendanceScreen> createState() =>
//       _StudentAttendanceScreenState();
// }

// class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
//   final TextEditingController searchController = TextEditingController();

//   String searchText = '';

//   final Map<int, bool> attendanceStatus = {};
//   final Map<int, String?> leaveTypes = {};
//   final Map<int, String> remarks = {};

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _fetchAttendanceDetails();
//     });
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   void _fetchAttendanceDetails() {
//     final request = AttendanceDetailsRequest(
//       accyear: "2026-2027",
//       standard: 1,
//       division: 2,
//       gender: '',
//       sortBy: 'alphabetic',
//     );

//     debugPrint('==========================================');
//     debugPrint('📘 FETCH ATTENDANCE DETAILS');
//     debugPrint('Request: ${request.toJson()}');
//     debugPrint('==========================================');

//     context.read<AttendanceCubit>().fetchAttendanceDetails(request);
//   }

//   void _initializeAttendance(List<AttendanceDetailsData> students) {
//     for (final student in students) {
//       final int id = student.admissionId ?? 0;

//       attendanceStatus.putIfAbsent(id, () => true);
//       leaveTypes.putIfAbsent(id, () => null);
//       remarks.putIfAbsent(id, () => '');
//     }
//   }

//   List<AttendanceDetailsData> _searchStudents(
//     List<AttendanceDetailsData> students,
//   ) {
//     final String query = searchText.trim().toLowerCase();

//     if (query.isEmpty) {
//       return students;
//     }

//     return students.where((student) {
//       final String name = student.name?.toLowerCase() ?? '';
//       final String admissionNumber = student.admno?.toLowerCase() ?? '';
//       final String admissionId = student.admissionId?.toString() ?? '';

//       return name.contains(query) ||
//           admissionNumber.contains(query) ||
//           admissionId.contains(query);
//     }).toList();
//   }

//   int _presentCount(List<AttendanceDetailsData> students) {
//     return students.where((student) {
//       final int id = student.admissionId ?? 0;
//       return attendanceStatus[id] ?? true;
//     }).length;
//   }

//   int _absentCount(List<AttendanceDetailsData> students) {
//     return students.where((student) {
//       final int id = student.admissionId ?? 0;
//       return !(attendanceStatus[id] ?? true);
//     }).length;
//   }

//   double _attendancePercentage(List<AttendanceDetailsData> students) {
//     if (students.isEmpty) {
//       return 0;
//     }

//     return (_presentCount(students) / students.length) * 100;
//   }

//   String get currentDate {
//     final DateTime now = DateTime.now();

//     final String day = now.day.toString().padLeft(2, '0');
//     final String month = now.month.toString().padLeft(2, '0');
//     final String year = now.year.toString();

//     return '$day/$month/$year';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AttendanceCubit, AttendanceState>(
//       listener: (context, state) {
//         if (state is AttendanceSuccess) {
//           final List<AttendanceDetailsData> students =
//               state.response.data ?? [];

//           _initializeAttendance(students);
//         }

//         if (state is AttendanceFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.message),
//               behavior: SnackBarBehavior.floating,
//             ),
//           );
//         }
//       },
//       builder: (context, state) {
//         final List<AttendanceDetailsData> students = state is AttendanceSuccess
//             ? state.response.data ?? []
//             : [];

//         return Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             surfaceTintColor: Colors.white,
//             elevation: 0,
//             centerTitle: true,
//             leading: IconButton(
//               onPressed: () {
//                 Navigator.maybePop(context);
//               },
//               icon: const Icon(
//                 Icons.arrow_back,
//                 size: 27,
//                 color: Color(0xFF202020),
//               ),
//             ),
//             title: const Text(
//               'Attendance',
//               style: TextStyle(
//                 color: Color(0xFF111111),
//                 fontSize: 20,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: students.isEmpty ? null : () {},
//                 child: Text(
//                   'Save',
//                   style: TextStyle(
//                     color: students.isEmpty
//                         ? Colors.grey
//                         : const Color(0xFF8069E8),
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//             ],
//           ),
//           body: SafeArea(top: false, child: _buildBody(state, students)),
//         );
//       },
//     );
//   }

//   Widget _buildBody(
//     AttendanceState state,
//     List<AttendanceDetailsData> students,
//   ) {
//     if (state is AttendanceLoading) {
//       return const Center(
//         child: CircularProgressIndicator(color: Color(0xFF8069E8)),
//       );
//     }

//     if (state is AttendanceFailure) {
//       return _buildErrorView(state.message);
//     }

//     if (state is AttendanceSuccess) {
//       if (students.isEmpty) {
//         return _buildEmptyView();
//       }

//       return _buildAttendanceContent(students);
//     }

//     return const SizedBox.shrink();
//   }

//   Widget _buildAttendanceContent(List<AttendanceDetailsData> students) {
//     final AttendanceDetailsData firstStudent = students.first;

//     final List<AttendanceDetailsData> visibleStudents = _searchStudents(
//       students,
//     );

//     return RefreshIndicator(
//       color: const Color(0xFF8069E8),
//       onRefresh: () async {
//         _fetchAttendanceDetails();
//       },
//       child: SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//         padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
//         child: Column(
//           children: [
//             _buildSummaryCard(
//               students: students,
//               section: firstStudent.sectionName ?? '-',
//               standard: firstStudent.standard ?? '-',
//               division: firstStudent.division ?? '-',
//             ),
//             const SizedBox(height: 20),
//             _buildSearchField(),
//             const SizedBox(height: 22),
//             if (visibleStudents.isEmpty)
//               const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 80),
//                 child: Text(
//                   'No students found',
//                   style: TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//               )
//             else
//               ListView.separated(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: visibleStudents.length,
//                 separatorBuilder: (_, __) {
//                   return const SizedBox(height: 18);
//                 },
//                 itemBuilder: (context, index) {
//                   final AttendanceDetailsData student = visibleStudents[index];

//                   final int originalIndex = students.indexWhere(
//                     (item) => item.admissionId == student.admissionId,
//                   );

//                   return _buildStudentCard(
//                     student: student,
//                     rollNumber: '#${originalIndex + 1}',
//                   );
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSummaryCard({
//     required List<AttendanceDetailsData> students,
//     required String section,
//     required String standard,
//     required String division,
//   }) {
//     return Container(
//       width: double.infinity,
//       height: 150,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF102F82), Color(0xFF1C4DA8)],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         ),
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             left: 105,
//             top: 6,
//             child: Container(
//               width: 110,
//               height: 130,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.04),
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//           Positioned(
//             right: 0,
//             top: 0,
//             bottom: 0,
//             child: Container(
//               width: 125,
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF506FC6).withOpacity(0.88),
//                 borderRadius: BorderRadius.circular(24),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildStatItem(
//                         title: 'Present',
//                         value: _presentCount(students).toString(),
//                       ),
//                       _buildStatItem(
//                         title: 'Absent',
//                         value: _absentCount(students).toString(),
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildStatItem(
//                         title: 'Total',
//                         value: students.length.toString(),
//                       ),
//                       _buildStatItem(
//                         title: 'Attendance',
//                         value:
//                             '${_attendancePercentage(students).toStringAsFixed(0)}%',
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             left: 16,
//             top: 18,
//             right: 125,
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 6,
//                       child: _buildInfoItem(
//                         iconPath: 'assets/icons/Group (12).svg',
//                         iconColor: const Color(0xFFFCFFBB),
//                         label: 'Date',
//                         value: currentDate,
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       flex: 5,
//                       child: _buildInfoItem(
//                         iconPath: 'assets/icons/Group (13).svg',
//                         iconColor: const Color(0xFFC5E5FF),
//                         label: 'Section',
//                         value: section,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 28),
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 6,
//                       child: _buildInfoItem(
//                         iconPath: 'assets/icons/Group 950.svg',
//                         iconColor: const Color(0xFF98FFEE),
//                         label: 'Standard',
//                         value: standard,
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       flex: 5,
//                       child: _buildInfoItem(
//                         iconPath: 'assets/icons/Vector (2).svg',
//                         iconColor: const Color(0xFFFFA5A5),
//                         label: 'Division',
//                         value: division,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoItem({
//     required String iconPath,
//     required Color iconColor,
//     required String label,
//     required String value,
//   }) {
//     return Row(
//       children: [
//         Container(
//           width: 32,
//           height: 32,
//           decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
//           alignment: Alignment.center,
//           child: SvgPicture.asset(iconPath, width: 17, height: 17),
//         ),
//         const SizedBox(width: 7),
//         Flexible(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 maxLines: 1,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 11,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               FittedBox(
//                 fit: BoxFit.scaleDown,
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   value,
//                   maxLines: 1,
//                   style: const TextStyle(color: Colors.white, fontSize: 12),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatItem({required String title, required String value}) {
//     final bool isAbsent = title == 'Absent';

//     return SizedBox(
//       width: 48,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             title,
//             maxLines: 1,
//             textAlign: TextAlign.center,
//             style: const TextStyle(color: Colors.white, fontSize: 9),
//           ),
//           const SizedBox(height: 7),
//           SizedBox(
//             width: 28,
//             height: 28,
//             child: isAbsent
//                 ? Container(
//                     alignment: Alignment.center,
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Text(
//                       value,
//                       style: const TextStyle(
//                         color: Color(0xFFFF3B30),
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   )
//                 : Center(
//                     child: FittedBox(
//                       fit: BoxFit.scaleDown,
//                       child: Text(
//                         value,
//                         maxLines: 1,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchField() {
//     return SizedBox(
//       height: 52,
//       child: TextField(
//         controller: searchController,
//         onChanged: (value) {
//           setState(() {
//             searchText = value;
//           });
//         },
//         decoration: InputDecoration(
//           hintText: 'Search',
//           prefixIcon: const Icon(Icons.search, color: Color(0xFF888888)),
//           suffixIcon: searchText.isEmpty
//               ? null
//               : IconButton(
//                   onPressed: () {
//                     searchController.clear();

//                     setState(() {
//                       searchText = '';
//                     });
//                   },
//                   icon: const Icon(Icons.close),
//                 ),
//           filled: true,
//           fillColor: const Color(0xFFFAFAFA),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(7),
//             borderSide: const BorderSide(color: Color(0xFFBDBDBD)),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(7),
//             borderSide: const BorderSide(color: Color(0xFF8069E8)),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStudentCard({
//     required AttendanceDetailsData student,
//     required String rollNumber,
//   }) {
//     final int admissionId = student.admissionId ?? 0;
//     final bool isPresent = attendanceStatus[admissionId] ?? true;

//     final Color backgroundColor = isPresent
//         ? const Color(0xFFF6F6FF)
//         : const Color(0xFFFFE3E5);

//     final Color statusBackground = isPresent
//         ? const Color(0xFFA5FF91)
//         : const Color(0xFFF0222E);

//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 250),
//       width: double.infinity,
//       padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(18),
//       ),
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       rollNumber,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 9),
//                     Text(
//                       student.name ?? '',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     const SizedBox(height: 9),
//                     Text(
//                       student.admno ?? '',
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Color(0xFF555555),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 7,
//                     ),
//                     decoration: BoxDecoration(
//                       color: statusBackground,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       isPresent ? 'Present' : 'Absent',
//                       style: TextStyle(
//                         color: isPresent
//                             ? const Color(0xFF174F0E)
//                             : Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 14),
//                   Switch(
//                     value: isPresent,
//                     activeThumbColor: Colors.white,
//                     activeTrackColor: const Color(0xFF28D10C),
//                     inactiveThumbColor: Colors.white,
//                     inactiveTrackColor: const Color(0xFFF0222E),
//                     onChanged: (value) {
//                       setState(() {
//                         attendanceStatus[admissionId] = value;

//                         if (value) {
//                           leaveTypes[admissionId] = null;
//                           remarks[admissionId] = '';
//                         }
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           if (!isPresent) ...[
//             const SizedBox(height: 18),
//             Row(
//               children: [
//                 Expanded(
//                   child: DropdownButtonFormField<String>(
//                     value: leaveTypes[admissionId],
//                     isExpanded: true,
//                     hint: const Text(
//                       'Select Leave Type',
//                       style: TextStyle(fontSize: 12),
//                     ),
//                     items: const [
//                       DropdownMenuItem(
//                         value: 'Sick Leave',
//                         child: Text('Sick Leave'),
//                       ),
//                       DropdownMenuItem(
//                         value: 'Casual Leave',
//                         child: Text('Casual Leave'),
//                       ),
//                       DropdownMenuItem(
//                         value: 'Emergency Leave',
//                         child: Text('Emergency Leave'),
//                       ),
//                     ],
//                     onChanged: (value) {
//                       setState(() {
//                         leaveTypes[admissionId] = value;
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 Expanded(
//                   child: TextFormField(
//                     initialValue: remarks[admissionId],
//                     onChanged: (value) {
//                       remarks[admissionId] = value;
//                     },
//                     decoration: const InputDecoration(hintText: 'Remark'),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildErrorView(String message) {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(message),
//           const SizedBox(height: 12),
//           ElevatedButton(
//             onPressed: _fetchAttendanceDetails,
//             child: const Text('Retry'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyView() {
//     return RefreshIndicator(
//       onRefresh: () async {
//         _fetchAttendanceDetails();
//       },
//       child: ListView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         children: const [
//           SizedBox(height: 280),
//           Center(child: Text('No students found')),
//         ],
//       ),
//     );
//   }
// }
