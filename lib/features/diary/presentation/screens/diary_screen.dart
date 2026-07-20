import 'package:cristalteacher/core/appdata/appdata.dart';
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

  DateTime fromDate = DateTime(2026, 6, 1);
  DateTime toDate = DateTime(2026, 7, 11);

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
      fromDate: "2026-07-14",
      toDate: "2026-07-14",
      userId: AppData.userId.toString(),
    );

    debugPrint('====================================');
    debugPrint('📘 FETCH DIARY');
    debugPrint('Request: ${request.toJson()}');
    debugPrint('====================================');

    context.read<DiaryCubit>().fetchDiary(request);
  }

  String _formatApiDate(DateTime date) {
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

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
} // import 'package:cristalteacher/core/appdata/appdata.dart';
// import 'package:cristalteacher/features/authentication/domain/entities/class_details_entity.dart';
// import 'package:cristalteacher/features/authentication/domain/parameters/fetch_tutorshipclass_parameter.dart';
// import 'package:cristalteacher/features/authentication/presentation/cubit/authentication_cubit.dart';
// import 'package:cristalteacher/features/diary/domain/entities/diary_entity.dart';
// import 'package:cristalteacher/features/diary/domain/parameters/fetch_diary_parameter.dart';
// import 'package:cristalteacher/features/diary/presentation/cubit/diary_cubit.dart';
// import 'package:cristalteacher/features/diary/presentation/screens/creatediary_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class DiaryTypeScreen extends StatefulWidget {
//   final int branchId;
//   final String userId;

//   const DiaryTypeScreen({super.key, this.branchId = 1, this.userId = '1'});

//   @override
//   State<DiaryTypeScreen> createState() => _DiaryTypeScreenState();
// }

// class _DiaryTypeScreenState extends State<DiaryTypeScreen> {
//   final TextEditingController searchController = TextEditingController();

//   String searchText = '';

//   int selectedStandardId = 1;
//   int selectedDivisionId = 1;
//   int? selectedSubjectId;

//   String? selectedStandard;
//   String? selectedDivision;
//   String? selectedSubject;

//   DateTime? fromDate;
//   DateTime? toDate;

//   @override
//   void initState() {
//     super.initState();

//     final now = DateTime.now();

