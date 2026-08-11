import 'package:cristalteacher/core/appdata/appdata.dart';
import 'package:cristalteacher/core/utils/date_utils_helper.dart';
import 'package:cristalteacher/features/authentication/domain/entities/class_details_entity.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/fetch_tutorshipclass_parameter.dart';
import 'package:cristalteacher/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:cristalteacher/features/diary/domain/entities/diary_entity.dart';
import 'package:cristalteacher/features/diary/domain/parameters/fetch_diary_parameter.dart';
import 'package:cristalteacher/features/diary/presentation/cubit/diary_cubit.dart';
import 'package:cristalteacher/features/diary/presentation/screens/creatediary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class DiaryTypeScreen extends StatefulWidget {
  final int branchId;
  final String userId;

  const DiaryTypeScreen({super.key, this.branchId = 1, this.userId = '1'});

  @override
  State<DiaryTypeScreen> createState() => _DiaryTypeScreenState();
}

class _DiaryTypeScreenState extends State<DiaryTypeScreen> {
  int selectedStandardId = 1;
  int selectedDivisionId = 1;

  DateTime? fromDate;
  DateTime? toDate;
  final currentDate = DateUtilsHelper.getCurrentDate();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDiary();
    });
  }

  void _fetchDiary() {
    final request = FetchDiaryParameter(
      branchId: widget.branchId,
      standardId: selectedStandardId,
      divisionId: selectedDivisionId,
      accyear: AppData.accYear!,
      fromDate: currentDate,
      toDate: currentDate,
      userId: '1', //AppData.userId.toString(),
    );

    debugPrint('====================================');
    debugPrint('📘 FETCH DIARY');
    debugPrint('Request: ${request.toJson()}');
    debugPrint('====================================');

    context.read<DiaryCubit>().fetchDiary(request);
  }

  // String _formatApiDate(DateTime date) {
  //   final year = date.year.toString();
  //   final month = date.month.toString().padLeft(2, '0');
  //   final day = date.day.toString().padLeft(2, '0');

  //   return '$year-$month-$day';
  // }

  void _applyFilter({
    int? standardId,
    String? standard,
    int? divisionId,
    String? division,
    int? subjectId,
    String? subject,
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    setState(() {
      selectedStandardId = standardId ?? selectedStandardId;
      selectedDivisionId = divisionId ?? selectedDivisionId;

      if (fromDate != null) {
        this.fromDate = fromDate;
      }

      if (toDate != null) {
        this.toDate = toDate;
      }
    });

    _fetchDiary();
  }

  Map<String, List<DiaryEntity>> _groupByDate(List<DiaryEntity> diaries) {
    final grouped = <String, List<DiaryEntity>>{};

    for (final diary in diaries) {
      final date = diary.diaryDate ?? 'Unknown Date';

      grouped.putIfAbsent(date, () => []);
      grouped[date]!.add(diary);
    }

    return grouped;
  }

  String _removeHtml(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '';
    }

    return value
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'</p>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll(RegExp(r'\n\s*\n'), '\n')
        .trim();
  }

  String _formatDisplayDate(String value) {
    final date = DateTime.tryParse(value);

    if (date == null) {
      return value;
    }

    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$day-$month-${date.year} '
        '${weekdays[date.weekday - 1]}';
  }

  String _formatTime(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }

    final date = DateTime.tryParse(value);

    if (date == null) {
      return '';
    }

    int hour = date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'Pm' : 'Am';

    if (hour == 0) {
      hour = 12;
    } else if (hour > 12) {
      hour -= 12;
    }

    return '$hour:$minute $period';
  }

  Future<void> _openCreateDiary() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CreateDiaryScreen()),
    );

    if (!mounted) {
      return;
    }

    _fetchDiary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),

      drawer: DiaryFilterDrawer(
        accYear: AppData.accYear,
        employeeId: null,
        userId: int.tryParse(widget.userId),
        onApply: _applyFilter,
      ),

      body: SafeArea(
        child: Builder(
          builder: (scaffoldContext) {
            return Stack(
              children: [
                Column(
                  children: [
                    _DiaryHeader(
                      onFilterTap: () {
                        Scaffold.of(scaffoldContext).openDrawer();
                      },
                    ),

                    Expanded(
                      child: BlocBuilder<DiaryCubit, DiaryState>(
                        builder: (context, state) {
                          if (state is DiaryLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xff9D75E8),
                              ),
                            );
                          }

                          if (state is DiaryFailure) {
                            return _DiaryErrorView(
                              message: state.message,
                              onRetry: _fetchDiary,
                            );
                          }

                          if (state is DiarySuccess) {
                            // Exact diary list returned from the API.
                            final List<DiaryEntity> diaries =
                                state.response.data ?? [];

                            return RefreshIndicator(
                              color: const Color(0xff9D75E8),
                              onRefresh: () async {
                                _fetchDiary();
                              },
                              child: _buildDiaryList(diaries),
                            );
                          }

                          return RefreshIndicator(
                            color: const Color(0xff9D75E8),
                            onRefresh: () async {
                              _fetchDiary();
                            },
                            child: ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: const [
                                SizedBox(height: 280),
                                Center(
                                  child: Text(
                                    'No diary data',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

                Positioned(
                  right: 18,
                  bottom: 48,
                  child: GestureDetector(
                    onTap: _openCreateDiary,
                    child: Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: const Color(0xff8665E4),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xffBCA8F5),
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.18),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDiaryList(List<DiaryEntity> diaries) {
    if (diaries.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 100),
        children: const [
          _SearchBox(),
          SizedBox(height: 250),
          Center(
            child: Text(
              'No diary entries found',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      );
    }

    final groupedDiaries = _groupByDate(diaries);
    final widgets = <Widget>[const _SearchBox(), const SizedBox(height: 12)];

    groupedDiaries.forEach((date, dateDiaries) {
      widgets.add(_DateTitle(date: _formatDisplayDate(date)));

      for (int index = 0; index < dateDiaries.length; index++) {
        final diary = dateDiaries[index];

        widgets.add(
          _ApiDiaryCard(
            diary: diary,
            title: _removeHtml(diary.diaryTitle),
            description: _removeHtml(diary.description),
            time: _formatTime(diary.createdDate),
          ),
        );

        if (index != dateDiaries.length - 1) {
          widgets.add(const SizedBox(height: 16));
        }
      }

      widgets.add(const SizedBox(height: 14));
    });

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 100),
      children: widgets,
    );
  }
}

class _DiaryHeader extends StatelessWidget {
  final VoidCallback onFilterTap;

  const _DiaryHeader({required this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      color: const Color(0xffF7F7F7),
      child: Row(
        children: [
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xff9D75E8),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.filter_list_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),

          const Expanded(
            child: Center(
              child: Text(
                'Diary Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff222222),
                ),
              ),
            ),
          ),

          const SizedBox(width: 36),
        ],
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: const Color(0xffFAFAFA),
        border: Border.all(color: const Color(0xffA9A9A9), width: 0.8),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const TextField(
        readOnly: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, size: 17, color: Color(0xff777777)),
          hintText: 'Search',
          hintStyle: TextStyle(fontSize: 12, color: Color(0xff777777)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 11),
        ),
      ),
    );
  }
}

class _DateTitle extends StatelessWidget {
  final String date;

  const _DateTitle({required this.date});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 1, bottom: 13),
        child: Text(
          date,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xff333333),
          ),
        ),
      ),
    );
  }
}

