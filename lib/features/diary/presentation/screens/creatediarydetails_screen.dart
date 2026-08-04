// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

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
//   @override
//   void initState() {
//     super.initState();

//     debugPrint('Standard: ${widget.standardName} (${widget.standardId})');
//     debugPrint('Division: ${widget.divisionName} (${widget.divisionId})');
//     debugPrint('Subject: ${widget.subjectName} (${widget.subjectId})');
//     debugPrint('Diary Date: ${formatApiDate(widget.diaryDate)}');
//     debugPrint('Due Date: ${formatApiDate(widget.dueDate)}');
//     debugPrint('Is Favourite: ${widget.isFavourite}');
//   }

//   String formatApiDate(DateTime date) {
//     final String year = date.year.toString();
//     final String month = date.month.toString().padLeft(2, '0');
//     final String day = date.day.toString().padLeft(2, '0');

//     return '$year-$month-$day';
//   }

//   VoiceState voiceState = VoiceState.idle;

//   final Color bgColor = const Color(0xfffbf7ff);
//   final Color fieldColor = const Color(0xffeef4ff);
//   final Color primaryColor = const Color(0xff9B73E6);
//   final Color borderColor = const Color(0xffb7c4d6);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bgColor,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 18),
//           child: Column(
//             children: [
//               const SizedBox(height: 12),

//               // Header
//               Row(
//                 children: [
//                   const Icon(Icons.arrow_back, size: 22),
//                   const Expanded(
//                     child: Center(
//                       child: Text(
//                         "Select Your Class",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 22),
//                 ],
//               ),

//               const SizedBox(height: 28),

//               _inputBox(hint: "Heading Or Title", height: 44),

//               const SizedBox(height: 14),

//               _inputBox(hint: "Description", height: 118, maxLines: 5),

//               const SizedBox(height: 14),

//               _attachmentBox(),

//               const SizedBox(height: 10),

//               Row(
//                 children: const [
//                   Icon(Icons.info, size: 15, color: Colors.grey),
//                   SizedBox(width: 5),
//                   Text(
//                     "Allow Pdf , Doc, Docx, Jpg ,Png, Mp3",
//                     style: TextStyle(fontSize: 11, color: Color(0xff5c5c5c)),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 12),

//               _voiceWidget(),

//               const Spacer(),

//               SizedBox(
//                 width: double.infinity,
//                 height: 48,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: primaryColor,
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                   ),
//                   onPressed: () {},
//                   child: const Text(
//                     "Save",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 65),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _inputBox({
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
//         maxLines: maxLines,
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: const TextStyle(fontSize: 12, color: Colors.black),
//           suffixIcon: Padding(
//             padding: const EdgeInsets.all(10),

//             child: SvgPicture.asset(
//               "assets/icons/Group (8).svg", // Replace with your SVG path
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
//     return CustomPaint(
//       painter: DashedBorderPainter(),
//       child: Container(
//         width: double.infinity,
//         height: 105,
//         decoration: BoxDecoration(
//           color: Colors.transparent,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SvgPicture.asset(
//               "assets/icons/Group (9).svg", // Replace with your SVG path
//               width: 24,
//               height: 24,
//               fit: BoxFit.contain,
//             ),
//             SizedBox(height: 6),
//             Text(
//               "Attachment",
//               style: TextStyle(fontSize: 12, color: Colors.black),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _voiceWidget() {
//     switch (voiceState) {
//       case VoiceState.idle:
//         return GestureDetector(
//           onTap: () {
//             setState(() {
//               voiceState = VoiceState.recording;
//             });
//           },
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
//                   "Record Your Voice",
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
//           onTap: () {
//             setState(() {
//               voiceState = VoiceState.recorded;
//             });
//           },
//           child: Container(
//             height: 50,
//             decoration: BoxDecoration(
//               color: fieldColor,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: const Color(0xffb9b7ff), width: 1.3),
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
//                 const Text("0:12", style: TextStyle(fontSize: 10)),
//                 const SizedBox(width: 10),
//                 Container(
//                   width: 32,
//                   height: 32,
//                   decoration: BoxDecoration(
//                     color: primaryColor,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(Icons.mic, color: Colors.white, size: 16),
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
//               const Icon(Icons.play_arrow, size: 24, color: Color(0xff20345c)),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: CustomPaint(
//                   painter: WaveformPainter(color: primaryColor),
//                   child: const SizedBox(height: 34),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               const Text("0:12", style: TextStyle(fontSize: 10)),
//               const SizedBox(width: 14),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     voiceState = VoiceState.idle;
//                   });
//                 },
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

//     final paint = Paint()
//       ..color = Colors.black54
//       ..strokeWidth = 1
//       ..style = PaintingStyle.stroke;

//     final path = Path()
//       ..addRRect(
//         RRect.fromRectAndRadius(
//           Rect.fromLTWH(0, 0, size.width, size.height),
//           const Radius.circular(8),
//         ),
//       );

//     for (final metric in path.computeMetrics()) {
//       double distance = 0;
//       while (distance < metric.length) {
//         final extractPath = metric.extractPath(distance, distance + dashWidth);
//         canvas.drawPath(extractPath, paint);
//         distance += dashWidth + dashSpace;
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

// class WaveformPainter extends CustomPainter {
//   final Color color;

//   WaveformPainter({required this.color});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color.withOpacity(0.8)
//       ..strokeWidth = 2
//       ..strokeCap = StrokeCap.round;

//     final Random random = Random(4);
//     double x = 0;

//     while (x < size.width) {
//       final barHeight = 8 + random.nextDouble() * 24;
//       final y1 = size.height / 2 - barHeight / 2;
//       final y2 = size.height / 2 + barHeight / 2;

