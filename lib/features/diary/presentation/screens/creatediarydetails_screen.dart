// // import 'dart:math';

// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/svg.dart';

// // enum VoiceState { idle, recording, recorded }

// // class SelectYourClassScreen extends StatefulWidget {
// //   final int standardId;
// //   final String standardName;

// //   final int divisionId;
// //   final String divisionName;

// //   final int subjectId;
// //   final String subjectName;

// //   final DateTime diaryDate;
// //   final DateTime dueDate;

// //   final bool isFavourite;

// //   const SelectYourClassScreen({
// //     super.key,
// //     required this.standardId,
// //     required this.standardName,
// //     required this.divisionId,
// //     required this.divisionName,
// //     required this.subjectId,
// //     required this.subjectName,
// //     required this.diaryDate,
// //     required this.dueDate,
// //     required this.isFavourite,
// //   });

// //   @override
// //   State<SelectYourClassScreen> createState() => _SelectYourClassScreenState();
// // }

// // class _SelectYourClassScreenState extends State<SelectYourClassScreen> {
// //   @override
// //   void initState() {
// //     super.initState();

// //     debugPrint('Standard: ${widget.standardName} (${widget.standardId})');
// //     debugPrint('Division: ${widget.divisionName} (${widget.divisionId})');
// //     debugPrint('Subject: ${widget.subjectName} (${widget.subjectId})');
// //     debugPrint('Diary Date: ${formatApiDate(widget.diaryDate)}');
// //     debugPrint('Due Date: ${formatApiDate(widget.dueDate)}');
// //     debugPrint('Is Favourite: ${widget.isFavourite}');
// //   }

// //   String formatApiDate(DateTime date) {
// //     final String year = date.year.toString();
// //     final String month = date.month.toString().padLeft(2, '0');
// //     final String day = date.day.toString().padLeft(2, '0');

// //     return '$year-$month-$day';
// //   }

// //   VoiceState voiceState = VoiceState.idle;

// //   final Color bgColor = const Color(0xfffbf7ff);
// //   final Color fieldColor = const Color(0xffeef4ff);
// //   final Color primaryColor = const Color(0xff9B73E6);
// //   final Color borderColor = const Color(0xffb7c4d6);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: bgColor,
// //       body: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 18),
// //           child: Column(
// //             children: [
// //               const SizedBox(height: 12),

// //               // Header
// //               Row(
// //                 children: [
// //                   const Icon(Icons.arrow_back, size: 22),
// //                   const Expanded(
// //                     child: Center(
// //                       child: Text(
// //                         "Select Your Class",
// //                         style: TextStyle(
// //                           fontSize: 14,
// //                           fontWeight: FontWeight.w600,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(width: 22),
// //                 ],
// //               ),

// //               const SizedBox(height: 28),

// //               _inputBox(hint: "Heading Or Title", height: 44),

// //               const SizedBox(height: 14),

// //               _inputBox(hint: "Description", height: 118, maxLines: 5),

// //               const SizedBox(height: 14),

// //               _attachmentBox(),

// //               const SizedBox(height: 10),

// //               Row(
// //                 children: const [
// //                   Icon(Icons.info, size: 15, color: Colors.grey),
// //                   SizedBox(width: 5),
// //                   Text(
// //                     "Allow Pdf , Doc, Docx, Jpg ,Png, Mp3",
// //                     style: TextStyle(fontSize: 11, color: Color(0xff5c5c5c)),
// //                   ),
// //                 ],
// //               ),

// //               const SizedBox(height: 12),

// //               _voiceWidget(),

// //               const Spacer(),

// //               SizedBox(
// //                 width: double.infinity,
// //                 height: 48,
// //                 child: ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: primaryColor,
// //                     elevation: 0,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(6),
// //                     ),
// //                   ),
// //                   onPressed: () {},
// //                   child: const Text(
// //                     "Save",
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontSize: 13,
// //                       fontWeight: FontWeight.w500,
// //                     ),
// //                   ),
// //                 ),
// //               ),

// //               const SizedBox(height: 65),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _inputBox({
// //     required String hint,
// //     required double height,
// //     int maxLines = 1,
// //   }) {
// //     return Container(
// //       height: height,
// //       decoration: BoxDecoration(
// //         color: fieldColor,
// //         borderRadius: BorderRadius.circular(7),
// //         border: Border.all(color: borderColor),
// //       ),
// //       child: TextField(
// //         maxLines: maxLines,
// //         decoration: InputDecoration(
// //           hintText: hint,
// //           hintStyle: const TextStyle(fontSize: 12, color: Colors.black),
// //           suffixIcon: Padding(
// //             padding: const EdgeInsets.all(10),