//     fromDate = DateTime(now.year, now.month, 1);
//     toDate = DateTime(now.year, now.month + 1, 0);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       fetchDiary();
//     });
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   void fetchDiary() {
//     final request = FetchDiaryParameter(
//       branchId: widget.branchId,
//       standardId: selectedStandardId,
//       divisionId: selectedDivisionId,
//       accyear: '2026-2027',
//       fromDate: "2026-06-01",
//       toDate: "2026-07-11",
//       userId: '',
//     );

//     debugPrint('========================================');
//     debugPrint('📘 FETCH DIARY FROM SCREEN');
//     debugPrint('Request: ${request.toJson()}');
//     debugPrint('Selected Subject ID: $selectedSubjectId');
//     debugPrint('========================================');

//     context.read<DiaryCubit>().fetchDiary(request);
//   }

//   String formatApiDate(DateTime? date) {
//     if (date == null) {
//       return '';
//     }

//     final year = date.year.toString();
//     final month = date.month.toString().padLeft(2, '0');
//     final day = date.day.toString().padLeft(2, '0');

//     return '$year-$month-$day';
//   }

//   void applyFilter({
//     int? standardId,
//     String? standard,
//     int? divisionId,
//     String? division,
//     int? subjectId,
//     String? subject,
//     DateTime? fromDate,
//     DateTime? toDate,
//   }) {
//     setState(() {
//       selectedStandardId = standardId ?? 1;
//       selectedDivisionId = divisionId ?? 1;
//       selectedSubjectId = subjectId;

//       selectedStandard = standard;
//       selectedDivision = division;
//       selectedSubject = subject;

//       this.fromDate = fromDate;
//       this.toDate = toDate;
//     });

//     debugPrint('========================================');
//     debugPrint('📘 APPLIED DIARY FILTER');
//     debugPrint('Standard: $selectedStandard');
//     debugPrint('Standard ID: $selectedStandardId');
//     debugPrint('Division: $selectedDivision');
//     debugPrint('Division ID: $selectedDivisionId');
//     debugPrint('Subject: $selectedSubject');
//     debugPrint('Subject ID: $selectedSubjectId');
//     debugPrint('From Date: ${formatApiDate(this.fromDate)}');
//     debugPrint('To Date: ${formatApiDate(this.toDate)}');
//     debugPrint('========================================');

//     fetchDiary();
//   }

//   List<DiaryEntity> filterDiaryList(List<DiaryEntity> diaries) {
//     final query = searchText.trim().toLowerCase();

//     return diaries.where((diary) {
//       final subjectMatches =
//           selectedSubjectId == null ||
//           selectedSubjectId == 0 ||
//           diary.subjectId == selectedSubjectId;

//       if (!subjectMatches) {
//         return false;
//       }

//       if (query.isEmpty) {
//         return true;
//       }

//       final title = removeHtml(diary.diaryTitle).toLowerCase();
//       final description = removeHtml(diary.description).toLowerCase();
//       final standard = diary.standard?.toLowerCase() ?? '';
//       final division = diary.division?.toLowerCase() ?? '';
//       final subject = diary.subjectName?.toLowerCase() ?? '';
//       final diaryType = diary.diaryTypeName?.toLowerCase() ?? '';
//       final employee = diary.employeeName?.toLowerCase() ?? '';

//       return title.contains(query) ||
//           description.contains(query) ||
//           standard.contains(query) ||
//           division.contains(query) ||
//           subject.contains(query) ||
//           diaryType.contains(query) ||
//           employee.contains(query);
//     }).toList();
//   }

//   Map<String, List<DiaryEntity>> groupDiariesByDate(List<DiaryEntity> diaries) {
//     final grouped = <String, List<DiaryEntity>>{};

//     final sortedDiaries = List<DiaryEntity>.from(diaries);

//     sortedDiaries.sort((a, b) {
//       final firstDate = DateTime.tryParse(a.diaryDate ?? '');
//       final secondDate = DateTime.tryParse(b.diaryDate ?? '');

//       if (firstDate == null && secondDate == null) {
//         return 0;
//       }

//       if (firstDate == null) {
//         return 1;
//       }

//       if (secondDate == null) {
//         return -1;
//       }

//       return secondDate.compareTo(firstDate);
//     });

//     for (final diary in sortedDiaries) {
//       final date = diary.diaryDate ?? 'Unknown Date';

//       grouped.putIfAbsent(date, () => []);
//       grouped[date]!.add(diary);
//     }

//     return grouped;
//   }

//   String removeHtml(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return '';
//     }

//     return value
//         .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
//         .replaceAll(RegExp(r'</p>', caseSensitive: false), '\n')
//         .replaceAll(RegExp(r'<[^>]*>'), '')
//         .replaceAll('&nbsp;', ' ')
//         .replaceAll('&amp;', '&')
//         .replaceAll('&lt;', '<')
//         .replaceAll('&gt;', '>')
//         .replaceAll('&quot;', '"')
//         .replaceAll('&#39;', "'")
//         .replaceAll(RegExp(r'\n\s*\n'), '\n')
//         .trim();
//   }

//   String formatDisplayDate(String value) {
//     final date = DateTime.tryParse(value);

//     if (date == null) {
//       return value;
//     }

//     const weekdays = [
//       'Monday',
//       'Tuesday',
//       'Wednesday',
//       'Thursday',
//       'Friday',
//       'Saturday',
//       'Sunday',
//     ];

//     final day = date.day.toString().padLeft(2, '0');
//     final month = date.month.toString().padLeft(2, '0');
//     final year = date.year.toString();

//     return '$day-$month-$year ${weekdays[date.weekday - 1]}';
//   }

//   String formatDueDate(String? value) {
//     if (value == null || value.isEmpty) {
//       return '';
//     }

//     final date = DateTime.tryParse(value);

//     if (date == null) {
//       return value;
//     }

//     final day = date.day.toString().padLeft(2, '0');
//     final month = date.month.toString().padLeft(2, '0');

//     return '$day-$month-${date.year}';
//   }

//   String formatTime(String? value) {
//     if (value == null || value.isEmpty) {
//       return '';
//     }

//     final date = DateTime.tryParse(value);

//     if (date == null) {
//       return '';
//     }

//     int hour = date.hour;

//     final minute = date.minute.toString().padLeft(2, '0');
//     final period = hour >= 12 ? 'PM' : 'AM';

//     if (hour == 0) {
//       hour = 12;
//     } else if (hour > 12) {
//       hour -= 12;
//     }

//     return '$hour:$minute $period';
//   }

//   Future<void> openCreateDiary() async {
//     await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const CreateDiaryScreen()),
//     );

//     if (!mounted) {
//       return;
//     }

//     fetchDiary();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF7F7F7),
//       drawer: DiaryFilterDrawer(
//         accYear: AppData.accYear,
//         employeeId: null,
//         userId: int.tryParse(widget.userId),
//         onApply: applyFilter,
//       ),
//       body: SafeArea(
//         child: Builder(
//           builder: (scaffoldContext) {
//             return Stack(
//               children: [
//                 Column(
//                   children: [
//                     _Header(
//                       onFilterTap: () {
//                         Scaffold.of(scaffoldContext).openDrawer();
//                       },
//                     ),
//                     Expanded(
//                       child: BlocBuilder<DiaryCubit, DiaryState>(
//                         builder: (context, state) {
//                           if (state is DiaryLoading) {
//                             return const Center(
//                               child: CircularProgressIndicator(
//                                 color: Color(0xff9D75E8),
//                               ),
//                             );
//                           }

//                           if (state is DiaryFailure) {
//                             return _DiaryErrorView(
//                               message: state.message,
//                               onRetry: fetchDiary,
//                             );
//                           }

//                           if (state is DiarySuccess) {
//                             final allDiaries = state.response.data ?? [];

//                             final filteredDiaries = filterDiaryList(allDiaries);

//                             final groupedDiaries = groupDiariesByDate(
//                               filteredDiaries,
//                             );

//                             return RefreshIndicator(
//                               color: const Color(0xff9D75E8),
//                               onRefresh: () async {
//                                 fetchDiary();
//                               },
//                               child: ListView(
//                                 physics: const AlwaysScrollableScrollPhysics(),
//                                 padding: const EdgeInsets.fromLTRB(
//                                   22,
//                                   12,
//                                   22,
//                                   100,
//                                 ),
//                                 children: [
//                                   _SearchBox(
//                                     controller: searchController,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         searchText = value;
//                                       });
//                                     },
//                                     onClear: () {
//                                       searchController.clear();

//                                       setState(() {
//                                         searchText = '';
//                                       });
//                                     },
//                                   ),
//                                   const SizedBox(height: 14),
//                                   if (filteredDiaries.isEmpty)
//                                     const SizedBox(
//                                       height: 450,
//                                       child: Center(
//                                         child: Text(
//                                           'No diary entries found',
//                                           style: TextStyle(
//                                             fontSize: 14,
//                                             color: Colors.grey,
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   else
//                                     ...buildDiaryGroups(groupedDiaries),
//                                 ],
//                               ),
//                             );
//                           }

//                           return RefreshIndicator(
//                             color: const Color(0xff9D75E8),
//                             onRefresh: () async {
//                               fetchDiary();
//                             },
//                             child: ListView(
//                               physics: const AlwaysScrollableScrollPhysics(),
//                               children: const [
//                                 SizedBox(height: 300),
//                                 Center(child: Text('No diary data')),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 Positioned(
//                   right: 18,
//                   bottom: 50,
//                   child: GestureDetector(
//                     onTap: openCreateDiary,
//                     child: Container(
//                       width: 56,
//                       height: 56,
//                       decoration: BoxDecoration(
//                         color: const Color(0xff9D75E8),
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.18),
//                             blurRadius: 10,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: const Icon(
//                         Icons.add,
//                         color: Colors.white,
//                         size: 36,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   List<Widget> buildDiaryGroups(Map<String, List<DiaryEntity>> groupedDiaries) {
//     final widgets = <Widget>[];

