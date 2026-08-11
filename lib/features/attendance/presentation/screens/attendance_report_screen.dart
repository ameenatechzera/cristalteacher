// import 'package:cristalteacher/features/attendance/presentation/screens/attendance_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class AttendanceReportScreen extends StatefulWidget {
//   const AttendanceReportScreen({super.key});

//   @override
//   State<AttendanceReportScreen> createState() => _AttendanceReportScreenState();
// }

// class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
//   static const Color primaryColor = Color(0xFF5D24F4);
//   static const Color blueColor = Color(0xFF0758C9);
//   static const Color lightPurple = Color(0xFFF7F3FF);
//   static const Color borderColor = Color(0xFFE1E1E1);

//   String? selectedStandard;
//   DateTime? fromDate;
//   DateTime? toDate;

//   final List<String> standards = [
//     'Standard 1',
//     'Standard 2',
//     'Standard 3',
//     'Standard 4',
//     'Standard 5',
//     'Standard 6',
//     'Standard 7',
//     'Standard 8',
//     'Standard 9',
//     'Standard 10',
//   ];

//   final List<AttendanceReportItem> attendanceReports = [
//     AttendanceReportItem(
//       id: 1,
//       date: DateTime(2024, 10, 17),
//       standard: '10',
//       division: 'A',
//       section: 'Morning',
//     ),
//     AttendanceReportItem(
//       id: 2,
//       date: DateTime(2024, 10, 17),
//       standard: '10',
//       division: 'A',
//       section: 'Morning',
//     ),
//     AttendanceReportItem(
//       id: 3,
//       date: DateTime(2024, 10, 17),
//       standard: '10',
//       division: 'A',
//       section: 'Morning',
//     ),
//     AttendanceReportItem(
//       id: 4,
//       date: DateTime(2024, 10, 17),
//       standard: '10',
//       division: 'A',
//       section: 'Morning',
//     ),
//   ];

//   List<AttendanceReportItem> get filteredReports {
//     return attendanceReports.where((report) {
//       final selectedStandardNumber = selectedStandard?.replaceAll(
//         'Standard ',
//         '',
//       );

//       final matchesStandard =
//           selectedStandard == null || report.standard == selectedStandardNumber;

//       final reportDate = DateTime(
//         report.date.year,
//         report.date.month,
//         report.date.day,
//       );

//       final matchesFromDate =
//           fromDate == null || !reportDate.isBefore(_dateOnly(fromDate!));

//       final matchesToDate =
//           toDate == null || !reportDate.isAfter(_dateOnly(toDate!));

//       return matchesStandard && matchesFromDate && matchesToDate;
//     }).toList();
//   }

//   DateTime _dateOnly(DateTime date) {
//     return DateTime(date.year, date.month, date.day);
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day.toString().padLeft(2, '0')}-'
//         '${date.month.toString().padLeft(2, '0')}-'
//         '${date.year}';
//   }

//   Future<void> _selectDate({required bool isFromDate}) async {
//     final initialDate = isFromDate
//         ? fromDate ?? DateTime.now()
//         : toDate ?? fromDate ?? DateTime.now();

//     final selectedDate = await showDatePicker(
//       context: context,
//       initialDate: initialDate,
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2040),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: primaryColor,
//               onPrimary: Colors.white,
//               surface: Colors.white,
//               onSurface: Colors.black,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (selectedDate == null) return;

//     setState(() {
//       if (isFromDate) {
//         fromDate = selectedDate;
//       } else {
//         toDate = selectedDate;
//       }
//     });
//   }

//   void _openAttendance(AttendanceReportItem report) {
//     debugPrint('Attendance ID: ${report.id}');
//   }

//   void _addAttendance() {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) {
//           return AttendanceScreen();
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final reports = filteredReports;