// //             child: SvgPicture.asset(
// //               "assets/icons/Group (8).svg", // Replace with your SVG path
// //               width: 25,
// //               height: 25,
// //             ),
// //           ),
// //           border: InputBorder.none,
// //           contentPadding: const EdgeInsets.symmetric(
// //             horizontal: 12,
// //             vertical: 12,
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _attachmentBox() {
// //     return CustomPaint(
// //       painter: DashedBorderPainter(),
// //       child: Container(
// //         width: double.infinity,
// //         height: 105,
// //         decoration: BoxDecoration(
// //           color: Colors.transparent,
// //           borderRadius: BorderRadius.circular(8),
// //         ),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             SvgPicture.asset(
// //               "assets/icons/Group (9).svg", // Replace with your SVG path
// //               width: 24,
// //               height: 24,
// //               fit: BoxFit.contain,
// //             ),
// //             SizedBox(height: 6),
// //             Text(
// //               "Attachment",
// //               style: TextStyle(fontSize: 12, color: Colors.black),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _voiceWidget() {
// //     switch (voiceState) {
// //       case VoiceState.idle:
// //         return GestureDetector(
// //           onTap: () {
// //             setState(() {
// //               voiceState = VoiceState.recording;
// //             });
// //           },
// //           child: Container(
// //             height: 46,
// //             decoration: BoxDecoration(
// //               color: fieldColor,
// //               borderRadius: BorderRadius.circular(7),
// //             ),
// //             child: Row(
// //               children: [
// //                 const SizedBox(width: 12),
// //                 const Text(
// //                   "Record Your Voice",
// //                   style: TextStyle(fontSize: 12, color: Colors.black),
// //                 ),
// //                 const Spacer(),
// //                 Container(
// //                   width: 38,
// //                   height: 38,
// //                   decoration: const BoxDecoration(
// //                     color: Colors.black,
// //                     shape: BoxShape.circle,
// //                   ),
// //                   child: const Icon(Icons.mic, color: Colors.white, size: 18),
// //                 ),
// //                 const SizedBox(width: 6),
// //               ],
// //             ),
// //           ),
// //         );

// //       case VoiceState.recording:
// //         return GestureDetector(
// //           onTap: () {
// //             setState(() {
// //               voiceState = VoiceState.recorded;
// //             });
// //           },
// //           child: Container(
// //             height: 50,
// //             decoration: BoxDecoration(
// //               color: fieldColor,
// //               borderRadius: BorderRadius.circular(8),
// //               border: Border.all(color: const Color(0xffb9b7ff), width: 1.3),
// //             ),
// //             child: Row(
// //               children: [
// //                 const SizedBox(width: 10),
// //                 const Icon(Icons.mic, size: 18, color: Colors.red),
// //                 const SizedBox(width: 10),
// //                 Expanded(
// //                   child: CustomPaint(
// //                     painter: WaveformPainter(color: primaryColor),
// //                     child: const SizedBox(height: 34),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 8),
// //                 const Text("0:12", style: TextStyle(fontSize: 10)),
// //                 const SizedBox(width: 10),
// //                 Container(
// //                   width: 32,
// //                   height: 32,
// //                   decoration: BoxDecoration(
// //                     color: primaryColor,
// //                     shape: BoxShape.circle,
// //                   ),
// //                   child: const Icon(Icons.mic, color: Colors.white, size: 16),
// //                 ),
// //                 const SizedBox(width: 8),
// //               ],
// //             ),
// //           ),
// //         );

// //       case VoiceState.recorded:
// //         return Container(
// //           height: 50,
// //           decoration: BoxDecoration(
// //             color: fieldColor,
// //             borderRadius: BorderRadius.circular(8),
// //             border: Border.all(color: borderColor),
// //           ),
// //           child: Row(
// //             children: [
// //               const SizedBox(width: 10),
// //               const Icon(Icons.play_arrow, size: 24, color: Color(0xff20345c)),
// //               const SizedBox(width: 8),
// //               Expanded(
// //                 child: CustomPaint(
// //                   painter: WaveformPainter(color: primaryColor),
// //                   child: const SizedBox(height: 34),
// //                 ),
// //               ),
// //               const SizedBox(width: 8),
// //               const Text("0:12", style: TextStyle(fontSize: 10)),
// //               const SizedBox(width: 14),
// //               GestureDetector(
// //                 onTap: () {
// //                   setState(() {
// //                     voiceState = VoiceState.idle;
// //                   });
// //                 },
// //                 child: const Icon(
// //                   Icons.delete_outline,
// //                   color: Colors.red,
// //                   size: 19,
// //                 ),
// //               ),
// //               const SizedBox(width: 12),
// //             ],
// //           ),
// //         );
// //     }
// //   }
// // }

// // class DashedBorderPainter extends CustomPainter {
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     const double dashWidth = 8;
// //     const double dashSpace = 6;

// //     final paint = Paint()
// //       ..color = Colors.black54
// //       ..strokeWidth = 1
// //       ..style = PaintingStyle.stroke;

// //     final path = Path()
// //       ..addRRect(
// //         RRect.fromRectAndRadius(
// //           Rect.fromLTWH(0, 0, size.width, size.height),
// //           const Radius.circular(8),
// //         ),
// //       );

// //     for (final metric in path.computeMetrics()) {
// //       double distance = 0;
// //       while (distance < metric.length) {
// //         final extractPath = metric.extractPath(distance, distance + dashWidth);
// //         canvas.drawPath(extractPath, paint);
// //         distance += dashWidth + dashSpace;
// //       }
// //     }
// //   }

// //   @override
// //   bool shouldRepaint(CustomPainter oldDelegate) => false;
// // }

// // class WaveformPainter extends CustomPainter {
// //   final Color color;

// //   WaveformPainter({required this.color});

// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final paint = Paint()
// //       ..color = color.withOpacity(0.8)
// //       ..strokeWidth = 2
// //       ..strokeCap = StrokeCap.round;

// //     final Random random = Random(4);
// //     double x = 0;

// //     while (x < size.width) {
// //       final barHeight = 8 + random.nextDouble() * 24;
// //       final y1 = size.height / 2 - barHeight / 2;
// //       final y2 = size.height / 2 + barHeight / 2;

// //       canvas.drawLine(Offset(x, y1), Offset(x, y2), paint);
// //       x += 5;
// //     }
// //   }

// //   @override
// //   bool shouldRepaint(CustomPainter oldDelegate) => false;
// // }
// import 'dart:math';
// import 'dart:ui';

// import 'package:cristalteacher/core/appdata/appdata.dart';
// import 'package:cristalteacher/features/diary/domain/parameters/save_diary_parameter.dart';
// import 'package:cristalteacher/features/diary/presentation/cubit/diary_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// enum VoiceState { idle, recording, recorded }

// class SelectYourClassScreen extends StatefulWidget {
//   final int standardId;
//   final String standardName;

//   final int divisionId;
//   final String divisionName;

//   final int subjectId;
//   final String subjectName;

//   final DateTime diaryDate;
//   final DateTime dueDate;

//   final bool isFavourite;

//   const SelectYourClassScreen({
//     super.key,
//     required this.standardId,
//     required this.standardName,
//     required this.divisionId,
//     required this.divisionName,
//     required this.subjectId,
//     required this.subjectName,
//     required this.diaryDate,
//     required this.dueDate,
//     required this.isFavourite,
//   });

//   @override
//   State<SelectYourClassScreen> createState() => _SelectYourClassScreenState();
// }

// class _SelectYourClassScreenState extends State<SelectYourClassScreen> {
//   final TextEditingController _titleController = TextEditingController();

//   final TextEditingController _descriptionController = TextEditingController();

//   VoiceState voiceState = VoiceState.idle;

//   final Color bgColor = const Color(0xffFBF7FF);
//   final Color fieldColor = const Color(0xffEEF4FF);
//   final Color primaryColor = const Color(0xff9B73E6);
//   final Color borderColor = const Color(0xffB7C4D6);

//   @override
//   void initState() {
//     super.initState();

//     debugPrint('==========================================');
//     debugPrint('📘 SELECTED DIARY DETAILS');
//     debugPrint('Standard: ${widget.standardName} (${widget.standardId})');
//     debugPrint('Division: ${widget.divisionName} (${widget.divisionId})');
//     debugPrint('Subject: ${widget.subjectName} (${widget.subjectId})');
//     debugPrint('Diary Date: ${formatApiDate(widget.diaryDate)}');
//     debugPrint('Due Date: ${formatApiDate(widget.dueDate)}');
//     debugPrint('Is Favourite: ${widget.isFavourite}');
//     debugPrint('==========================================');
//     print(AppData.employeeId);
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }

//   String formatApiDate(DateTime date) {
//     final String year = date.year.toString();

//     final String month = date.month.toString().padLeft(2, '0');

//     final String day = date.day.toString().padLeft(2, '0');

//     return '$year-$month-$day';
//   }

//   Future<void> _saveDiary() async {
//     FocusScope.of(context).unfocus();

//     final String title = _titleController.text.trim();
//     final String description = _descriptionController.text.trim();

//     if (title.isEmpty) {
//       _showMessage('Please enter Heading or Title');
//       return;
//     }

//     if (description.isEmpty) {
//       _showMessage('Please enter Description');
//       return;
//     }

//     if (AppData.accYear == null) {
//       _showMessage('Academic year is not available');
//       return;
//     }

//     if (AppData.employeeId == null) {
//       _showMessage('Employee ID is not available');
//       return;
//     }

//     // if (AppData.branchId == null) {
//     //   _showMessage('Branch ID is not available');
//     //   return;
//     // }

//     final SaveDiaryParameter request = SaveDiaryParameter(
//       accYear: AppData.accYear!,
//       standardId: widget.standardId,
//       divisionId: widget.divisionId,
//       subjectId: widget.subjectId,
//       employeeId: AppData.employeeId!,
//       diaryType: 1,
//       diaryTitle: title,
//       description: description,
//       diaryDate: formatApiDate(widget.diaryDate),
//       dueDate: formatApiDate(widget.dueDate),
//       isActive: true,
//       isFavourite: widget.isFavourite,
//       branchId: 1,
//       createdUser: '',
//       files: const [''],
//       videoUrl: '',
//     );

//     debugPrint('==========================================');
//     debugPrint('📘 SAVE DIARY REQUEST');
//     debugPrint('AccYear: ${AppData.accYear}');
//     debugPrint('Standard ID: ${widget.standardId}');
//     debugPrint('Division ID: ${widget.divisionId}');
//     debugPrint('Subject ID: ${widget.subjectId}');
//     debugPrint('Employee ID: ${AppData.employeeId}');
//     debugPrint('Diary Type: 1');
//     debugPrint('Diary Title: $title');
//     debugPrint('Description: $description');
//     debugPrint('Diary Date: ${formatApiDate(widget.diaryDate)}');
//     debugPrint('Due Date: ${formatApiDate(widget.dueDate)}');
//     debugPrint('Is Active: true');
//     debugPrint('Is Favourite: ${widget.isFavourite}');
//     debugPrint('Branch ID: ${AppData.branchId}');
//     debugPrint('Created User: ${''}');
//     debugPrint('Files: [""]');
//     debugPrint('Video URL: ""');
//     debugPrint('==========================================');

//     await context.read<DiaryCubit>().saveDiary(request);
//   }

//   void _showMessage(String message) {
//     if (!mounted) {
//       return;
//     }

//     ScaffoldMessenger.of(context)
//       ..hideCurrentSnackBar()
//       ..showSnackBar(
//         SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
//       );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<DiaryCubit, DiaryState>(
//       listenWhen: (previous, current) {
//         return current is SaveDiarySuccess || current is DiaryFailure;
//       },
//       listener: (context, state) {
//         if (state is SaveDiarySuccess) {
//           final String apiMessage = state.response.error?.toString() ?? '';

//           _showMessage(
//             apiMessage.trim().isNotEmpty
//                 ? apiMessage
//                 : 'Diary saved successfully',
//           );

//           _titleController.clear();
//           _descriptionController.clear();

//           setState(() {
//             voiceState = VoiceState.idle;
//           });

//           Navigator.pop(context, true);
//         } else if (state is DiaryFailure) {
//           _showMessage(state.message);
//         }
//       },
//       builder: (context, state) {
//         final bool isSaving = state is SaveDiaryLoading;

//         return Scaffold(
//           backgroundColor: bgColor,
//           body: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 18),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 12),

//                   _buildHeader(isSaving),

//                   const SizedBox(height: 28),

//                   _inputBox(
//                     controller: _titleController,
//                     hint: 'Heading Or Title',
//                     height: 44,
//                   ),

//                   const SizedBox(height: 14),