//     groupedDiaries.forEach((date, diaries) {
//       widgets.add(_DateTitle(date: formatDisplayDate(date)));

//       for (int index = 0; index < diaries.length; index++) {
//         final diary = diaries[index];

//         widgets.add(
//           DynamicDiaryCard(
//             diary: diary,
//             title: removeHtml(diary.diaryTitle),
//             description: removeHtml(diary.description),
//             dueDate: formatDueDate(diary.dueDate),
//             time: formatTime(diary.createdDate),
//           ),
//         );

//         if (index != diaries.length - 1) {
//           widgets.add(const SizedBox(height: 18));
//         }
//       }

//       widgets.add(const SizedBox(height: 20));
//     });

//     return widgets;
//   }
// }

// class _Header extends StatelessWidget {
//   final VoidCallback onFilterTap;

//   const _Header({required this.onFilterTap});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 62,
//       padding: const EdgeInsets.symmetric(horizontal: 22),
//       color: Colors.white,
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: onFilterTap,
//             child: Container(
//               width: 42,
//               height: 42,
//               decoration: const BoxDecoration(
//                 color: Color(0xff9D75E8),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.filter_list_rounded,
//                 color: Colors.white,
//                 size: 25,
//               ),
//             ),
//           ),
//           const Expanded(
//             child: Center(
//               child: Text(
//                 'Diary Type',
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 42),
//         ],
//       ),
//     );
//   }
// }

