import 'package:cristalteacher/features/exams/presentation/screens/selectexam_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  static const Color primaryColor = Color(0xFF5A20E7);
  static const Color lightPurple = Color(0xFFF7F3FF);
  static const Color borderColor = Color(0xFFE8E8E8);

  final TextEditingController searchController = TextEditingController();

  String? selectedStandard;
  DateTime? fromDate;
  DateTime? toDate;

  final List<String> standards = [
    'Standard 1',
    'Standard 2',
    'Standard 3',
    'Standard 4',
    'Standard 5',
    'Standard 6',
    'Standard 7',
    'Standard 8',
    'Standard 9',
    'Standard 10',
  ];

  final List<ExamItem> exams = [
    ExamItem(
      id: 1,
      title: 'First Mid',
      date: DateTime(2025, 10, 12),
      className: '7',
      division: 'D',
      subject: 'Arabic',
    ),
    ExamItem(
      id: 2,
      title: 'First Mid',
      date: DateTime(2025, 10, 12),
      className: '7',
      division: 'D',
      subject: 'Arabic',
    ),
    ExamItem(
      id: 3,
      title: 'First Mid',
      date: DateTime(2025, 10, 12),
      className: '7',
      division: 'D',
      subject: 'Arabic',
    ),
    ExamItem(
      id: 4,
      title: 'Second Mid',
      date: DateTime(2025, 11, 15),
      className: '8',
      division: 'A',
      subject: 'English',
    ),
  ];

  List<ExamItem> get filteredExams {
    final query = searchController.text.trim().toLowerCase();

    return exams.where((exam) {
      final matchesSearch =
          query.isEmpty ||
          exam.title.toLowerCase().contains(query) ||
          exam.className.toLowerCase().contains(query) ||
          exam.division.toLowerCase().contains(query) ||
          exam.subject.toLowerCase().contains(query);

      final matchesFromDate =
          fromDate == null || !exam.date.isBefore(_dateOnly(fromDate!));

      final matchesToDate =
          toDate == null || !exam.date.isAfter(_dateOnly(toDate!));

      return matchesSearch && matchesFromDate && matchesToDate;
    }).toList();
  }

  DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.year}';
  }

  Future<void> _selectDate({required bool isFromDate}) async {
    final initialDate = isFromDate
        ? fromDate ?? DateTime.now()
        : toDate ?? fromDate ?? DateTime.now();

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
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

    if (selectedDate == null) return;

    if (isFromDate) {
      setState(() {
        fromDate = selectedDate;

        if (toDate != null && selectedDate.isAfter(toDate!)) {
          toDate = null;
        }
      });
    } else {
      if (fromDate != null && selectedDate.isBefore(fromDate!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('To date cannot be before from date')),
        );
        return;
      }

      setState(() {
        toDate = selectedDate;
      });
    }
  }

  void _deleteExam(ExamItem exam) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Delete exam'),
          content: Text('Are you sure you want to delete ${exam.title}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  exams.removeWhere((item) => item.id == exam.id);
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _editExam(ExamItem exam) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Edit ${exam.title}')));
  }

  void _addExam() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return SelectExamScreen();
        },
      ),
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Add new exam')));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final examList = filteredExams;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(28, 12, 28, 18),
            child: Column(
              children: [
                _buildStandardDropdown(),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildDateField(
                        title: 'From date',
                        date: fromDate,
                        onTap: () => _selectDate(isFromDate: true),
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
                        onTap: () => _selectDate(isFromDate: false),
                        onClear: () {
                          setState(() {
                            toDate = null;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF777777),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 19,
                      color: Color(0xFF777777),
                    ),
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              searchController.clear();
                              setState(() {});
                            },
                            icon: const Icon(Icons.close, size: 18),
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
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
                ),
              ],
            ),
          ),
          Expanded(
            child: examList.isEmpty
                ? const Center(
                    child: Text(
                      'No exams found',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(30, 18, 30, 90),
                    itemCount: examList.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _buildExamCard(examList[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addExam,
        backgroundColor: const Color(0xFF075BBF),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 34),
      ),
    );
  }

  Widget _buildStandardDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedStandard,
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

        // Add this
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
      items: standards.map((standard) {
        return DropdownMenuItem<String>(
          value: standard,
          child: Text(
            standard,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedStandard = value;
        });
      },
    );
  }

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
            // _buildPurpleIcon(
            //   Icons.calendar_month_rounded,
            //   size: 27,
            //   iconSize: 14,
            // ),
            buildPurpleIcon(
              'assets/icons/Group (15).svg',
              iconColor: Color(0xFF8561E1),
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

  Widget _buildExamCard(ExamItem exam) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 13, 14, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFFDEDEDE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  exam.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _editExam(exam),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  child: Text(
                    'Edit',
                    style: TextStyle(color: Color(0xFF32B900), fontSize: 9),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _deleteExam(exam),
                child: const Padding(
                  padding: EdgeInsets.only(left: 5, top: 2, bottom: 2),
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.red, fontSize: 9),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Text(
            _formatDate(exam.date),
            style: const TextStyle(color: Color(0xFF6D6D6D), fontSize: 10),
          ),
          const SizedBox(height: 20),
          Container(
            height: 64,
            decoration: BoxDecoration(
              color: lightPurple,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildExamInfo(
                    assetPath: 'assets/icons/Group 951.svg',
                    title: 'class',
                    value: exam.className,
                  ),
                ),
                _buildDivider(),
                Expanded(
                  child: _buildExamInfo(
                    assetPath: 'assets/icons/Group (17).svg',
                    title: 'Division',
                    value: exam.division,
                  ),
                ),
                _buildDivider(),
                Expanded(
                  child: _buildExamInfo(
                    assetPath: 'assets/icons/Group (18).svg',
                    title: 'Subject',
                    value: exam.subject,
                    valueFontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //   Widget _buildExamInfo({
  //     required IconData icon,
  //     required String title,
  //     required String value,
  //     double valueFontSize = 14,
  //   }) {
  //     return Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Container(
  //                 width: 24,
  //                 height: 24,
  //                 decoration: const BoxDecoration(
  //                   color: Colors.white,
  //                   shape: BoxShape.circle,
  //                 ),
  //                 alignment: Alignment.center,
  //                 child: Icon(icon, size: 13, color: primaryColor),
  //               ),
  //               const SizedBox(width: 5),
  //               Flexible(
  //                 child: Text(
  //                   title,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: const TextStyle(color: Color(0xFF555555), fontSize: 9),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 4),
  //           Text(
  //             value,
  //             overflow: TextOverflow.ellipsis,
  //             style: TextStyle(
  //               color: primaryColor,
  //               fontSize: valueFontSize,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  Widget _buildExamInfo({
    required String assetPath,
    required String title,
    required String value,
    double valueFontSize = 14,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  assetPath,
                  width: 13,
                  height: 13,
                  //   colorFilter: const ColorFilter.mode(
                  //     primaryColor,
                  //     BlendMode.srcIn,
                  //   ),
                ),
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Color(0xFF555555), fontSize: 9),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xff4D21DB),
              fontSize: valueFontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(width: 1, height: 38, color: const Color(0xFFE8E0F8));
  }
}

class ExamItem {
  final int id;
  final String title;
  final DateTime date;
  final String className;
  final String division;
  final String subject;

  const ExamItem({
    required this.id,
    required this.title,
    required this.date,
    required this.className,
    required this.division,
    required this.subject,
  });
}