//                   _inputBox(
//                     controller: _descriptionController,
//                     hint: 'Description',
//                     height: 118,
//                     maxLines: 5,
//                   ),

//                   const SizedBox(height: 14),

//                   _attachmentBox(),

//                   const SizedBox(height: 10),

//                   const Row(
//                     children: [
//                       Icon(Icons.info, size: 15, color: Colors.grey),
//                       SizedBox(width: 5),
//                       Expanded(
//                         child: Text(
//                           'Allow Pdf, Doc, Docx, Jpg, Png, Mp3',
//                           style: TextStyle(
//                             fontSize: 11,
//                             color: Color(0xff5C5C5C),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 12),

//                   _voiceWidget(isSaving),

//                   const Spacer(),

//                   SizedBox(
//                     width: double.infinity,
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed: isSaving ? null : _saveDiary,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: primaryColor,
//                         disabledBackgroundColor: primaryColor.withOpacity(0.6),
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                       ),
//                       child: isSaving
//                           ? const SizedBox(
//                               width: 21,
//                               height: 21,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2.2,
//                                 color: Colors.white,
//                               ),
//                             )
//                           : const Text(
//                               'Save',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                     ),
//                   ),

//                   const SizedBox(height: 65),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildHeader(bool isSaving) {
//     return Row(
//       children: [
//         GestureDetector(
//           onTap: isSaving
//               ? null
//               : () {
//                   Navigator.maybePop(context);
//                 },
//           child: Icon(
//             Icons.arrow_back,
//             size: 22,
//             color: isSaving ? Colors.grey : Colors.black,
//           ),
//         ),
//         const Expanded(
//           child: Center(
//             child: Text(
//               'Select Your Class',
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//             ),
//           ),
//         ),
//         const SizedBox(width: 22),
//       ],
//     );
//   }

//   Widget _inputBox({
//     required TextEditingController controller,
//     required String hint,
//     required double height,
//     int maxLines = 1,
//   }) {
//     return Container(
//       height: height,
//       decoration: BoxDecoration(
//         color: fieldColor,
//         borderRadius: BorderRadius.circular(7),
//         border: Border.all(color: borderColor),
//       ),
//       child: TextField(
//         controller: controller,
//         maxLines: maxLines,
//         textInputAction: maxLines == 1
//             ? TextInputAction.next
//             : TextInputAction.newline,
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: const TextStyle(fontSize: 12, color: Colors.black),
//           suffixIcon: Padding(
//             padding: const EdgeInsets.all(10),
//             child: SvgPicture.asset(
//               'assets/icons/Group (8).svg',
//               width: 25,
//               height: 25,
//             ),
//           ),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 12,
//             vertical: 12,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _attachmentBox() {
//     return GestureDetector(
//       onTap: () {
//         _showMessage('Attachment selection is not implemented yet');
//       },
//       child: CustomPaint(
//         painter: DashedBorderPainter(),
//         child: Container(
//           width: double.infinity,
//           height: 105,
//           decoration: BoxDecoration(
//             color: Colors.transparent,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SvgPicture.asset(
//                 'assets/icons/Group (9).svg',
//                 width: 24,
//                 height: 24,
//                 fit: BoxFit.contain,
//               ),
//               const SizedBox(height: 6),
//               const Text(
//                 'Attachment',
//                 style: TextStyle(fontSize: 12, color: Colors.black),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _voiceWidget(bool isSaving) {
//     switch (voiceState) {
//       case VoiceState.idle:
//         return GestureDetector(
//           onTap: isSaving
//               ? null
//               : () {
//                   setState(() {
//                     voiceState = VoiceState.recording;
//                   });
//                 },
//           child: Container(
//             height: 46,
//             decoration: BoxDecoration(
//               color: fieldColor,
//               borderRadius: BorderRadius.circular(7),
//             ),
//             child: Row(
//               children: [
//                 const SizedBox(width: 12),
//                 const Text(
//                   'Record Your Voice',
//                   style: TextStyle(fontSize: 12, color: Colors.black),
//                 ),
//                 const Spacer(),
//                 Container(
//                   width: 38,
//                   height: 38,
//                   decoration: const BoxDecoration(
//                     color: Colors.black,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(Icons.mic, color: Colors.white, size: 18),
//                 ),
//                 const SizedBox(width: 6),
//               ],
//             ),
//           ),
//         );

//       case VoiceState.recording:
//         return GestureDetector(
//           onTap: isSaving
//               ? null
//               : () {
//                   setState(() {
//                     voiceState = VoiceState.recorded;
//                   });
//                 },
//           child: Container(
//             height: 50,
//             decoration: BoxDecoration(
//               color: fieldColor,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: const Color(0xffB9B7FF), width: 1.3),
//             ),
//             child: Row(
//               children: [
//                 const SizedBox(width: 10),
//                 const Icon(Icons.mic, size: 18, color: Colors.red),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: CustomPaint(
//                     painter: WaveformPainter(color: primaryColor),
//                     child: const SizedBox(height: 34),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 const Text('0:12', style: TextStyle(fontSize: 10)),
//                 const SizedBox(width: 10),
//                 Container(
//                   width: 32,
//                   height: 32,
//                   decoration: BoxDecoration(
//                     color: primaryColor,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(Icons.stop, color: Colors.white, size: 16),
//                 ),
//                 const SizedBox(width: 8),
//               ],
//             ),
//           ),
//         );