// class _SearchBox extends StatelessWidget {
//   final TextEditingController controller;
//   final ValueChanged<String> onChanged;
//   final VoidCallback onClear;

//   const _SearchBox({
//     required this.controller,
//     required this.onChanged,
//     required this.onClear,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 48,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: const Color(0xffBDBDBD)),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: TextField(
//         controller: controller,
//         onChanged: onChanged,
//         decoration: InputDecoration(
//           prefixIcon: Padding(
//             padding: const EdgeInsets.all(12),
//             child: SvgPicture.asset(
//               'assets/icons/Group 290.svg',
//               width: 20,
//               height: 20,
//             ),
//           ),
//           hintText: 'Search',
//           hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
//           suffixIcon: controller.text.isEmpty
//               ? null
//               : IconButton(
//                   onPressed: onClear,
//                   icon: const Icon(Icons.close, size: 18),
//                 ),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.only(top: 13),
//         ),
//       ),
//     );
//   }
// }

// class _DateTitle extends StatelessWidget {
//   final String date;

//   const _DateTitle({required this.date});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 12),
//         child: Text(
//           date,
//           style: const TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w600,
//             color: Color(0xff333333),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DynamicDiaryCard extends StatelessWidget {
//   final DiaryEntity diary;
//   final String title;
//   final String description;
//   final String dueDate;
//   final String time;

//   const DynamicDiaryCard({
//     super.key,
//     required this.diary,
//     required this.title,
//     required this.description,
//     required this.dueDate,
//     required this.time,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final colors = _DiaryColors.fromId(diary.diaryId);
//     final files = diary.files ?? [];