//     return Scaffold(
//       backgroundColor: const Color(0xFFFAFAFA),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         surfaceTintColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         toolbarHeight: 58,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back, color: Colors.black, size: 23),
//         ),
//         title: const Text(
//           'Attendance',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 16,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         top: false,
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               color: Colors.white,
//               padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
//               child: Column(
//                 children: [
//                   _buildStandardDropdown(),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: _buildDateField(
//                           title: 'From date',
//                           date: fromDate,
//                           onTap: () {
//                             _selectDate(isFromDate: true);
//                           },
//                           onClear: () {
//                             setState(() {
//                               fromDate = null;
//                             });
//                           },
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: _buildDateField(
//                           date: toDate,
//                           onTap: () {
//                             _selectDate(isFromDate: false);
//                           },
//                           onClear: () {
//                             setState(() {
//                               toDate = null;
//                             });
//                           },
//                           title: 'To date',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: reports.isEmpty
//                   ? const Center(
//                       child: Text(
//                         'No attendance reports found',
//                         style: TextStyle(color: Colors.grey, fontSize: 14),
//                       ),
//                     )
//                   : ListView.separated(
//                       padding: const EdgeInsets.fromLTRB(20, 14, 20, 95),
//                       itemCount: reports.length,
//                       separatorBuilder: (_, __) {
//                         return const SizedBox(height: 12);
//                       },
//                       itemBuilder: (context, index) {
//                         return _buildAttendanceCard(reports[index]);
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: SizedBox(
//         width: 56,
//         height: 56,
//         child: FloatingActionButton(
//           onPressed: _addAttendance,
//           backgroundColor: blueColor,
//           elevation: 4,
//           shape: const CircleBorder(),
//           child: const Icon(Icons.add, color: Colors.white, size: 34),
//         ),
//       ),
//     );
//   }

//   Widget _buildStandardDropdown() {
//     return DropdownButtonFormField<String>(
//       value: selectedStandard,
//       isExpanded: true,
//       icon: const Icon(Icons.keyboard_arrow_down, color: primaryColor),
//       hint: const Text(
//         'Standard',
//         style: TextStyle(fontSize: 12, color: Color(0xFF4B4B4B)),
//       ),
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 12,
//           vertical: 10,
//         ),

//         prefixIcon: Padding(
//           padding: const EdgeInsets.only(left: 12, right: 6),
//           child: SvgPicture.asset(
//             'assets/icons/Group (14).svg',
//             width: 14,
//             height: 14,
//             fit: BoxFit.contain,
//           ),
//         ),

//         // Add this
//         prefixIconConstraints: const BoxConstraints(
//           minWidth: 30,
//           minHeight: 30,
//         ),

//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(11),
//           borderSide: const BorderSide(color: borderColor),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(11),
//           borderSide: const BorderSide(color: primaryColor),
//         ),
//       ),
//       items: standards.map((standard) {
//         return DropdownMenuItem<String>(
//           value: standard,
//           child: Text(
//             standard,
//             style: const TextStyle(fontSize: 12, color: Colors.black87),
//           ),
//         );
//       }).toList(),
//       onChanged: (value) {
//         setState(() {
//           selectedStandard = value;
//         });
//       },
//     );
//   }

//   Widget _buildDateField({
//     required String title,
//     required DateTime? date,
//     required VoidCallback onTap,
//     required VoidCallback onClear,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(11),
//       child: Container(
//         height: 42,
//         padding: const EdgeInsets.symmetric(horizontal: 9),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(11),
//           border: Border.all(color: borderColor),
//         ),
//         child: Row(
//           children: [
//             // _buildPurpleIcon(
//             //   Icons.calendar_month_rounded,
//             //   size: 27,
//             //   iconSize: 14,
//             // ),
//             buildPurpleIcon(
//               'assets/icons/Group (15).svg',
//               iconColor: Color(0xFF8561E1),
//             ),
//             const SizedBox(width: 8),
//             Expanded(
//               child: Text(
//                 date == null ? title : _formatDate(date),
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   fontSize: 11,
//                   color: date == null
//                       ? const Color(0xFF666666)
//                       : Colors.black87,
//                 ),
//               ),
//             ),
//             if (date != null)
//               GestureDetector(
//                 onTap: onClear,
//                 child: const Icon(Icons.close, size: 15, color: Colors.grey),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildPurpleIcon(
//     String assetPath, {
//     double size = 28,
//     double iconSize = 15,
//     Color iconColor = primaryColor,
//     Color backgroundColor = lightPurple,
//   }) {
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(7),
//       ),
//       alignment: Alignment.center,
//       child: SvgPicture.asset(
//         assetPath,
//         width: iconSize,
//         height: iconSize,
//         colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
//       ),
//     );
//   }

//   Widget _buildAttendanceCard(AttendanceReportItem report) {
//     return InkWell(
//       onTap: () => _openAttendance(report),
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.fromLTRB(11, 11, 11, 9),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: const Color(0xFFDDDDDD)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.05),
//               blurRadius: 7,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF2EEFF),
//                 borderRadius: BorderRadius.circular(3),
//               ),
//               child: Text(
//                 '#${report.id}',
//                 style: const TextStyle(
//                   color: primaryColor,
//                   fontSize: 13,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               _formatDate(report.date),
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Attendance',
//               style: TextStyle(
//                 color: Color(0xFF555555),
//                 fontSize: 10,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             const SizedBox(height: 11),
//             Container(
//               height: 64,
//               decoration: BoxDecoration(
//                 color: lightPurple,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: _buildAttendanceInfo(
//                       assetPath: 'assets/icons/Group 951.svg',

//                       title: 'Standard',
//                       value: report.standard,
//                     ),
//                   ),
//                   _buildDivider(),
//                   Expanded(
//                     child: _buildAttendanceInfo(
//                       assetPath: 'assets/icons/Group (17).svg',
//                       title: 'Division',
//                       value: report.division,
//                     ),
//                   ),
//                   _buildDivider(),
//                   Expanded(
//                     child: _buildAttendanceInfo(
//                       assetPath: 'assets/icons/Group (18).svg',
//                       title: 'Section',
//                       value: report.section,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAttendanceInfo({
//     required String assetPath,
//     required String title,
//     required String value,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 25,
//                 height: 25,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.circle,
//                 ),
//                 alignment: Alignment.center,
//                 child: SvgPicture.asset(
//                   assetPath,
//                   width: 13,
//                   height: 13,
//                   // Uncomment if you want to apply a color
//                   // colorFilter: const ColorFilter.mode(
//                   //   primaryColor,
//                   //   BlendMode.srcIn,
//                   // ),
//                 ),
//               ),
//               const SizedBox(width: 5),
//               Flexible(
//                 child: Text(
//                   title,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(color: Color(0xFF666666), fontSize: 9),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 5),
//           Text(
//             value,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(
//               color: primaryColor,
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDivider() {
//     return Container(width: 1, height: 39, color: const Color(0xFFE9E1FA));
//   }
// }

// class AttendanceReportItem {
//   final int id;
//   final DateTime date;
//   final String standard;
//   final String division;
//   final String section;

//   const AttendanceReportItem({
//     required this.id,
//     required this.date,
//     required this.standard,
//     required this.division,
//     required this.section,
//   });
// }
// import 'package:cristalteacher/core/appdata/appdata.dart';
// import 'package:cristalteacher/features/attendance/presentation/cubit/attendance_cubit.dart';
// import 'package:cristalteacher/features/attendance/presentation/screens/attendance_screen.dart';
// import 'package:cristalteacher/features/authentication/domain/entities/class_details_entity.dart';
// import 'package:cristalteacher/features/authentication/domain/parameters/fetch_tutorshipclass_parameter.dart';
// import 'package:cristalteacher/features/authentication/presentation/cubit/authentication_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';

// class AttendanceReportScreen extends StatefulWidget {
//   const AttendanceReportScreen({super.key});

//   @override
//   State<AttendanceReportScreen> createState() => _AttendanceReportScreenState();
// }

// class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
//   static const Color primaryColor = Color(0xFF5D24F4);
//   static const Color blueColor = Color(0xFF0758C9);
//   static const Color lightPurple = Color(0xFFF7F3FF);
//   static const Color borderColor = Color(0xFFE1E1E1);

//   String? selectedStandardId;

//   DateTime? fromDate;
//   DateTime? toDate;

//   List<TutorshipClass> tutorshipClasses = [];

//   @override
//   void initState() {
//     super.initState();

//     _fetchInitialData();
//   }

//   void _fetchInitialData() {
//     // Fetch standards
//     _fetchTutorshipClasses();

//     // Fetch attendance reports
//     _fetchAttendanceReport();
//   }

//   // ----------------------------------------------------------
//   // FETCH TUTORSHIP CLASS
//   // ----------------------------------------------------------

//   void _fetchTutorshipClasses() {
//     debugPrint('📘 Fetching Tutorship Classes');

//     context.read<AuthenticationCubit>().fetchTutorshipClass(
//       FetchTutorshipClassRequest(
//         accyear: AppData.accYear,
//         employeeId: AppData.employeeId,
//         userId: AppData.userId,
//       ),
//     );
//   }

//   // ----------------------------------------------------------
//   // FETCH ATTENDANCE REPORT
//   // ----------------------------------------------------------

//   void _fetchAttendanceReport() {
//     debugPrint('📘 Fetching Attendance Report');

//     context.read<AttendanceCubit>().fetchAttendanceReport();
//   }

//   // ----------------------------------------------------------
//   // BUILD
//   // ----------------------------------------------------------

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocListener(
//       listeners: [
//         // ======================================================
//         // TUTORSHIP API LISTENER
//         // ======================================================
//         BlocListener<AuthenticationCubit, AuthenticationState>(
//           listener: (context, state) {
//             if (state is FetchTutorshipClassSuccess) {
//               debugPrint('✅ Tutorship Class Loaded');

//               setState(() {
//                 tutorshipClasses = state.response.data?.tutorshipClass ?? [];
//               });
//             }

//             if (state is FetchTutorshipClassFailure) {
//               debugPrint('❌ Tutorship Class Failed: ${state.message}');

//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text(state.message)));
//             }
//           },
//         ),

//         // ======================================================
//         // ATTENDANCE REPORT API LISTENER
//         // ======================================================
//         BlocListener<AttendanceCubit, AttendanceState>(
//           listener: (context, state) {
//             if (state is AttendanceReportSuccess) {
//               debugPrint('✅ Attendance Report Loaded');
//             }

//             if (state is AttendanceReportFailure) {
//               debugPrint('❌ Attendance Report Failed: ${state.message}');

//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text(state.message)));
//             }
//           },
//         ),
//       ],

//       child: BlocBuilder<AttendanceCubit, AttendanceState>(
//         builder: (context, attendanceState) {
//           return Scaffold(
//             backgroundColor: const Color(0xFFFAFAFA),

//             appBar: AppBar(
//               backgroundColor: Colors.white,
//               surfaceTintColor: Colors.white,
//               elevation: 0,
//               centerTitle: true,
//               toolbarHeight: 58,
//               leading: IconButton(
//                 onPressed: () => Navigator.pop(context),
//                 icon: const Icon(
//                   Icons.arrow_back,
//                   color: Colors.black,
//                   size: 23,
//                 ),
//               ),
//               title: const Text(
//                 'Attendance',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),

//             body: SafeArea(
//               top: false,
//               child: Column(
//                 children: [
//                   // ==================================================
//                   // FILTER SECTION
//                   // ==================================================
//                   Container(
//                     width: double.infinity,
//                     color: Colors.white,
//                     padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
//                     child: Column(
//                       children: [
//                         _buildStandardDropdown(),

//                         const SizedBox(height: 12),

//                         Row(
//                           children: [
//                             Expanded(
//                               child: _buildDateField(
//                                 title: 'From date',
//                                 date: fromDate,
//                                 onTap: () {
//                                   _selectDate(isFromDate: true);
//                                 },
//                                 onClear: () {
//                                   setState(() {
//                                     fromDate = null;
//                                   });
//                                 },
//                               ),
//                             ),

//                             const SizedBox(width: 10),

//                             Expanded(
//                               child: _buildDateField(
//                                 title: 'To date',
//                                 date: toDate,
//                                 onTap: () {
//                                   _selectDate(isFromDate: false);
//                                 },
//                                 onClear: () {
//                                   setState(() {
//                                     toDate = null;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),

//                   // ==================================================
//                   // ATTENDANCE REPORT LIST
//                   // ==================================================
//                   Expanded(child: _buildAttendanceReports(attendanceState)),
//                 ],
//               ),
//             ),

//             // ======================================================
//             // ADD ATTENDANCE
//             // ======================================================
//             floatingActionButton: SizedBox(
//               width: 56,
//               height: 56,
//               child: FloatingActionButton(
//                 onPressed: _addAttendance,
//                 backgroundColor: blueColor,
//                 elevation: 4,
//                 shape: const CircleBorder(),
//                 child: const Icon(Icons.add, color: Colors.white, size: 34),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // ============================================================
//   // STANDARD DROPDOWN
//   // ============================================================

//   Widget _buildStandardDropdown() {
//     final authenticationState = context.watch<AuthenticationCubit>().state;

//     final isLoading = authenticationState is FetchTutorshipClassLoading;

//     return DropdownButtonFormField<String>(
//       value: selectedStandardId,
//       isExpanded: true,

//       icon: const Icon(Icons.keyboard_arrow_down, color: primaryColor),

//       hint: const Text(
//         'Standard',
//         style: TextStyle(fontSize: 12, color: Color(0xFF4B4B4B)),
//       ),

//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Colors.white,

//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 12,
//           vertical: 10,
//         ),

//         prefixIcon: Padding(
//           padding: const EdgeInsets.only(left: 12, right: 6),
//           child: SvgPicture.asset(
//             'assets/icons/Group (14).svg',
//             width: 14,
//             height: 14,
//             fit: BoxFit.contain,
//           ),
//         ),

//         prefixIconConstraints: const BoxConstraints(
//           minWidth: 30,
//           minHeight: 30,
//         ),

//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(11),
//           borderSide: const BorderSide(color: borderColor),
//         ),

//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(11),
//           borderSide: const BorderSide(color: primaryColor),
//         ),
//       ),

//       // ========================================================
//       // TUTORSHIP DATA
//       // ========================================================
//       items: tutorshipClasses.map((item) {
//         return DropdownMenuItem<String>(
//           value: item.standardId?.toString(),

//           child: Text(
//             item.standard ?? '',
//             style: const TextStyle(fontSize: 12, color: Colors.black87),
//           ),
//         );
//       }).toList(),

//       onChanged: isLoading
//           ? null
//           : (value) {
//               setState(() {
//                 selectedStandardId = value;
//               });
//             },
//     );
//   }

//   // ============================================================
//   // ATTENDANCE REPORT LIST
//   // ============================================================

//   Widget _buildAttendanceReports(AttendanceState state) {
//     if (state is AttendanceReportLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (state is AttendanceReportFailure) {
//       return Center(
//         child: Text(
//           state.message,
//           style: const TextStyle(color: Colors.grey, fontSize: 14),
//         ),
//       );
//     }

//     if (state is! AttendanceReportSuccess) {
//       return const Center(
//         child: Text(
//           'No attendance reports found',
//           style: TextStyle(color: Colors.grey, fontSize: 14),
//         ),
//       );
//     }

//     final attendanceData = state.response.data ?? [];

//     // ==========================================================
//     // FILTER REPORTS
//     // ==========================================================

//     final filteredReports = attendanceData.where((report) {
//       // Standard filter
//       final matchesStandard =
//           selectedStandardId == null ||
//           report.standardId?.toString() == selectedStandardId;

//       // Date
//       final reportDate = _parseDate(report.date);

//       final matchesFromDate =
//           fromDate == null || !reportDate.isBefore(_dateOnly(fromDate!));

//       final matchesToDate =
//           toDate == null || !reportDate.isAfter(_dateOnly(toDate!));

//       return matchesStandard && matchesFromDate && matchesToDate;
//     }).toList();

//     if (filteredReports.isEmpty) {
//       return const Center(
//         child: Text(
//           'No attendance reports found',
//           style: TextStyle(color: Colors.grey, fontSize: 14),
//         ),
//       );
//     }

//     return ListView.separated(
//       padding: const EdgeInsets.fromLTRB(20, 14, 20, 95),

//       itemCount: filteredReports.length,

//       separatorBuilder: (_, __) {
//         return const SizedBox(height: 12);
//       },

//       itemBuilder: (context, index) {
//         final report = filteredReports[index];

//         return _buildAttendanceCard(report);
//       },
//     );
//   }

//   // ============================================================
//   // ATTENDANCE CARD
//   // ============================================================

//   Widget _buildAttendanceCard(dynamic report) {
//     final reportDate = _parseDate(report.date);

//     return InkWell(
//       onTap: () {
//         debugPrint('Attendance ID: ${report.studentattendanceMasterId}');
//       },

//       borderRadius: BorderRadius.circular(12),

//       child: Container(
//         width: double.infinity,

//         padding: const EdgeInsets.fromLTRB(11, 11, 11, 9),

//         decoration: BoxDecoration(
//           color: Colors.white,

//           borderRadius: BorderRadius.circular(12),

//           border: Border.all(color: const Color(0xFFDDDDDD)),

//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.05),
//               blurRadius: 7,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),

//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,

//           children: [
//             // ==================================================
//             // ID
//             // ==================================================
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),

//               decoration: BoxDecoration(
//                 color: const Color(0xFFF2EEFF),
//                 borderRadius: BorderRadius.circular(3),
//               ),

//               child: Text(
//                 '#${report.studentattendanceMasterId ?? ''}',

//                 style: const TextStyle(
//                   color: primaryColor,
//                   fontSize: 13,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 5),

//             // ==================================================
//             // DATE
//             // ==================================================
//             Text(
//               _formatDate(reportDate),

//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),

//             const SizedBox(height: 8),

//             const Text(
//               'Attendance',

//               style: TextStyle(
//                 color: Color(0xFF555555),
//                 fontSize: 10,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),

//             const SizedBox(height: 11),

//             // ==================================================
//             // STANDARD / DIVISION / SECTION
//             // ==================================================
//             Container(
//               height: 64,

//               decoration: BoxDecoration(
//                 color: lightPurple,
//                 borderRadius: BorderRadius.circular(10),
//               ),

//               child: Row(
//                 children: [
//                   Expanded(
//                     child: _buildAttendanceInfo(
//                       assetPath: 'assets/icons/Group 951.svg',
//                       title: 'Standard',
//                       value: report.standard ?? '',
//                     ),
//                   ),

//                   _buildDivider(),

//                   Expanded(
//                     child: _buildAttendanceInfo(
//                       assetPath: 'assets/icons/Group (17).svg',
//                       title: 'Division',
//                       value: report.division ?? '',
//                     ),
//                   ),

//                   _buildDivider(),

//                   Expanded(
//                     child: _buildAttendanceInfo(
//                       assetPath: 'assets/icons/Group (18).svg',
//                       title: 'Section',
//                       value: '-',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ============================================================
//   // ATTENDANCE INFO
//   // ============================================================

//   Widget _buildAttendanceInfo({
//     required String assetPath,
//     required String title,
//     required String value,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),

//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,

//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,

//             children: [
//               Container(
//                 width: 25,
//                 height: 25,

//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.circle,
//                 ),

//                 alignment: Alignment.center,

//                 child: SvgPicture.asset(assetPath, width: 13, height: 13),
//               ),

//               const SizedBox(width: 5),

//               Flexible(
//                 child: Text(
//                   title,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,

//                   style: const TextStyle(color: Color(0xFF666666), fontSize: 9),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 5),

//           Text(
//             value,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,

//             style: const TextStyle(
//               color: primaryColor,
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ============================================================
//   // DATE FIELD
//   // ============================================================

//   Widget _buildDateField({
//     required String title,
//     required DateTime? date,
//     required VoidCallback onTap,
//     required VoidCallback onClear,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(11),

//       child: Container(
//         height: 42,

//         padding: const EdgeInsets.symmetric(horizontal: 9),

//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(11),

//           border: Border.all(color: borderColor),
//         ),

//         child: Row(
//           children: [
//             buildPurpleIcon(
//               'assets/icons/Group (15).svg',
//               iconColor: const Color(0xFF8561E1),
//             ),

//             const SizedBox(width: 8),

//             Expanded(
//               child: Text(
//                 date == null ? title : _formatDate(date),

//                 overflow: TextOverflow.ellipsis,

//                 style: TextStyle(
//                   fontSize: 11,

//                   color: date == null
//                       ? const Color(0xFF666666)
//                       : Colors.black87,
//                 ),
//               ),
//             ),

//             if (date != null)
//               GestureDetector(
//                 onTap: onClear,

//                 child: const Icon(Icons.close, size: 15, color: Colors.grey),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ============================================================
//   // DATE PICKER
//   // ============================================================

//   Future<void> _selectDate({required bool isFromDate}) async {
//     final initialDate = isFromDate
//         ? fromDate ?? DateTime.now()
//         : toDate ?? fromDate ?? DateTime.now();

//     final selectedDate = await showDatePicker(
//       context: context,

//       initialDate: initialDate,

//       firstDate: DateTime(2020),

//       lastDate: DateTime(2040),

//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: primaryColor,
//               onPrimary: Colors.white,
//               surface: Colors.white,
//               onSurface: Colors.black,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (selectedDate == null) return;

//     setState(() {
//       if (isFromDate) {
//         fromDate = selectedDate;
//       } else {
//         toDate = selectedDate;
//       }
//     });
//   }

//   // ============================================================
//   // HELPERS
//   // ============================================================

//   DateTime _parseDate(String? date) {
//     if (date == null || date.isEmpty) {
//       return DateTime.now();
//     }

//     return DateTime.tryParse(date) ?? DateTime.now();
//   }

//   DateTime _dateOnly(DateTime date) {
//     return DateTime(date.year, date.month, date.day);
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day.toString().padLeft(2, '0')}-'
//         '${date.month.toString().padLeft(2, '0')}-'
//         '${date.year}';
//   }

//   Widget buildPurpleIcon(
//     String assetPath, {
//     double size = 28,
//     double iconSize = 15,
//     Color iconColor = primaryColor,
//     Color backgroundColor = lightPurple,
//   }) {
//     return Container(
//       width: size,
//       height: size,

//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(7),
//       ),

//       alignment: Alignment.center,

//       child: SvgPicture.asset(
//         assetPath,
//         width: iconSize,
//         height: iconSize,

//         colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
//       ),
//     );
//   }

//   // ============================================================
//   // ADD ATTENDANCE
//   // ============================================================

//   void _addAttendance() {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) {
//           return AttendanceScreen();
//         },
//       ),
//     );
//   }

//   // ============================================================
//   // DIVIDER
//   // ============================================================

//   Widget _buildDivider() {
//     return Container(width: 1, height: 39, color: const Color(0xFFE9E1FA));
//   }
// }
import 'package:cristalteacher/core/appdata/appdata.dart';
import 'package:cristalteacher/features/attendance/presentation/cubit/attendance_cubit.dart';
import 'package:cristalteacher/features/attendance/presentation/screens/attendance_screen.dart';
import 'package:cristalteacher/features/authentication/domain/entities/class_details_entity.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/fetch_tutorshipclass_parameter.dart';
import 'package:cristalteacher/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AttendanceReportScreen extends StatefulWidget {
  const AttendanceReportScreen({super.key});

  @override
  State<AttendanceReportScreen> createState() => _AttendanceReportScreenState();
}