class _ApiDiaryCard extends StatelessWidget {
  final DiaryEntity diary;
  final String title;
  final String description;
  final String time;

  const _ApiDiaryCard({
    required this.diary,
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _CardColors.fromDiaryId(diary.diaryId);
    final files = diary.files ?? [];

    final headerTitle = diary.diaryTypeName?.trim().isNotEmpty == true
        ? _capitalize(diary.diaryTypeName!)
        : 'General';

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: colors.bodyColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 43,
              padding: const EdgeInsets.symmetric(horizontal: 17),
              color: colors.headerColor,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            headerTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        if (diary.isFavourite == true) ...[
                          const SizedBox(width: 5),
                          const Text('🔥', style: TextStyle(fontSize: 13)),
                        ],
                      ],
                    ),
                  ),

                  const _CircleActionButton(icon: Icons.edit_outlined),

                  const SizedBox(width: 8),

                  const _CircleActionButton(icon: Icons.delete_outline),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(14, 13, 14, 10),
              decoration: BoxDecoration(
                color: colors.bodyColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title.isNotEmpty)
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.45,
                        color: Color(0xff222222),
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                  if (title.isNotEmpty && description.isNotEmpty)
                    const SizedBox(height: 5),

                  if (description.isNotEmpty)
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 11,
                        height: 1.5,
                        color: Color(0xff333333),
                      ),
                    ),

                  if (files.isNotEmpty) ...[
                    const SizedBox(height: 17),

                    ...files.map(
                      (fileUrl) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _AttachmentBox(fileUrl: fileUrl),
                      ),
                    ),
                  ],

                  const SizedBox(height: 8),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      time,
                      style: const TextStyle(
                        fontSize: 8,
                        color: Color(0xff777777),
                      ),
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

  static String _capitalize(String text) {
    if (text.isEmpty) {
      return text;
    }

    return '${text[0].toUpperCase()}${text.substring(1)}';
  }
}