//     return ClipRRect(
//       borderRadius: BorderRadius.circular(18),
//       child: Container(
//         decoration: BoxDecoration(
//           color: colors.bodyColor,
//           borderRadius: BorderRadius.circular(18),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               // minHeight: 48,
//               padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//               color: colors.headerColor,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       diary.diaryTypeName?.trim().isNotEmpty == true
//                           ? diary.diaryTypeName!
//                           : 'General',
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w800,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   if (diary.isFavourite == true)
//                     const Padding(
//                       padding: EdgeInsets.only(right: 8),
//                       child: Icon(
//                         Icons.star_rounded,
//                         color: Color(0xffFFB000),
//                         size: 20,
//                       ),
//                     ),
//                   const _SmallActionButton(
//                     iconPath: 'assets/icons/Group (6).svg',
//                   ),
//                   const SizedBox(width: 8),
//                   const _SmallActionButton(
//                     iconPath: 'assets/icons/Group (7).svg',
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   if (title.isNotEmpty)
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xff222222),
//                       ),
//                     ),
//                   if (title.isNotEmpty && description.isNotEmpty)
//                     const SizedBox(height: 8),
//                   if (description.isNotEmpty)
//                     Text(
//                       description,
//                       style: const TextStyle(
//                         fontSize: 12,
//                         height: 1.5,
//                         color: Color(0xff222222),
//                       ),
//                     ),
//                   const SizedBox(height: 12),
//                   Wrap(
//                     spacing: 8,
//                     runSpacing: 8,
//                     children: [
//                       _DiaryInfoChip(
//                         icon: Icons.class_outlined,
//                         text: '${diary.standard ?? ''} ${diary.division ?? ''}'
//                             .trim(),
//                       ),
//                       if (diary.subjectName?.isNotEmpty == true)
//                         _DiaryInfoChip(
//                           icon: Icons.menu_book_outlined,
//                           text: diary.subjectName!,
//                         ),
//                       if (diary.employeeName?.isNotEmpty == true)
//                         _DiaryInfoChip(
//                           icon: Icons.person_outline,
//                           text: diary.employeeName!,
//                         ),
//                     ],
//                   ),
//                   if (dueDate.isNotEmpty) ...[
//                     const SizedBox(height: 12),
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.calendar_month_outlined,
//                           size: 15,
//                           color: Color(0xff6D55A8),
//                         ),
//                         const SizedBox(width: 6),
//                         Text(
//                           'Due Date: $dueDate',
//                           style: const TextStyle(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xff6D55A8),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                   if (files.isNotEmpty) ...[
//                     const SizedBox(height: 14),
//                     ...files.map(
//                       (file) => Padding(
//                         padding: const EdgeInsets.only(bottom: 8),
//                         child: _FileBox(fileUrl: file),
//                       ),
//                     ),
//                   ],
//                   const SizedBox(height: 10),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Text(
//                       time,
//                       style: const TextStyle(
//                         fontSize: 9,
//                         color: Color(0xff777777),
//                       ),
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
// }

// class _DiaryInfoChip extends StatelessWidget {
//   final IconData icon;
//   final String text;

//   const _DiaryInfoChip({required this.icon, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     if (text.trim().isEmpty) {
//       return const SizedBox.shrink();
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.65),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 13, color: const Color(0xff6D55A8)),
//           const SizedBox(width: 5),
//           Text(
//             text,
//             style: const TextStyle(
//               fontSize: 10,
//               fontWeight: FontWeight.w600,
//               color: Color(0xff333333),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _FileBox extends StatelessWidget {
//   final String fileUrl;

//   const _FileBox({required this.fileUrl});

//   String get fileName {
//     final uri = Uri.tryParse(fileUrl);

//     if (uri != null && uri.pathSegments.isNotEmpty) {
//       return uri.pathSegments.last;
//     }

//     return fileUrl;
//   }

//   String get extension {
//     final parts = fileName.split('.');

//     if (parts.length < 2) {
//       return 'FILE';
//     }