class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
  static const Color primaryColor = Color(0xFF5D24F4);
  static const Color blueColor = Color(0xFF0758C9);
  static const Color lightPurple = Color(0xFFF7F3FF);
  static const Color borderColor = Color(0xFFE1E1E1);

  String? selectedStandardId;

  DateTime? fromDate;
  DateTime? toDate;

  List<TutorshipClass> tutorshipClasses = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialData();
    });
  }

  // ============================================================
  // INITIAL API CALLS
  // ============================================================

  void _fetchInitialData() {
    _fetchTutorshipClasses();
    _fetchAttendanceReport();
  }

  // ============================================================
  // FETCH TUTORSHIP CLASSES
  // ============================================================

  void _fetchTutorshipClasses() {
    debugPrint('📘 Fetching Tutorship Classes');

    context.read<AuthenticationCubit>().fetchTutorshipClass(
      FetchTutorshipClassRequest(
        accyear: AppData.accYear,
        employeeId: AppData.employeeId,
        userId: AppData.userId,
      ),
    );
  }

  // ============================================================
  // FETCH ATTENDANCE REPORT
  // ============================================================

  void _fetchAttendanceReport() {
    debugPrint('📘 Fetching Attendance Report');

    context.read<AttendanceCubit>().fetchAttendanceReport();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // ========================================================
        // TUTORSHIP LISTENER
        // ========================================================
        BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            if (state is FetchTutorshipClassSuccess) {
              debugPrint('✅ Tutorship Class Loaded');

              setState(() {
                tutorshipClasses = state.response.data?.tutorshipClass ?? [];
              });
            }

            if (state is FetchTutorshipClassFailure) {
              debugPrint('❌ Tutorship Class Failed: ${state.message}');

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),

        // ========================================================
        // ATTENDANCE REPORT LISTENER
        // ========================================================
        BlocListener<AttendanceCubit, AttendanceState>(
          listener: (context, state) {
            if (state is AttendanceReportSuccess) {
              debugPrint('✅ Attendance Report Loaded');

              debugPrint('Total reports: ${state.response.data?.length ?? 0}');
            }

            if (state is AttendanceReportFailure) {
              debugPrint('❌ Attendance Report Failed: ${state.message}');

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ],
      child: BlocBuilder<AttendanceCubit, AttendanceState>(
        builder: (context, attendanceState) {
          return Scaffold(
            backgroundColor: const Color(0xFFFAFAFA),

            // ======================================================
            // APP BAR
            // ======================================================
            appBar: AppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              toolbarHeight: 58,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 23,
                ),
              ),
              title: const Text(
                'Attendance',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            // ======================================================
            // BODY
            // ======================================================
            body: SafeArea(
              top: false,
              child: Column(
                children: [
                  // ==================================================
                  // FILTER SECTION
                  // ==================================================
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                    child: Column(
                      children: [
                        _buildStandardDropdown(),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(
                              child: _buildDateField(
                                title: 'From date',
                                date: fromDate,
                                onTap: () {
                                  _selectDate(isFromDate: true);
                                },
                                onClear: () {
                                  setState(() {
                                    fromDate = null;
                                  });
                                },
                              ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: _buildDateField(
                                title: 'To date',
                                date: toDate,
                                onTap: () {
                                  _selectDate(isFromDate: false);
                                },
                                onClear: () {
                                  setState(() {
                                    toDate = null;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // ==================================================
                  // REPORT LIST
                  // ==================================================
                  Expanded(child: _buildAttendanceReports(attendanceState)),
                ],
              ),
            ),

            // ======================================================
            // ADD ATTENDANCE
            // ======================================================
            floatingActionButton: SizedBox(
              width: 56,
              height: 56,
              child: FloatingActionButton(
                onPressed: _addAttendance,
                backgroundColor: blueColor,
                elevation: 4,
                shape: const CircleBorder(),
                child: const Icon(Icons.add, color: Colors.white, size: 34),
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // STANDARD DROPDOWN
  // ============================================================

  Widget _buildStandardDropdown() {
    final authenticationState = context.watch<AuthenticationCubit>().state;

    final isLoading = authenticationState is FetchTutorshipClassLoading;

    return DropdownButtonFormField<String>(
      value: selectedStandardId,
      isExpanded: true,

      icon: const Icon(Icons.keyboard_arrow_down, color: primaryColor),

      hint: const Text(
        'Standard',
        style: TextStyle(fontSize: 12, color: Color(0xFF4B4B4B)),
      ),

      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),

        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12, right: 6),
          child: SvgPicture.asset(
            'assets/icons/Group (14).svg',
            width: 14,
            height: 14,
            fit: BoxFit.contain,
          ),
        ),

        prefixIconConstraints: const BoxConstraints(
          minWidth: 30,
          minHeight: 30,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: borderColor),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: primaryColor),
        ),
      ),

      // ========================================================
      // TUTORSHIP STANDARD DATA
      // ========================================================
      items: tutorshipClasses.map((item) {
        return DropdownMenuItem<String>(
          value: item.standardId?.toString(),

          child: Text(
            item.standard ?? '',
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        );
      }).toList(),

      onChanged: isLoading
          ? null
          : (value) {
              setState(() {
                selectedStandardId = value;
              });

              debugPrint('Selected Standard ID: $value');
            },
    );
  }

  // ============================================================
  // ATTENDANCE REPORT LIST
  // ============================================================

  Widget _buildAttendanceReports(AttendanceState state) {
    // ----------------------------------------------------------
    // LOADING
    // ----------------------------------------------------------

    if (state is AttendanceReportLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // ----------------------------------------------------------
    // ERROR
    // ----------------------------------------------------------

    if (state is AttendanceReportFailure) {
      return Center(
        child: Text(
          state.message,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      );
    }

    // ----------------------------------------------------------
    // WAITING FOR DATA
    // ----------------------------------------------------------

    if (state is! AttendanceReportSuccess) {
      return const Center(
        child: Text(
          'No attendance reports found',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      );
    }

    // ==========================================================
    // GET COMPLETE API LIST
    // ==========================================================

    final attendanceData = state.response.data ?? [];

    // ==========================================================
    // FILTER LOCALLY
    // ==========================================================

    final filteredReports = attendanceData.where((report) {
      // --------------------------------------------------------
      // STANDARD FILTER
      // --------------------------------------------------------

      final matchesStandard =
          selectedStandardId == null ||
          report.standardId?.toString() == selectedStandardId;

      // --------------------------------------------------------
      // DATE FILTER
      // --------------------------------------------------------

      final reportDate = _parseDate(report.date);

      final reportDateOnly = _dateOnly(reportDate);

      bool matchesFromDate = true;
      bool matchesToDate = true;

      if (fromDate != null) {
        matchesFromDate = !reportDateOnly.isBefore(_dateOnly(fromDate!));
      }

      if (toDate != null) {
        matchesToDate = !reportDateOnly.isAfter(_dateOnly(toDate!));
      }

      return matchesStandard && matchesFromDate && matchesToDate;
    }).toList();

    // ==========================================================
    // NO RESULT
    // ==========================================================

    if (filteredReports.isEmpty) {
      return const Center(
        child: Text(
          'No attendance reports found',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      );
    }

    // ==========================================================
    // DISPLAY FILTERED LIST
    // ==========================================================

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 95),

      itemCount: filteredReports.length,

      separatorBuilder: (_, __) {
        return const SizedBox(height: 12);
      },

      itemBuilder: (context, index) {
        final report = filteredReports[index];

        return _buildAttendanceCard(report);
      },
    );
  }

  // ============================================================
  // ATTENDANCE CARD
  // ============================================================

  Widget _buildAttendanceCard(dynamic report) {
    final reportDate = _parseDate(report.date);

    return InkWell(
      onTap: () {
        debugPrint(
          'Attendance ID: '
          '${report.studentattendanceMasterId}',
        );
      },

      borderRadius: BorderRadius.circular(12),

      child: Container(
        width: double.infinity,

        padding: const EdgeInsets.fromLTRB(11, 11, 11, 9),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFDDDDDD)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // --------------------------------------------------
            // ID
            // --------------------------------------------------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),

              decoration: BoxDecoration(
                color: const Color(0xFFF2EEFF),
                borderRadius: BorderRadius.circular(3),
              ),

              child: Text(
                '#${report.studentattendanceMasterId ?? ''}',

                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 5),

            // --------------------------------------------------
            // DATE
            // --------------------------------------------------
            Text(
              _formatDate(reportDate),

              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Attendance',

              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 11),

            // --------------------------------------------------
            // STANDARD / DIVISION / SECTION
            // --------------------------------------------------
            Container(
              height: 64,

              decoration: BoxDecoration(
                color: lightPurple,
                borderRadius: BorderRadius.circular(10),
              ),

              child: Row(
                children: [
                  Expanded(
                    child: _buildAttendanceInfo(
                      assetPath: 'assets/icons/Group 951.svg',
                      title: 'Standard',
                      value: report.standard ?? '',
                    ),
                  ),

                  _buildDivider(),

                  Expanded(
                    child: _buildAttendanceInfo(
                      assetPath: 'assets/icons/Group (17).svg',
                      title: 'Division',
                      value: report.division ?? '',
                    ),
                  ),

                  _buildDivider(),

                  Expanded(
                    child: _buildAttendanceInfo(
                      assetPath: 'assets/icons/Group (18).svg',
                      title: 'Section',
                      value: '-',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ATTENDANCE INFO
  // ============================================================

  Widget _buildAttendanceInfo({
    required String assetPath,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                width: 25,
                height: 25,

                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),

                alignment: Alignment.center,

                child: SvgPicture.asset(assetPath, width: 13, height: 13),
              ),

              const SizedBox(width: 5),

              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(color: Color(0xFF666666), fontSize: 9),
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,

            style: const TextStyle(
              color: primaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DATE FIELD
  // ============================================================

  Widget _buildDateField({
    required String title,
    required DateTime? date,
    required VoidCallback onTap,
    required VoidCallback onClear,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(11),

      child: Container(
        height: 42,

        padding: const EdgeInsets.symmetric(horizontal: 9),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: borderColor),
        ),

        child: Row(
          children: [
            buildPurpleIcon(
              'assets/icons/Group (15).svg',
              iconColor: const Color(0xFF8561E1),
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Text(
                date == null ? title : _formatDate(date),

                overflow: TextOverflow.ellipsis,

                style: TextStyle(
                  fontSize: 11,
                  color: date == null
                      ? const Color(0xFF666666)
                      : Colors.black87,
                ),
              ),
            ),

            if (date != null)
              GestureDetector(
                onTap: onClear,

                child: const Icon(Icons.close, size: 15, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DATE PICKER
  // ============================================================

  Future<void> _selectDate({required bool isFromDate}) async {
    final initialDate = isFromDate
        ? fromDate ?? DateTime.now()
        : toDate ?? fromDate ?? DateTime.now();

    final selectedDate = await showDatePicker(
      context: context,

      initialDate: initialDate,

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

    if (selectedDate == null) {
      return;
    }

    setState(() {
      if (isFromDate) {
        fromDate = selectedDate;

        // If selected FROM date is after TO date,
        // clear the TO date.
        if (toDate != null && toDate!.isBefore(selectedDate)) {
          toDate = null;
        }
      } else {
        // Do not allow TO date before FROM date.
        if (fromDate != null && selectedDate.isBefore(fromDate!)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('To date cannot be before from date')),
          );
          return;
        }

        toDate = selectedDate;
      }
    });
  }

  // ============================================================
  // HELPERS
  // ============================================================

  DateTime _parseDate(String? date) {
    if (date == null || date.isEmpty) {
      return DateTime.now();
    }

    return DateTime.tryParse(date) ?? DateTime.now();
  }

  DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.year}';
  }

  // ============================================================
  // PURPLE ICON
  // ============================================================

  Widget buildPurpleIcon(
    String assetPath, {
    double size = 28,
    double iconSize = 15,
    Color iconColor = primaryColor,
    Color backgroundColor = lightPurple,
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

  // ============================================================
  // ADD ATTENDANCE
  // ============================================================

  void _addAttendance() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return AttendanceScreen();
        },
      ),
    );
  }

  // ============================================================
  // DIVIDER
  // ============================================================

  Widget _buildDivider() {
    return Container(width: 1, height: 39, color: const Color(0xFFE9E1FA));
  }
}