//       case VoiceState.recorded:
//         return Container(
//           height: 50,
//           decoration: BoxDecoration(
//             color: fieldColor,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: borderColor),
//           ),
//           child: Row(
//             children: [
//               const SizedBox(width: 10),
//               GestureDetector(
//                 onTap: isSaving
//                     ? null
//                     : () {
//                         // Add audio playback here.
//                       },
//                 child: const Icon(
//                   Icons.play_arrow,
//                   size: 24,
//                   color: Color(0xff20345C),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: CustomPaint(
//                   painter: WaveformPainter(color: primaryColor),
//                   child: const SizedBox(height: 34),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               const Text('0:12', style: TextStyle(fontSize: 10)),
//               const SizedBox(width: 14),
//               GestureDetector(
//                 onTap: isSaving
//                     ? null
//                     : () {
//                         setState(() {
//                           voiceState = VoiceState.idle;
//                         });
//                       },
//                 child: const Icon(
//                   Icons.delete_outline,
//                   color: Colors.red,
//                   size: 19,
//                 ),
//               ),
//               const SizedBox(width: 12),
//             ],
//           ),
//         );
//     }
//   }
// }

// class DashedBorderPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     const double dashWidth = 8;
//     const double dashSpace = 6;

//     final Paint paint = Paint()
//       ..color = Colors.black54
//       ..strokeWidth = 1
//       ..style = PaintingStyle.stroke;

//     final Path path = Path()
//       ..addRRect(
//         RRect.fromRectAndRadius(
//           Rect.fromLTWH(0, 0, size.width, size.height),
//           const Radius.circular(8),
//         ),
//       );

//     for (final PathMetric metric in path.computeMetrics()) {
//       double distance = 0;

//       while (distance < metric.length) {
//         final double end = min(distance + dashWidth, metric.length);

//         final Path extractedPath = metric.extractPath(distance, end);

//         canvas.drawPath(extractedPath, paint);

//         distance += dashWidth + dashSpace;
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant DashedBorderPainter oldDelegate) {
//     return false;
//   }
// }

// class WaveformPainter extends CustomPainter {
//   final Color color;

//   WaveformPainter({required this.color});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = color.withOpacity(0.8)
//       ..strokeWidth = 2
//       ..strokeCap = StrokeCap.round;

//     final Random random = Random(4);

//     double x = 0;

//     while (x < size.width) {
//       final double barHeight = 8 + random.nextDouble() * 24;

//       final double y1 = size.height / 2 - barHeight / 2;

//       final double y2 = size.height / 2 + barHeight / 2;

//       canvas.drawLine(Offset(x, y1), Offset(x, y2), paint);

//       x += 5;
//     }
//   }

//   @override
//   bool shouldRepaint(covariant WaveformPainter oldDelegate) {
//     return oldDelegate.color != color;
//   }
// }
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:cristalteacher/core/appdata/appdata.dart';
import 'package:cristalteacher/features/diary/domain/parameters/save_diary_parameter.dart';
import 'package:cristalteacher/features/diary/presentation/cubit/diary_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

enum VoiceState { idle, recording, recorded }

class SelectedDiaryFile {
  final String name;
  final String extension;
  final Uint8List bytes;
  final int size;

  const SelectedDiaryFile({
    required this.name,
    required this.extension,
    required this.bytes,
    required this.size,
  });

  String get mimeType {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return 'application/pdf';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'mp3':
        return 'audio/mpeg';
      default:
        return 'application/octet-stream';
    }
  }

  String get dataUri {
    return 'data:$mimeType;base64,${base64Encode(bytes)}';
  }
}

class SelectYourClassScreen extends StatefulWidget {
  final int standardId;
  final String standardName;

  final int divisionId;
  final String divisionName;

  final int subjectId;
  final String subjectName;

  final DateTime diaryDate;
  final DateTime dueDate;

  final bool isFavourite;

  const SelectYourClassScreen({
    super.key,
    required this.standardId,
    required this.standardName,
    required this.divisionId,
    required this.divisionName,
    required this.subjectId,
    required this.subjectName,
    required this.diaryDate,
    required this.dueDate,
    required this.isFavourite,
  });

  @override
  State<SelectYourClassScreen> createState() => _SelectYourClassScreenState();
}