//     return parts.last.toUpperCase();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//       decoration: BoxDecoration(
//         color: const Color(0xffFAF7FF),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.black, width: 1),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 38,
//             height: 38,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: const Color(0xffE93C3C),
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: Text(
//               extension,
//               maxLines: 1,
//               style: const TextStyle(
//                 fontSize: 7,
//                 color: Colors.white,
//                 fontWeight: FontWeight.w900,
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               fileName,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
//             ),
//           ),
//           const SizedBox(width: 8),
//           const Icon(
//             Icons.file_download_outlined,
//             size: 26,
//             color: Colors.black,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _SmallActionButton extends StatelessWidget {
//   final String iconPath;

//   const _SmallActionButton({required this.iconPath});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 25,
//       height: 25,
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.75),
//         shape: BoxShape.circle,
//       ),
//       alignment: Alignment.center,
//       child: SvgPicture.asset(iconPath, width: 14, height: 14),
//     );
//   }
// }

// class _DiaryErrorView extends StatelessWidget {
//   final String message;
//   final VoidCallback onRetry;

//   const _DiaryErrorView({required this.message, required this.onRetry});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.error_outline, color: Colors.redAccent, size: 45),
//             const SizedBox(height: 12),
//             Text(
//               message,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 13, color: Colors.redAccent),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: onRetry,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff9D75E8),
//                 foregroundColor: Colors.white,
//               ),
//               child: const Text('Retry'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _DiaryColors {
//   final Color headerColor;
//   final Color bodyColor;

//   const _DiaryColors({required this.headerColor, required this.bodyColor});

//   factory _DiaryColors.fromId(int diaryId) {
//     switch (diaryId % 4) {
//       case 0:
//         return const _DiaryColors(
//           headerColor: Color(0xffFFD978),
//           bodyColor: Color(0xffFFF7E7),
//         );

//       case 1:
//         return const _DiaryColors(
//           headerColor: Color(0xffFFA9DF),
//           bodyColor: Color(0xffFFE7F6),
//         );

//       case 2:
//         return const _DiaryColors(
//           headerColor: Color(0xffB996F5),
//           bodyColor: Color(0xffEADFFF),
//         );

//       default:
//         return const _DiaryColors(
//           headerColor: Color(0xffC9FF83),
//           bodyColor: Color(0xffF0FFD9),
//         );
//     }
//   }
// } // import 'package:cristalteacher/core/appdata/appdata.dart';
// import 'package:cristalteacher/features/authentication/domain/entities/class_details_entity.dart';
// import 'package:cristalteacher/features/authentication/domain/parameters/fetch_tutorshipclass_parameter.dart';
// import 'package:cristalteacher/features/authentication/presentation/cubit/authentication_cubit.dart';
// import 'package:cristalteacher/features/diary/presentation/screens/creatediary_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';

// class DiaryTypeScreen extends StatefulWidget {
//   const DiaryTypeScreen({super.key});

//   @override
//   State<DiaryTypeScreen> createState() => _DiaryTypeScreenState();
// }

// class _DiaryTypeScreenState extends State<DiaryTypeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF7F7F7),
//       drawer: DiaryFilterDrawer(
//         accYear: AppData.accYear,
//         employeeId: null,
//         userId: null,
//       ),
//       body: SafeArea(
//         child: Builder(
//           builder: (context) {
//             return Stack(
//               children: [
//                 Column(
//                   children: [
//                     _Header(
//                       onFilterTap: () {
//                         Scaffold.of(context).openDrawer();
//                       },
//                     ),
//                     Expanded(
//                       child: ListView(
//                         padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
//                         children: const [
//                           _SearchBox(),
//                           SizedBox(height: 14),
//                           _DateTitle(date: "12-10-2026 Monday"),

//                           DiaryCard(
//                             title: "Assignment",
//                             titleIcon: "🔥",
//                             headerColor: Color(0xffFFD978),
//                             bodyColor: Color(0xffFFF7E7),
//                             child: _AssignmentContent(),
//                           ),

//                           SizedBox(height: 18),

//                           DiaryCard(
//                             title: "Announcement",
//                             headerColor: Color(0xffFFA9DF),
//                             bodyColor: Color(0xffFFE7F6),
//                             child: _AudioAnnouncementContent(),
//                           ),

//                           SizedBox(height: 14),
//                           _DateTitle(date: "20-10-2026 Monday"),