class _CircleActionButton extends StatelessWidget {
  final IconData icon;

  const _CircleActionButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 23,
      height: 23,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.65),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: const Color(0xff555555), size: 13),
    );
  }
}

class _AttachmentBox extends StatelessWidget {
  final String fileUrl;

  const _AttachmentBox({required this.fileUrl});

  String get fileName {
    final uri = Uri.tryParse(fileUrl);

    if (uri != null && uri.pathSegments.isNotEmpty) {
      return uri.pathSegments.last;
    }

    return 'Attachment';
  }

  String get extension {
    final parts = fileName.split('.');

    if (parts.length < 2) {
      return 'FILE';
    }

    return parts.last.toUpperCase();
  }

  bool get isImage {
    final ext = extension.toLowerCase();

    return ext == 'jpg' || ext == 'jpeg' || ext == 'png' || ext == 'webp';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 13),
      decoration: BoxDecoration(
        color: const Color(0xffFAF7FF),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xff111111), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 29,
            height: 29,
            decoration: BoxDecoration(
              color: const Color(0xffEF3340),
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: Text(
              isImage ? 'IMG' : extension,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 6,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  extension,
                  style: const TextStyle(fontSize: 7, color: Color(0xff666666)),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.file_download_outlined,
            size: 22,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

class _DiaryErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _DiaryErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.redAccent, size: 42),

            const SizedBox(height: 12),

            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Colors.redAccent),
            ),

            const SizedBox(height: 14),

            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff9D75E8),
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardColors {
  final Color headerColor;
  final Color bodyColor;

  const _CardColors({required this.headerColor, required this.bodyColor});

  factory _CardColors.fromDiaryId(int diaryId) {
    switch (diaryId % 4) {
      case 0:
        return const _CardColors(
          headerColor: Color(0xffFFD875),
          bodyColor: Color(0xffFFF8E8),
        );

      case 1:
        return const _CardColors(
          headerColor: Color(0xffF7A4DA),
          bodyColor: Color(0xffFDDCF1),
        );

      case 2:
        return const _CardColors(
          headerColor: Color(0xffAE87F1),
          bodyColor: Color(0xffDCCAFB),
        );

      default:
        return const _CardColors(
          headerColor: Color(0xffBDF276),
          bodyColor: Color(0xffE9FACA),
        );
    }
  }
}

class DiaryFilterDrawer extends StatefulWidget {
  final String? accYear;
  final int? employeeId;
  final int? userId;

  final void Function({
    int? standardId,
    String? standard,
    int? divisionId,
    String? division,
    int? subjectId,
    String? subject,
    DateTime? fromDate,
    DateTime? toDate,
  })?
  onApply;

  const DiaryFilterDrawer({
    super.key,
    required this.accYear,
    required this.employeeId,
    required this.userId,
    this.onApply,
  });

  @override
  State<DiaryFilterDrawer> createState() => _DiaryFilterDrawerState();
}

class _DiaryFilterDrawerState extends State<DiaryFilterDrawer> {
  int? selectedStandardId;
  int? selectedDivisionId;
  int? selectedSubjectId;

  String? selectedStandard;
  String? selectedDivision;
  String? selectedSubject;

  DateTime? fromDate;
  DateTime? toDate;