class _SelectYourClassScreenState extends State<SelectYourClassScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<SelectedDiaryFile> _selectedFiles = [];

  VoiceState voiceState = VoiceState.idle;

  Timer? _recordingTimer;

  Duration _recordingDuration = Duration.zero;
  Duration _playbackPosition = Duration.zero;
  Duration _playbackDuration = Duration.zero;

  String? _recordedAudioPath;
  bool _isPlaying = false;
  bool _isPickingFiles = false;

  static const int _maximumFileSize = 10 * 1024 * 1024;

  static const List<String> _allowedExtensions = [
    'pdf',
    'doc',
    'docx',
    'jpg',
    'jpeg',
    'png',
    'mp3',
  ];

  final Color bgColor = const Color(0xffFBF7FF);
  final Color fieldColor = const Color(0xffEEF4FF);
  final Color primaryColor = const Color(0xff9B73E6);
  final Color borderColor = const Color(0xffB7C4D6);

  @override
  void initState() {
    super.initState();

    _configureAudioPlayer();

    debugPrint('==========================================');
    debugPrint('📘 SELECTED DIARY DETAILS');
    debugPrint('Standard: ${widget.standardName} (${widget.standardId})');
    debugPrint('Division: ${widget.divisionName} (${widget.divisionId})');
    debugPrint('Subject: ${widget.subjectName} (${widget.subjectId})');
    debugPrint('Diary Date: ${formatApiDate(widget.diaryDate)}');
    debugPrint('Due Date: ${formatApiDate(widget.dueDate)}');
    debugPrint('Is Favourite: ${widget.isFavourite}');
    debugPrint('Employee ID: ${AppData.employeeId}');
    debugPrint('==========================================');
  }

  void _configureAudioPlayer() {
    _audioPlayer.onDurationChanged.listen((duration) {
      if (!mounted) return;

      setState(() {
        _playbackDuration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      if (!mounted) return;

      setState(() {
        _playbackPosition = position;
      });
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      if (!mounted) return;

      setState(() {
        _isPlaying = false;
        _playbackPosition = Duration.zero;
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;

      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });
  }

  @override
  void dispose() {
    _recordingTimer?.cancel();

    _titleController.dispose();
    _descriptionController.dispose();

    _audioRecorder.dispose();
    _audioPlayer.dispose();

    super.dispose();
  }

  String formatApiDate(DateTime date) {
    final String year = date.year.toString();
    final String month = date.month.toString().padLeft(2, '0');
    final String day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  String _formatDuration(Duration duration) {
    final int minutes = duration.inMinutes;
    final int seconds = duration.inSeconds.remainder(60);

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    }

    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }

    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  IconData _getFileIcon(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf_outlined;
      case 'doc':
      case 'docx':
        return Icons.description_outlined;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image_outlined;
      case 'mp3':
        return Icons.audio_file_outlined;
      default:
        return Icons.insert_drive_file_outlined;
    }
  }

  Future<void> _pickAttachments() async {
    if (_isPickingFiles) return;

    setState(() {
      _isPickingFiles = true;
    });

    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: _allowedExtensions,
        withData: true,
      );

      if (result == null) {
        return;
      }

      final List<SelectedDiaryFile> newFiles = [];

      for (final PlatformFile platformFile in result.files) {
        final String extension = (platformFile.extension ?? '').toLowerCase();

        if (!_allowedExtensions.contains(extension)) {
          _showMessage('${platformFile.name} is not a supported file');
          continue;
        }

        if (platformFile.size > _maximumFileSize) {
          _showMessage('${platformFile.name} exceeds the 10 MB limit');
          continue;
        }

        Uint8List? bytes = platformFile.bytes;

        if (bytes == null && platformFile.path != null) {
          bytes = await File(platformFile.path!).readAsBytes();
        }

        if (bytes == null || bytes.isEmpty) {
          _showMessage('Unable to read ${platformFile.name}');
          continue;
        }

        final bool alreadySelected = _selectedFiles.any(
          (file) =>
              file.name == platformFile.name && file.size == platformFile.size,
        );

        final bool duplicatedInCurrentSelection = newFiles.any(
          (file) =>
              file.name == platformFile.name && file.size == platformFile.size,
        );

        if (alreadySelected || duplicatedInCurrentSelection) {
          continue;
        }

        newFiles.add(
          SelectedDiaryFile(
            name: platformFile.name,
            extension: extension,
            bytes: bytes,
            size: platformFile.size,
          ),
        );
      }

      if (!mounted) return;

      setState(() {
        _selectedFiles.addAll(newFiles);
      });

      if (newFiles.isNotEmpty) {
        _showMessage(
          '${newFiles.length} attachment'
          '${newFiles.length == 1 ? '' : 's'} selected',
        );
      }
    } catch (error, stackTrace) {
      debugPrint('Attachment selection error: $error');
      debugPrintStack(stackTrace: stackTrace);

      _showMessage('Unable to select attachments');
    } finally {
      if (mounted) {
        setState(() {
          _isPickingFiles = false;
        });
      }
    }
  }

  void _removeAttachment(int index) {
    if (index < 0 || index >= _selectedFiles.length) {
      return;
    }

    setState(() {
      _selectedFiles.removeAt(index);
    });
  }

  Future<void> _startRecording() async {
    try {
      await _audioPlayer.stop();

      final bool hasPermission = await _audioRecorder.hasPermission();

      if (!hasPermission) {
        _showMessage('Microphone permission is required to record audio');
        return;
      }

      final Directory temporaryDirectory = await getTemporaryDirectory();

      final String audioPath =
          '${temporaryDirectory.path}/diary_voice_'
          '${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _audioRecorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
        ),
        path: audioPath,
      );

      _recordingTimer?.cancel();

      if (!mounted) return;

      setState(() {
        _recordedAudioPath = audioPath;
        _recordingDuration = Duration.zero;
        _playbackPosition = Duration.zero;
        _playbackDuration = Duration.zero;
        _isPlaying = false;
        voiceState = VoiceState.recording;
      });

      _recordingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;

        setState(() {
          _recordingDuration += const Duration(seconds: 1);
        });
      });
    } catch (error, stackTrace) {
      debugPrint('Start recording error: $error');
      debugPrintStack(stackTrace: stackTrace);

      _showMessage('Unable to start voice recording');

      if (mounted) {
        setState(() {
          voiceState = VoiceState.idle;
        });
      }
    }
  }

  Future<void> _stopRecording() async {
    try {
      _recordingTimer?.cancel();
      _recordingTimer = null;

      final String? path = await _audioRecorder.stop();

      if (path == null) {
        throw Exception('Recording path was not returned');
      }

      final File audioFile = File(path);

      if (!await audioFile.exists()) {
        throw Exception('Recorded audio file does not exist');
      }

      final int audioSize = await audioFile.length();

      if (audioSize <= 0) {
        throw Exception('Recorded audio file is empty');
      }

      if (!mounted) return;

      setState(() {
        _recordedAudioPath = path;
        _playbackDuration = _recordingDuration;
        _playbackPosition = Duration.zero;
        voiceState = VoiceState.recorded;
      });
    } catch (error, stackTrace) {
      debugPrint('Stop recording error: $error');
      debugPrintStack(stackTrace: stackTrace);

      _showMessage('Unable to save voice recording');

      if (mounted) {
        setState(() {
          _recordedAudioPath = null;
          voiceState = VoiceState.idle;
        });
      }
    }
  }

  Future<void> _toggleAudioPlayback() async {
    final String? audioPath = _recordedAudioPath;

    if (audioPath == null || audioPath.isEmpty) {
      _showMessage('Recorded audio is not available');
      return;
    }

    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
        return;
      }

      final PlayerState playerState = _audioPlayer.state;

      if (playerState == PlayerState.paused) {
        await _audioPlayer.resume();
      } else {
        await _audioPlayer.play(DeviceFileSource(audioPath));
      }
    } catch (error, stackTrace) {
      debugPrint('Audio playback error: $error');
      debugPrintStack(stackTrace: stackTrace);

      _showMessage('Unable to play the recorded audio');
    }
  }

  Future<void> _deleteRecording() async {
    try {
      _recordingTimer?.cancel();
      _recordingTimer = null;

      if (await _audioRecorder.isRecording()) {
        await _audioRecorder.stop();
      }

      await _audioPlayer.stop();

      final String? audioPath = _recordedAudioPath;

      if (audioPath != null && audioPath.isNotEmpty) {
        final File audioFile = File(audioPath);

        if (await audioFile.exists()) {
          await audioFile.delete();
        }
      }
    } catch (error) {
      debugPrint('Delete recording error: $error');
    } finally {
      if (mounted) {
        setState(() {
          _recordedAudioPath = null;
          _recordingDuration = Duration.zero;
          _playbackDuration = Duration.zero;
          _playbackPosition = Duration.zero;
          _isPlaying = false;
          voiceState = VoiceState.idle;
        });
      }
    }
  }

  Future<List<String>> _buildApiFiles() async {
    final List<String> files = _selectedFiles
        .map((file) => file.dataUri)
        .toList();

    final String? recordedAudioPath = _recordedAudioPath;

    if (recordedAudioPath != null &&
        recordedAudioPath.isNotEmpty &&
        voiceState == VoiceState.recorded) {
      final File audioFile = File(recordedAudioPath);

      if (await audioFile.exists()) {
        final Uint8List audioBytes = await audioFile.readAsBytes();

        if (audioBytes.isNotEmpty) {
          files.add('data:audio/mp4;base64,${base64Encode(audioBytes)}');
        }
      }
    }

    return files;
  }

  Future<void> _saveDiary() async {
    FocusScope.of(context).unfocus();

    final String title = _titleController.text.trim();
    final String description = _descriptionController.text.trim();

    if (voiceState == VoiceState.recording) {
      _showMessage('Please stop the voice recording before saving');
      return;
    }

    if (title.isEmpty) {
      _showMessage('Please enter Heading or Title');
      return;
    }

    if (description.isEmpty) {
      _showMessage('Please enter Description');
      return;
    }

    if (AppData.accYear == null) {
      _showMessage('Academic year is not available');
      return;
    }

    if (AppData.employeeId == null) {
      _showMessage('Employee ID is not available');
      return;
    }

    try {
      final List<String> apiFiles = await _buildApiFiles();

      final SaveDiaryParameter request = SaveDiaryParameter(
        accYear: AppData.accYear!,
        standardId: widget.standardId,
        divisionId: widget.divisionId,
        subjectId: widget.subjectId,
        employeeId: AppData.employeeId!,
        diaryType: 1,
        diaryTitle: title,
        description: description,
        diaryDate: formatApiDate(widget.diaryDate),
        dueDate: formatApiDate(widget.dueDate),
        isActive: true,
        isFavourite: widget.isFavourite,
        branchId: AppData.branchId ?? 1,
        createdUser: '',
        files: apiFiles,
        videoUrl: '',
      );

      debugPrint('==========================================');
      debugPrint('📘 SAVE DIARY REQUEST');
      debugPrint('AccYear: ${AppData.accYear}');
      debugPrint('Standard ID: ${widget.standardId}');
      debugPrint('Division ID: ${widget.divisionId}');
      debugPrint('Subject ID: ${widget.subjectId}');
      debugPrint('Employee ID: ${AppData.employeeId}');
      debugPrint('Diary Type: 1');
      debugPrint('Diary Title: $title');
      debugPrint('Description: $description');
      debugPrint('Diary Date: ${formatApiDate(widget.diaryDate)}');
      debugPrint('Due Date: ${formatApiDate(widget.dueDate)}');
      debugPrint('Is Active: true');
      debugPrint('Is Favourite: ${widget.isFavourite}');
      debugPrint('Branch ID: ${AppData.branchId ?? 1}');
      debugPrint('Created User: ""');
      debugPrint('Attachment count: ${apiFiles.length}');
      debugPrint('Video URL: ""');
      debugPrint('==========================================');

      if (!mounted) return;

      await context.read<DiaryCubit>().saveDiary(request);
    } catch (error, stackTrace) {
      debugPrint('Prepare diary request error: $error');
      debugPrintStack(stackTrace: stackTrace);

      _showMessage('Unable to prepare attachments');
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiaryCubit, DiaryState>(
      listenWhen: (previous, current) {
        return current is SaveDiarySuccess || current is DiaryFailure;
      },
      listener: (context, state) async {
        if (state is SaveDiarySuccess) {
          final String apiMessage = state.response.message?.toString() ?? '';

          _showMessage(
            apiMessage.trim().isNotEmpty
                ? apiMessage
                : 'Diary saved successfully',
          );

          _titleController.clear();
          _descriptionController.clear();
          _selectedFiles.clear();

          await _deleteRecording();

          if (mounted) {
            Navigator.pop(context, true);
          }
        } else if (state is DiaryFailure) {
          _showMessage(state.message);
        }
      },
      builder: (context, state) {
        final bool isSaving = state is SaveDiaryLoading;

        return PopScope(
          canPop: !isSaving && voiceState != VoiceState.recording,
          child: Scaffold(
            backgroundColor: bgColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    _buildHeader(isSaving),
                    const SizedBox(height: 28),
                    Expanded(
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Column(
                          children: [
                            _inputBox(
                              controller: _titleController,
                              hint: 'Heading Or Title',
                              height: 44,
                              enabled: !isSaving,
                            ),
                            const SizedBox(height: 14),
                            _inputBox(
                              controller: _descriptionController,
                              hint: 'Description',
                              height: 118,
                              maxLines: 5,
                              enabled: !isSaving,
                            ),
                            const SizedBox(height: 14),
                            _attachmentBox(isSaving),
                            if (_selectedFiles.isNotEmpty) ...[
                              const SizedBox(height: 10),
                              _buildSelectedFileList(isSaving),
                            ],
                            const SizedBox(height: 10),
                            const Row(
                              children: [
                                Icon(Icons.info, size: 15, color: Colors.grey),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    'Allow Pdf, Doc, Docx, Jpg, Png, Mp3. Maximum 10 MB each.',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xff5C5C5C),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _voiceWidget(isSaving),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: isSaving ? null : _saveDiary,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          disabledBackgroundColor: primaryColor.withOpacity(
                            0.6,
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: isSaving
                            ? const SizedBox(
                                width: 21,
                                height: 21,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Save',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(bool isSaving) {
    return Row(
      children: [
        GestureDetector(
          onTap: isSaving || voiceState == VoiceState.recording
              ? null
              : () {
                  Navigator.maybePop(context);
                },
          child: Icon(
            Icons.arrow_back,
            size: 22,
            color: isSaving || voiceState == VoiceState.recording
                ? Colors.grey
                : Colors.black,
          ),
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Select Your Class',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(width: 22),
      ],
    );
  }

  Widget _inputBox({
    required TextEditingController controller,
    required String hint,
    required double height,
    required bool enabled,
    int maxLines = 1,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: borderColor),
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        maxLines: maxLines,
        textInputAction: maxLines == 1
            ? TextInputAction.next
            : TextInputAction.newline,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 12, color: Colors.black),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              'assets/icons/Group (8).svg',
              width: 25,
              height: 25,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  Widget _attachmentBox(bool isSaving) {
    return GestureDetector(
      onTap: isSaving || _isPickingFiles ? null : _pickAttachments,
      child: CustomPaint(
        painter: DashedBorderPainter(),
        child: Container(
          width: double.infinity,
          height: 105,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isPickingFiles)
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: primaryColor,
                  ),
                )
              else
                SvgPicture.asset(
                  'assets/icons/Group (9).svg',
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              const SizedBox(height: 6),
              Text(
                _isPickingFiles ? 'Selecting...' : 'Attachment',
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
              if (_selectedFiles.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  '${_selectedFiles.length} file'
                  '${_selectedFiles.length == 1 ? '' : 's'} selected',
                  style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedFileList(bool isSaving) {
    return ListView.separated(
      itemCount: _selectedFiles.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) {
        return const SizedBox(height: 7);
      },
      itemBuilder: (context, index) {
        final SelectedDiaryFile file = _selectedFiles[index];

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: fieldColor,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: borderColor.withOpacity(0.6)),
          ),
          child: Row(
            children: [
              Icon(_getFileIcon(file.extension), size: 22, color: primaryColor),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _formatFileSize(file.size),
                      style: const TextStyle(fontSize: 9, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: isSaving ? null : () => _removeAttachment(index),
                visualDensity: VisualDensity.compact,
                icon: const Icon(Icons.close, color: Colors.red, size: 18),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _voiceWidget(bool isSaving) {
    switch (voiceState) {
      case VoiceState.idle:
        return GestureDetector(
          onTap: isSaving ? null : _startRecording,
          child: Container(
            height: 46,
            decoration: BoxDecoration(
              color: fieldColor,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                const Text(
                  'Record Your Voice',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                const Spacer(),
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: isSaving ? Colors.grey : Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.mic, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 6),
              ],
            ),
          ),
        );

      case VoiceState.recording:
        return Container(
          height: 50,
          decoration: BoxDecoration(
            color: fieldColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xffB9B7FF), width: 1.3),
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              const Icon(Icons.mic, size: 18, color: Colors.red),
              const SizedBox(width: 10),
              Expanded(
                child: CustomPaint(
                  painter: WaveformPainter(color: primaryColor),
                  child: const SizedBox(height: 34),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _formatDuration(_recordingDuration),
                style: const TextStyle(fontSize: 10),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: isSaving ? null : _stopRecording,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.stop, color: Colors.white, size: 16),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        );

      case VoiceState.recorded:
        final Duration displayedDuration = _playbackDuration > Duration.zero
            ? _playbackDuration
            : _recordingDuration;

        final double progress = displayedDuration.inMilliseconds > 0
            ? (_playbackPosition.inMilliseconds /
                      displayedDuration.inMilliseconds)
                  .clamp(0.0, 1.0)
            : 0;

        return Container(
          height: 55,
          decoration: BoxDecoration(
            color: fieldColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              GestureDetector(
                onTap: isSaving ? null : _toggleAudioPlayback,
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 25,
                  color: const Color(0xff20345C),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 3,
                      color: primaryColor,
                      backgroundColor: primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${_formatDuration(_playbackPosition)} / '
                        '${_formatDuration(displayedDuration)}',
                        style: const TextStyle(fontSize: 9),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: isSaving ? null : _deleteRecording,
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 19,
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        );
    }
  }
}

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double dashWidth = 8;
    const double dashSpace = 6;

    final Paint paint = Paint()
      ..color = Colors.black54
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(8),
        ),
      );

    for (final PathMetric metric in path.computeMetrics()) {
      double distance = 0;

      while (distance < metric.length) {
        final double end = min(distance + dashWidth, metric.length);

        final Path extractedPath = metric.extractPath(distance, end);

        canvas.drawPath(extractedPath, paint);

        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant DashedBorderPainter oldDelegate) {
    return false;
  }
}

class WaveformPainter extends CustomPainter {
  final Color color;

  WaveformPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color.withOpacity(0.8)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final Random random = Random(4);

    double x = 0;

    while (x < size.width) {
      final double barHeight = 8 + random.nextDouble() * 24;

      final double y1 = size.height / 2 - barHeight / 2;

      final double y2 = size.height / 2 + barHeight / 2;

      canvas.drawLine(Offset(x, y1), Offset(x, y2), paint);

      x += 5;
    }
  }

  @override
  bool shouldRepaint(covariant WaveformPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