//                           DiaryCard(
//                             title: "Announcement",
//                             headerColor: Color(0xffB996F5),
//                             bodyColor: Color(0xffEADFFF),
//                             child: _TextAnnouncementContent(),
//                           ),

//                           SizedBox(height: 18),

//                           DiaryCard(
//                             title: "Announcement",
//                             headerColor: Color(0xffC9FF83),
//                             bodyColor: Color(0xffF0FFD9),
//                             child: _TextAnnouncementContent(),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),

//                 Positioned(
//                   right: 18,
//                   bottom: 50,
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               const CreateDiaryScreen(), // Replace with your screen
//                         ),
//                       );
//                     },
//                     child: Container(
//                       width: 56,
//                       height: 56,
//                       decoration: BoxDecoration(
//                         color: const Color(0xff9D75E8),
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.18),
//                             blurRadius: 10,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: const Icon(
//                         Icons.add,
//                         color: Colors.white,
//                         size: 36,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class _Header extends StatelessWidget {
//   final VoidCallback onFilterTap;

//   const _Header({required this.onFilterTap});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 62,
//       padding: const EdgeInsets.symmetric(horizontal: 22),
//       color: Colors.white,
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: onFilterTap,
//             child: Container(
//               width: 42,
//               height: 42,
//               decoration: const BoxDecoration(
//                 color: Color(0xff9D75E8),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.filter_list_rounded,
//                 color: Colors.white,
//                 size: 25,
//               ),
//             ),
//           ),
//           const Expanded(
//             child: Center(
//               child: Text(
//                 "Diary Type",
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 42),
//         ],
//       ),
//     );
//   }
// }

// class _SearchBox extends StatelessWidget {
//   const _SearchBox();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 48,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: const Color(0xffBDBDBD)),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: TextField(
//         decoration: InputDecoration(
//           prefixIcon: Padding(
//             padding: EdgeInsets.all(12),
//             child: SvgPicture.asset(
//               'assets/icons/Group 290.svg',
//               // width: 20,
//               // height: 20,
//             ),
//           ),
//           label: Text('Search'),
//           //hintText: "Search",
//           hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.only(top: 13),
//         ),
//       ),
//     );
//   }
// }

// class _DateTitle extends StatelessWidget {
//   final String date;

//   const _DateTitle({required this.date});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 12),
//         child: Text(
//           date,
//           style: const TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w600,
//             color: Color(0xff333333),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DiaryCard extends StatelessWidget {
//   final String title;
//   final String? titleIcon;
//   final Color headerColor;
//   final Color bodyColor;
//   final Widget child;

//   const DiaryCard({
//     super.key,
//     required this.title,
//     this.titleIcon,
//     required this.headerColor,
//     required this.bodyColor,
//     required this.child,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(18),
//       child: Container(
//         decoration: BoxDecoration(
//           color: bodyColor,
//           borderRadius: BorderRadius.circular(18),
//         ),
//         child: Column(
//           children: [
//             Container(
//               height: 48,
//               padding: const EdgeInsets.symmetric(horizontal: 18),
//               color: headerColor,
//               child: Row(
//                 children: [
//                   Text(
//                     titleIcon == null ? title : "$title  $titleIcon",
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w800,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const Spacer(),
//                   const _SmallActionButton(
//                     iconPath: 'assets/icons/Group (6).svg',
//                   ),
//                   const SizedBox(width: 8),
//                   const _SmallActionButton(
//                     iconPath: 'assets/icons/Group (7).svg',
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
//               child: child,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SmallActionButton extends StatelessWidget {
//   final String iconPath;

//   const _SmallActionButton({required this.iconPath});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 25,
//       height: 25,
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.75),
//         shape: BoxShape.circle,
//       ),
//       child: Center(child: SvgPicture.asset(iconPath, width: 14, height: 14)),
//     );
//   }
// }