//       canvas.drawLine(Offset(x, y1), Offset(x, y2), paint);
//       x += 5;
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
import 'dart:math';
import 'dart:ui';

import 'package:cristalteacher/core/appdata/appdata.dart';
import 'package:cristalteacher/features/diary/domain/parameters/save_diary_parameter.dart';
import 'package:cristalteacher/features/diary/presentation/cubit/diary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum VoiceState { idle, recording, recorded }

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

  VoiceState voiceState = VoiceState.idle;

  final Color bgColor = const Color(0xffFBF7FF);
  final Color fieldColor = const Color(0xffEEF4FF);
  final Color primaryColor = const Color(0xff9B73E6);
  final Color borderColor = const Color(0xffB7C4D6);

  @override
  void initState() {
    super.initState();

    debugPrint('==========================================');
    debugPrint('📘 SELECTED DIARY DETAILS');
    debugPrint('Standard: ${widget.standardName} (${widget.standardId})');
    debugPrint('Division: ${widget.divisionName} (${widget.divisionId})');
    debugPrint('Subject: ${widget.subjectName} (${widget.subjectId})');
    debugPrint('Diary Date: ${formatApiDate(widget.diaryDate)}');
    debugPrint('Due Date: ${formatApiDate(widget.dueDate)}');
    debugPrint('Is Favourite: ${widget.isFavourite}');
    debugPrint('==========================================');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String formatApiDate(DateTime date) {
    final String year = date.year.toString();

    final String month = date.month.toString().padLeft(2, '0');

    final String day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  Future<void> _saveDiary() async {
    FocusScope.of(context).unfocus();

    final String title = _titleController.text.trim();
    final String description = _descriptionController.text.trim();

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

    // if (AppData.branchId == null) {
    //   _showMessage('Branch ID is not available');
    //   return;
    // }

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
      branchId: 1,
      createdUser: '',
      files: const [''],
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
    debugPrint('Branch ID: ${AppData.branchId}');
    debugPrint('Created User: ${''}');
    debugPrint('Files: [""]');
    debugPrint('Video URL: ""');
    debugPrint('==========================================');

    await context.read<DiaryCubit>().saveDiary(request);
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }

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
      listener: (context, state) {
        if (state is SaveDiarySuccess) {
          final String apiMessage = state.response.error?.toString() ?? '';

          _showMessage(
            apiMessage.trim().isNotEmpty
                ? apiMessage
                : 'Diary saved successfully',
          );

          _titleController.clear();
          _descriptionController.clear();

          setState(() {
            voiceState = VoiceState.idle;
          });

          Navigator.pop(context, true);
        } else if (state is DiaryFailure) {
          _showMessage(state.message);
        }
      },
      builder: (context, state) {
        final bool isSaving = state is SaveDiaryLoading;

        return Scaffold(
          backgroundColor: bgColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  const SizedBox(height: 12),

                  _buildHeader(isSaving),

                  const SizedBox(height: 28),

                  _inputBox(
                    controller: _titleController,
                    hint: 'Heading Or Title',
                    height: 44,
                  ),

                  const SizedBox(height: 14),

                  _inputBox(
                    controller: _descriptionController,
                    hint: 'Description',
                    height: 118,
                    maxLines: 5,
                  ),

                  const SizedBox(height: 14),

                  _attachmentBox(),

                  const SizedBox(height: 10),

                  const Row(
                    children: [
                      Icon(Icons.info, size: 15, color: Colors.grey),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          'Allow Pdf, Doc, Docx, Jpg, Png, Mp3',
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

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: isSaving ? null : _saveDiary,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        disabledBackgroundColor: primaryColor.withOpacity(0.6),
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

                  const SizedBox(height: 65),
                ],
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
          onTap: isSaving
              ? null
              : () {
                  Navigator.maybePop(context);
                },
          child: Icon(
            Icons.arrow_back,
            size: 22,
            color: isSaving ? Colors.grey : Colors.black,
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

  Widget _attachmentBox() {
    return GestureDetector(
      onTap: () {
        _showMessage('Attachment selection is not implemented yet');
      },
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
              SvgPicture.asset(
                'assets/icons/Group (9).svg',
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 6),
              const Text(
                'Attachment',
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _voiceWidget(bool isSaving) {
    switch (voiceState) {
      case VoiceState.idle:
        return GestureDetector(
          onTap: isSaving
              ? null
              : () {
                  setState(() {
                    voiceState = VoiceState.recording;
                  });
                },
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
                  decoration: const BoxDecoration(
                    color: Colors.black,
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
        return GestureDetector(
          onTap: isSaving
              ? null
              : () {
                  setState(() {
                    voiceState = VoiceState.recorded;
                  });
                },
          child: Container(
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
                const Text('0:12', style: TextStyle(fontSize: 10)),
                const SizedBox(width: 10),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.stop, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        );

      case VoiceState.recorded:
        return Container(
          height: 50,
          decoration: BoxDecoration(
            color: fieldColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              GestureDetector(
                onTap: isSaving
                    ? null
                    : () {
                        // Add audio playback here.
                      },
                child: const Icon(
                  Icons.play_arrow,
                  size: 24,
                  color: Color(0xff20345C),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomPaint(
                  painter: WaveformPainter(color: primaryColor),
                  child: const SizedBox(height: 34),
                ),
              ),
              const SizedBox(width: 8),
              const Text('0:12', style: TextStyle(fontSize: 10)),
              const SizedBox(width: 14),
              GestureDetector(
                onTap: isSaving
                    ? null
                    : () {
                        setState(() {
                          voiceState = VoiceState.idle;
                        });
                      },
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
