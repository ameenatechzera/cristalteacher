import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExamDetailsScreen extends StatefulWidget {
  const ExamDetailsScreen({super.key});

  @override
  State<ExamDetailsScreen> createState() => _ExamDetailsScreenState();
}

class _ExamDetailsScreenState extends State<ExamDetailsScreen> {
  static const Color primaryBlue = Color(0xFF0758C9);
  static const Color purple = Color(0xFF5C20F4);
  static const Color lightPurple = Color(0xFFF7F3FF);
  static const Color green = Color(0xFF22C900);

  final TextEditingController searchController = TextEditingController();

  final List<StudentMark> students = [
    StudentMark(
      id: '5236475',
      name: 'Ahamd Ayman',
      grade: 'A+',
      isPresent: true,
      teMark: '78',
      ceMark: '78',
      narration: '"Excellent progress! Your hard work, positive attitude,"',
    ),
    StudentMark(
      id: '5236475',
      name: 'Ahamd Ayman',
      grade: 'A+',
      isPresent: true,
      teMark: '78',
      ceMark: '78',
      narration: '"Excellent progress! Your hard work, positive attitude,"',
    ),
    StudentMark(
      id: '5236475',
      name: 'Ahamd Ayman',
      grade: 'A+',
      isPresent: true,
      teMark: '78',
      ceMark: '78',
      narration: '"Excellent progress! Your hard work, positive attitude,"',
    ),
  ];

  List<StudentMark> get filteredStudents {
    final query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      return students;
    }

    return students.where((student) {
      return student.name.toLowerCase().contains(query) ||
          student.id.toLowerCase().contains(query) ||
          student.grade.toLowerCase().contains(query);
    }).toList();
  }

  void _saveDetails() {
    for (final student in students) {
      debugPrint('Name: ${student.name}');
      debugPrint('ID: ${student.id}');
      debugPrint('Present: ${student.isPresent}');
      debugPrint('TE Mark: ${student.teController.text}');
      debugPrint('CE Mark: ${student.ceController.text}');
      debugPrint('Narration: ${student.narrationController.text}');
    }
  }

  void _changeAttendance(StudentMark student) {
    setState(() {
      student.isPresent = !student.isPresent;
    });
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
    final studentList = filteredStudents;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 23),
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
                onTap: _saveDetails,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: primaryBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
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
              child: studentList.isEmpty
                  ? const Center(
                      child: Text(
                        'No students found',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(27, 7, 27, 30),
                      itemCount: studentList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 13),
                      itemBuilder: (context, index) {
                        return _buildStudentCard(
                          student: studentList[index],
                          number: students.indexOf(studentList[index]) + 1,
                        );
                      },
                    ),
            ),
          ],
        ),
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
          const Text(
            'Mid Term Exam',
            style: TextStyle(
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
                    value: '10',
                  ),
                ),
                Expanded(
                  child: _buildExamInformation(
                    assetPath: 'assets/icons/Group (17).svg',
                    iconBackground: const Color(0xFFFF9BE7),
                    iconColor: const Color(0xFFE300AE),
                    title: 'Division',
                    value: 'A',
                  ),
                ),
                Expanded(
                  child: _buildExamInformation(
                    assetPath: 'assets/icons/Group (19).svg',
                    iconBackground: const Color(0xFF71CFFF),
                    iconColor: const Color(0xFF006AAE),
                    title: 'Subject',
                    value: 'Arabic',
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
      onChanged: (_) => setState(() {}),
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
              title: 'TE- max 80',
              controller: student.teController,
            ),
          ),
          Container(width: 1, height: 38, color: const Color(0xFFEDE6FA)),
          Expanded(
            child: _buildMarkField(
              icon: Icons.bookmark_rounded,
              title: 'CE- max 20',
              controller: student.ceController,
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
  final String id;
  final String name;
  final String grade;

  bool isPresent;

  final TextEditingController teController;
  final TextEditingController ceController;
  final TextEditingController narrationController;

  StudentMark({
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