// class _AssignmentContent extends StatelessWidget {
//   const _AssignmentContent();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Complete This Worksheet And Submit\nBefore 15 August 2025",
//           style: TextStyle(fontSize: 12, height: 1.5, color: Color(0xff222222)),
//         ),
//         const SizedBox(height: 18),
//         Container(
//           height: 78,
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           decoration: BoxDecoration(
//             color: const Color(0xffFAF7FF),
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: Colors.black, width: 1.1),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 width: 33,
//                 height: 33,
//                 decoration: BoxDecoration(
//                   color: const Color(0xffE93C3C),
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     "PDF",
//                     style: TextStyle(
//                       fontSize: 8,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w900,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 14),
//               const Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Sequence.Pdf",
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     SizedBox(height: 6),
//                     Text(
//                       "12 Pages",
//                       style: TextStyle(fontSize: 9, color: Colors.black54),
//                     ),
//                   ],
//                 ),
//               ),
//               const Icon(
//                 Icons.file_download_outlined,
//                 size: 26,
//                 color: Colors.black,
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 12),
//         const Align(
//           alignment: Alignment.centerRight,
//           child: Text(
//             "12.10 Pm",
//             style: TextStyle(fontSize: 9, color: Color(0xff777777)),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _AudioAnnouncementContent extends StatelessWidget {
//   const _AudioAnnouncementContent();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Lorem Ipsum Dolor Sit Amet, Consectetur Adipiscing\n"
//           "Elit. Sed Do Eiusmod Tempor Incididunt Ut Labore Et\n"
//           "Dolore Magna",
//           style: TextStyle(fontSize: 12, height: 1.5, color: Color(0xff222222)),
//         ),
//         const SizedBox(height: 16),
//         Container(
//           height: 48,
//           width: 260,
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           decoration: BoxDecoration(
//             color: const Color(0xff202020),
//             borderRadius: BorderRadius.circular(24),
//           ),
//           child: const Row(
//             children: [
//               Icon(Icons.play_arrow, color: Colors.white, size: 22),
//               SizedBox(width: 8),
//               Expanded(child: _WaveForm()),
//               SizedBox(width: 8),
//               Text("0:12", style: TextStyle(fontSize: 8, color: Colors.white)),
//             ],
//           ),
//         ),
//         const SizedBox(height: 8),
//         const Align(
//           alignment: Alignment.centerRight,
//           child: Text(
//             "12.10 Pm",
//             style: TextStyle(fontSize: 9, color: Color(0xff777777)),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _TextAnnouncementContent extends StatelessWidget {
//   const _TextAnnouncementContent();

//   @override
//   Widget build(BuildContext context) {
//     return const Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Lorem Ipsum Dolor Sit Amet, Consectetur Adipiscing\n"
//           "Elit. Sed Do Eiusmod Tempor Incididunt Ut Labore Et\n"
//           "Dolore Magna Aliqua. Ut Enim Ad Minim Veniam,",
//           style: TextStyle(fontSize: 12, height: 1.5, color: Color(0xff222222)),
//         ),
//         SizedBox(height: 8),
//         Align(
//           alignment: Alignment.centerRight,
//           child: Text(
//             "12.10 Pm",
//             style: TextStyle(fontSize: 9, color: Color(0xff777777)),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _WaveForm extends StatelessWidget {
//   const _WaveForm();

//   @override
//   Widget build(BuildContext context) {
//     final List<double> bars = [
//       10,
//       18,
//       13,
//       25,
//       16,
//       28,
//       14,
//       22,
//       30,
//       17,
//       26,
//       12,
//       23,
//       29,
//       15,
//       20,
//       27,
//       18,
//       24,
//       12,
//       30,
//       21,
//       16,
//       25,
//       13,
//       27,
//       19,
//       22,
//       14,
//       28,
//       17,
//       23,
//       15,
//       26,
//       18,
//       20,
//       12,
//       24,
//     ];

//     return SizedBox(
//       height: 34,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: bars.map((height) {
//           return Container(
//             width: 2,
//             height: height,
//             decoration: BoxDecoration(
//               color: const Color(0xff8B72FF),
//               borderRadius: BorderRadius.circular(2),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

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