  List<TutorshipClass> tutorshipClasses = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchTutorshipClasses();
    });
  }

  void _fetchTutorshipClasses() {
    context.read<AuthenticationCubit>().fetchTutorshipClass(
      FetchTutorshipClassRequest(
        accyear: AppData.accYear,
        employeeId: AppData.employeeId,
        userId: AppData.userId,
      ),
    );
  }

  void _setInitialSelection(List<TutorshipClass> classes) {
    if (classes.isEmpty || selectedStandardId != null) {
      return;
    }

    TutorshipClass? firstStandard;
    DivisionDetails? firstDivision;
    SubjectDetails? firstSubject;

    for (final standard in classes) {
      final divisions = standard.division ?? [];

      if (divisions.isNotEmpty) {
        firstStandard = standard;
        firstDivision = divisions.first;

        final subjects = firstDivision.subject ?? [];

        if (subjects.isNotEmpty) {
          firstSubject = subjects.first;
        }

        break;
      }
    }

    selectedStandardId = firstStandard?.standardId;
    selectedStandard = firstStandard?.standard;

    selectedDivisionId = firstDivision?.divisionId;
    selectedDivision = firstDivision?.division;

    selectedSubjectId = firstSubject?.subjectId;
    selectedSubject = firstSubject?.subject;
  }

  List<_ClassOption> _getClassOptions(List<TutorshipClass> classes) {
    final List<_ClassOption> options = [];

    for (final standard in classes) {
      final divisions = standard.division ?? [];

      for (final division in divisions) {
        options.add(
          _ClassOption(
            standardId: standard.standardId,
            standard: standard.standard,
            divisionId: division.divisionId,
            division: division.division,
            subjects: division.subject ?? [],
          ),
        );
      }
    }

    return options;
  }

  _ClassOption? _getSelectedClassOption(List<_ClassOption> options) {
    for (final option in options) {
      if (option.standardId == selectedStandardId &&
          option.divisionId == selectedDivisionId) {
        return option;
      }
    }

    return null;
  }

  void _selectClass(_ClassOption option) {
    final subjects = option.subjects;

    setState(() {
      selectedStandardId = option.standardId;
      selectedStandard = option.standard;

      selectedDivisionId = option.divisionId;
      selectedDivision = option.division;

      if (subjects.isNotEmpty) {
        selectedSubjectId = subjects.first.subjectId;
        selectedSubject = subjects.first.subject;
      } else {
        selectedSubjectId = null;
        selectedSubject = null;
      }
    });
  }

  void _selectSubject(SubjectDetails subject) {
    setState(() {
      selectedSubjectId = subject.subjectId;
      selectedSubject = subject.subject;
    });
  }

  Future<void> pickDate({required bool isFromDate}) async {
    final DateTime initialDate = isFromDate
        ? fromDate ?? DateTime.now()
        : toDate ?? fromDate ?? DateTime.now();

    final DateTime firstDate = DateTime(2020);
    final DateTime lastDate = DateTime(2035);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate == null || !mounted) {
      return;
    }

    if (!isFromDate && fromDate != null && pickedDate.isBefore(fromDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('To date cannot be before From date')),
      );

      return;
    }

    setState(() {
      if (isFromDate) {
        fromDate = pickedDate;

        if (toDate != null && toDate!.isBefore(pickedDate)) {
          toDate = null;
        }
      } else {
        toDate = pickedDate;
      }
    });
  }

  String formatDate(DateTime? date, String placeholder) {
    if (date == null) {
      return placeholder;
    }

    final String day = date.day.toString().padLeft(2, '0');
    final String month = date.month.toString().padLeft(2, '0');
    final String year = date.year.toString();

    return '$day-$month-$year';
  }

  void _applyFilter() {
    widget.onApply?.call(
      standardId: selectedStandardId,
      standard: selectedStandard,
      divisionId: selectedDivisionId,
      division: selectedDivision,
      subjectId: selectedSubjectId,
      subject: selectedSubject,
      fromDate: fromDate,
      toDate: toDate,
    );

    debugPrint(
      'Selected Standard: '
      '$selectedStandard ($selectedStandardId)',
    );

    debugPrint(
      'Selected Division: '
      '$selectedDivision ($selectedDivisionId)',
    );

    debugPrint(
      'Selected Subject: '
      '$selectedSubject ($selectedSubjectId)',
    );

    debugPrint('From Date: $fromDate');
    debugPrint('To Date: $toDate');

    Navigator.pop(context);
  }

  void _resetFilter() {
    setState(() {
      selectedStandardId = null;
      selectedStandard = null;

      selectedDivisionId = null;
      selectedDivision = null;

      selectedSubjectId = null;
      selectedSubject = null;

      fromDate = null;
      toDate = null;

      _setInitialSelection(tutorshipClasses);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 230,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(12)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 30, 18, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  _DrawerIcon(),
                  SizedBox(width: 16),
                  Text(
                    'Filter',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              Expanded(
                child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
                  listenWhen: (previous, current) {
                    return current is FetchTutorshipClassSuccess;
                  },
                  listener: (context, state) {
                    if (state is FetchTutorshipClassSuccess) {
                      final classes = state.response.data?.tutorshipClass ?? [];

                      tutorshipClasses = classes;

                      if (selectedStandardId == null) {
                        setState(() {
                          _setInitialSelection(classes);
                        });
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is FetchTutorshipClassLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff9D75E8),
                        ),
                      );
                    }

                    if (state is FetchTutorshipClassFailure) {
                      return _buildErrorSection(state.message);
                    }

                    if (state is FetchTutorshipClassSuccess) {
                      tutorshipClasses =
                          state.response.data?.tutorshipClass ?? [];

                      if (tutorshipClasses.isEmpty) {
                        return const Center(
                          child: Text(
                            'No classes found',
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        );
                      }

                      return _buildDynamicFilterContent(tutorshipClasses);
                    }

                    if (tutorshipClasses.isNotEmpty) {
                      return _buildDynamicFilterContent(tutorshipClasses);
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton(
                  onPressed: _applyFilter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff9D75E8),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: const Text(
                    'Apply',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Center(
                child: GestureDetector(
                  onTap: _resetFilter,
                  child: const Text(
                    'Reset All',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff9D75E8),
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xff9D75E8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDynamicFilterContent(List<TutorshipClass> classes) {
    final classOptions = _getClassOptions(classes);

    final selectedClassOption = _getSelectedClassOption(classOptions);

    final List<SubjectDetails> subjects = selectedClassOption?.subjects ?? [];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _FilterTitle('Class'),

          const SizedBox(height: 10),

          if (classOptions.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'No class or division available',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            )
          else
            ...classOptions.map((option) {
              final bool isSelected =
                  option.standardId == selectedStandardId &&
                  option.divisionId == selectedDivisionId;

              return _CheckItem(
                title: option.displayName,
                value: isSelected,
                onChanged: () {
                  _selectClass(option);
                },
              );
            }),

          const SizedBox(height: 24),

          const _FilterTitle('Subject'),

          const SizedBox(height: 10),

          if (subjects.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'No subjects available',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            )
          else
            ...subjects.map((subject) {
              return _CheckItem(
                title: subject.subject ?? '',
                value: selectedSubjectId == subject.subjectId,
                onChanged: () {
                  _selectSubject(subject);
                },
              );
            }),

          const SizedBox(height: 24),

          const _FilterTitle('Date'),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    pickDate(isFromDate: true);
                  },
                  child: _DateBox(
                    icon: Icons.calendar_month,
                    text: formatDate(fromDate, 'From'),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: GestureDetector(
                  onTap: () {
                    pickDate(isFromDate: false);
                  },
                  child: _DateBox(
                    icon: Icons.calendar_month,
                    text: formatDate(toDate, 'To'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildErrorSection(String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red, fontSize: 12),
          ),

          const SizedBox(height: 12),

          TextButton(
            onPressed: _fetchTutorshipClasses,
            child: const Text(
              'Retry',
              style: TextStyle(color: Color(0xff9D75E8)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClassOption {
  final int? standardId;
  final String? standard;
  final int? divisionId;
  final String? division;
  final List<SubjectDetails> subjects;

  const _ClassOption({
    required this.standardId,
    required this.standard,
    required this.divisionId,
    required this.division,
    required this.subjects,
  });

  String get displayName {
    final standardName = standard?.trim() ?? '';
    final divisionName = division?.trim() ?? '';

    if (divisionName.isEmpty) {
      return standardName;
    }

    return '$standardName $divisionName';
  }
}

class _DrawerIcon extends StatelessWidget {
  const _DrawerIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: const BoxDecoration(
        color: Color(0xff9D75E8),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          "assets/icons/Vector.svg",
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}

class _FilterTitle extends StatelessWidget {
  final String title;

  const _FilterTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Color(0xff222222),
      ),
    );
  }
}

class _CheckItem extends StatelessWidget {
  final String title;
  final bool value;
  final VoidCallback onChanged;

  const _CheckItem({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Container(
              width: 17,
              height: 17,
              decoration: BoxDecoration(
                color: value ? const Color(0xff9D75E8) : Colors.white,
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: value
                      ? const Color(0xff9D75E8)
                      : const Color(0xffBDBDBD),
                ),
              ),
              alignment: Alignment.center,
              child: value
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: value ? FontWeight.w600 : FontWeight.w400,
                  color: const Color(0xff333333),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateBox extends StatelessWidget {
  final IconData icon;
  final String text;

  const _DateBox({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xffF8F8F8),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xffD7D7D7)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: const Color(0xff9D75E8)),

          const SizedBox(width: 6),

          Expanded(
            child: Text(
              text,
              maxLines: 1,
              style: const TextStyle(fontSize: 10, color: Color(0xff555555)),
            ),
          ),
        ],
      ),
    );
  }
}
