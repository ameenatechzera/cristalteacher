import 'package:cristalteacher/core/appdata/appdata.dart';
import 'package:cristalteacher/features/timetable/domain/entities/teacher_timetable_entity.dart';
import 'package:cristalteacher/features/timetable/domain/parameters/fetch_teacher_timetable_parameter.dart';
import 'package:cristalteacher/features/timetable/presentation/cubit/timetable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({super.key});

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  static const Color primaryColor = Color(0xFF5842E3);
  static const Color backgroundColor = Color(0xFFFAF8FF);

  final List<TeacherTimetableData> timetable = [];

  late DateTime displayedMonth;
  late DateTime weekStartDate;

  int selectedDayIndex = 0;

  final List<String> dayNames = const [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  final List<String> shortDayNames = const ['M', 'Tu', 'W', 'Th', 'F', 'S'];

  final Map<int, String> periodTimes = const {
    1: '09:00 AM',
    2: '10:00 AM',
    3: '11:00 AM',
    4: '12:00 PM',
    5: '01:30 PM',
    6: '02:30 PM',
    7: '03:30 PM',
  };

  final List<Color> periodColors = const [
    Color(0xFF63D795),
    Color(0xFF5672FF),
    Color(0xFFFFA142),
    Color(0xFF8B5CF6),
    Color(0xFFFF6680),
    Color(0xFF15B8A6),
    Color(0xFFEC4899),
  ];

  @override
  void initState() {
    super.initState();

    final today = DateTime.now();

    displayedMonth = DateTime(today.year, today.month, 1);

    weekStartDate = today.subtract(
      Duration(days: today.weekday - DateTime.monday),
    );

    if (today.weekday >= DateTime.monday &&
        today.weekday <= DateTime.saturday) {
      selectedDayIndex = today.weekday - 1;
    } else {
      selectedDayIndex = 0;
    }

    debugPrint('');
    debugPrint('==============================================');
    debugPrint('📅 TIMETABLE SCREEN INIT');
    debugPrint('==============================================');
    debugPrint('Current Date       : $today');
    debugPrint('Displayed Month    : $displayedMonth');
    debugPrint('Week Start Date    : $weekStartDate');
    debugPrint('Selected Day Index : $selectedDayIndex');
    debugPrint('Selected Day       : ${dayNames[selectedDayIndex]}');
    debugPrint('Employee ID        : ${AppData.employeeId}');
    debugPrint('Academic Year      : ${AppData.accYear}');
    debugPrint('Branch ID Sent     : 1');
    debugPrint('==============================================');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      debugPrint('');
      debugPrint('==============================================');
      debugPrint('📅 FETCH TEACHER TIMETABLE');
      debugPrint('==============================================');

      if (AppData.employeeId == null) {
        debugPrint('❌ Employee ID is null');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Employee ID is unavailable')),
        );

        return;
      }

      if (AppData.accYear == null || AppData.accYear!.isEmpty) {
        debugPrint('❌ Academic year is null or empty');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Academic year is unavailable')),
        );

        return;
      }

      final request = FetchTeacherTimetableParameter(
        employeeId: AppData.employeeId.toString(),
        accYear: AppData.accYear!,
        branchId: AppData.branchId ?? 1,
      );

      debugPrint('Request: ${request.toJson()}');
      debugPrint('employeeId: ${request.employeeId}');
      debugPrint('accYear: ${request.accYear}');
      debugPrint('branchId: ${request.branchId}');
      debugPrint('==============================================');

      context.read<TimetableCubit>().fetchTeacherTimetable(request);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimetableCubit, TimetableState>(
      listener: (context, state) {
        debugPrint('');
        debugPrint('==============================================');
        debugPrint('📡 TIMETABLE CUBIT STATE');
        debugPrint('State: ${state.runtimeType}');
        debugPrint('==============================================');

        if (state is FetchTeacherTimetableLoading) {
          debugPrint('⏳ FetchTeacherTimetableLoading');
        }

        if (state is FetchTeacherTimetableSuccess) {
          final data = state.response.data ?? [];

          debugPrint('✅ FetchTeacherTimetableSuccess');
          debugPrint('Status     : ${state.response.status}');
          debugPrint('Error      : ${state.response.error}');
          debugPrint('Message    : ${state.response.message}');
          debugPrint('Data Count : ${data.length}');

          for (int index = 0; index < data.length; index++) {
            final item = data[index];

            debugPrint('');
            debugPrint('----------------------------------------------');
            debugPrint('TIMETABLE ITEM ${index + 1}');
            debugPrint('----------------------------------------------');
            debugPrint('Day Name      : ${item.dayName}');
            debugPrint('Period Number : ${item.periodNo}');
            debugPrint('Standard ID   : ${item.standardId}');
            debugPrint('Standard Name : ${item.standardName}');
            debugPrint('Division ID   : ${item.divisionId}');
            debugPrint('Division Name : ${item.divisionName}');
            debugPrint('Subject ID    : ${item.subjectId}');
            debugPrint('Subject Name  : ${item.subjectName}');
            debugPrint('Employee ID   : ${item.employeeId}');
            debugPrint('Employee Name : ${item.employeeName}');
          }

          if (!mounted) return;

          setState(() {
            timetable
              ..clear()
              ..addAll(data);
          });

          debugPrint('');
          debugPrint('✅ UI Timetable Count: ${timetable.length}');
          debugPrint('==============================================');
        }

        if (state is FetchTeacherTimetableFailure) {
          debugPrint('❌ FetchTeacherTimetableFailure');
          debugPrint('Message: ${state.message}');
          debugPrint('==============================================');

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                behavior: SnackBarBehavior.floating,
              ),
            );
        }
      },
      builder: (context, state) {
        final isLoading = state is FetchTeacherTimetableLoading;

        final selectedDayName = dayNames[selectedDayIndex].toLowerCase();

        final Map<String, TeacherTimetableData> uniqueClasses = {};

        for (final item in timetable) {
          final apiDayName = item.dayName?.trim().toLowerCase() ?? '';

          if (apiDayName != selectedDayName) {
            continue;
          }

          final uniqueKey =
              '${item.periodNo}-'
              '${item.standardId}-'
              '${item.divisionId}-'
              '${item.subjectId}';

          uniqueClasses[uniqueKey] = item;
        }

        final selectedDayClasses = uniqueClasses.values.toList();

        selectedDayClasses.sort((first, second) {
          final firstPeriod = int.tryParse(first.periodNo ?? '') ?? 0;

          final secondPeriod = int.tryParse(second.periodNo ?? '') ?? 0;

          return firstPeriod.compareTo(secondPeriod);
        });

        final weekDates = List<DateTime>.generate(
          6,
          (index) => weekStartDate.add(Duration(days: index)),
        );

        const monthNames = [
          'JAN',
          'FEB',
          'MAR',
          'APR',
          'MAY',
          'JUN',
          'JUL',
          'AUG',
          'SEP',
          'OCT',
          'NOV',
          'DEC',
        ];

        return Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.maybePop(context),
                        padding: const EdgeInsets.all(12),
                        icon: const Icon(Icons.arrow_back, size: 24),
                      ),
                      const Expanded(
                        child: Text(
                          'Time Table',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            displayedMonth = DateTime(
                              displayedMonth.year,
                              displayedMonth.month - 1,
                              1,
                            );

                            weekStartDate = displayedMonth.subtract(
                              Duration(
                                days: displayedMonth.weekday - DateTime.monday,
                              ),
                            );

                            selectedDayIndex = 0;
                          });

                          debugPrint('');
                          debugPrint(
                            '==============================================',
                          );
                          debugPrint('📅 PREVIOUS MONTH SELECTED');
                          debugPrint(
                            '==============================================',
                          );
                          debugPrint('Displayed Month: $displayedMonth');
                          debugPrint('Week Start Date: $weekStartDate');
                          debugPrint(
                            'Selected Day: ${dayNames[selectedDayIndex]}',
                          );
                          debugPrint(
                            '==============================================',
                          );
                        },
                        icon: const Icon(Icons.chevron_left, size: 26),
                      ),
                      Text(
                        '${monthNames[displayedMonth.month - 1]} '
                        '${displayedMonth.year}',
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            displayedMonth = DateTime(
                              displayedMonth.year,
                              displayedMonth.month + 1,
                              1,
                            );

                            weekStartDate = displayedMonth.subtract(
                              Duration(
                                days: displayedMonth.weekday - DateTime.monday,
                              ),
                            );

                            selectedDayIndex = 0;
                          });

                          debugPrint('');
                          debugPrint(
                            '==============================================',
                          );
                          debugPrint('📅 NEXT MONTH SELECTED');
                          debugPrint(
                            '==============================================',
                          );
                          debugPrint('Displayed Month: $displayedMonth');
                          debugPrint('Week Start Date: $weekStartDate');
                          debugPrint(
                            'Selected Day: ${dayNames[selectedDayIndex]}',
                          );
                          debugPrint(
                            '==============================================',
                          );
                        },
                        icon: const Icon(Icons.chevron_right, size: 26),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 78,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(23),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x285842E3),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: List.generate(weekDates.length, (index) {
                      final isSelected = index == selectedDayIndex;

                      return Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: () {
                            setState(() {
                              selectedDayIndex = index;
                            });

                            final selectedApiClasses = timetable.where((item) {
                              return item.dayName?.trim().toLowerCase() ==
                                  dayNames[index].toLowerCase();
                            }).toList();

                            debugPrint('');
                            debugPrint(
                              '==============================================',
                            );
                            debugPrint('📅 TIMETABLE DAY SELECTED');
                            debugPrint(
                              '==============================================',
                            );
                            debugPrint('Index: $index');
                            debugPrint('Day: ${dayNames[index]}');
                            debugPrint('Date: ${weekDates[index]}');
                            debugPrint(
                              'Classes Found: '
                              '${selectedApiClasses.length}',
                            );

                            for (final item in selectedApiClasses) {
                              debugPrint(
                                'Period ${item.periodNo} | '
                                '${item.subjectName} | '
                                '${item.standardName} '
                                '${item.divisionName}',
                              );
                            }

                            debugPrint(
                              '==============================================',
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  dayNames[index] == 'Tuesday'
                                      ? 'Tu'
                                      : dayNames[index] == 'Thursday'
                                      ? 'Th'
                                      : dayNames[index][0],
                                  style: TextStyle(
                                    color: isSelected
                                        ? primaryColor
                                        : Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  weekDates[index].day.toString(),
                                  style: TextStyle(
                                    color: isSelected
                                        ? primaryColor
                                        : Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Expanded(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        )
                      : RefreshIndicator(
                          color: primaryColor,
                          onRefresh: () async {
                            debugPrint('');
                            debugPrint(
                              '==============================================',
                            );
                            debugPrint('🔄 REFRESH TIMETABLE');
                            debugPrint(
                              '==============================================',
                            );

                            if (AppData.employeeId == null) {
                              debugPrint('❌ Employee ID is null');

                              return;
                            }

                            if (AppData.accYear == null ||
                                AppData.accYear!.isEmpty) {
                              debugPrint('❌ Academic year is unavailable');

                              return;
                            }

                            final request = FetchTeacherTimetableParameter(
                              employeeId: AppData.employeeId.toString(),
                              accYear: AppData.accYear!,
                              branchId: 1,
                            );

                            debugPrint('Refresh Request: ${request.toJson()}');

                            context
                                .read<TimetableCubit>()
                                .fetchTeacherTimetable(request);
                          },
                          child: selectedDayClasses.isEmpty
                              ? ListView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  padding: const EdgeInsets.only(top: 160),
                                  children: const [
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      size: 48,
                                      color: Color(0xFFB8B2C2),
                                    ),
                                    SizedBox(height: 12),
                                    Center(
                                      child: Text(
                                        'No classes for this day',
                                        style: TextStyle(
                                          color: Color(0xFF77717D),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : SingleChildScrollView(
                                  physics: const AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics(),
                                  ),
                                  padding: const EdgeInsets.fromLTRB(
                                    18,
                                    26,
                                    18,
                                    28,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /*
                                      const Text(
                                        'Next Class',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                              FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 13),

                                      // Next Class section is
                                      // intentionally commented.

                                      const SizedBox(height: 28),
                                      */
                                      const Text(
                                        'Upcoming Classes',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Column(
                                        children: List.generate(selectedDayClasses.length, (
                                          index,
                                        ) {
                                          final item =
                                              selectedDayClasses[index];

                                          final period =
                                              int.tryParse(
                                                item.periodNo ?? '',
                                              ) ??
                                              0;

                                          final color = period > 0
                                              ? periodColors[(period - 1) %
                                                    periodColors.length]
                                              : primaryColor;

                                          final time =
                                              periodTimes[period] ??
                                              'Period $period';

                                          final isLastItem =
                                              index ==
                                              selectedDayClasses.length - 1;

                                          return IntrinsicHeight(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                SizedBox(
                                                  width: 74,
                                                  child: Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Positioned(
                                                        top: 14,
                                                        left: 0,
                                                        child: Text(
                                                          time,
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 9,
                                                                color: Color(
                                                                  0xFFAAA6AE,
                                                                ),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 59,
                                                        top: 18,
                                                        bottom: isLastItem
                                                            ? 18
                                                            : -10,
                                                        child: Container(
                                                          width: 2,
                                                          color: color
                                                              .withOpacity(
                                                                0.65,
                                                              ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 55,
                                                        top: 14,
                                                        child: Container(
                                                          width: 10,
                                                          height: 10,
                                                          decoration:
                                                              BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                shape: BoxShape
                                                                    .circle,
                                                                border:
                                                                    Border.all(
                                                                      color:
                                                                          color,
                                                                      width: 2,
                                                                    ),
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          bottom: 18,
                                                        ),
                                                    child: Container(
                                                      height: 88,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              11,
                                                            ),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Color(
                                                              0x16000000,
                                                            ),
                                                            blurRadius: 13,
                                                            offset: Offset(
                                                              0,
                                                              4,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 4,
                                                            decoration: BoxDecoration(
                                                              color: color,
                                                              borderRadius:
                                                                  const BorderRadius.horizontal(
                                                                    left:
                                                                        Radius.circular(
                                                                          11,
                                                                        ),
                                                                  ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        11,
                                                                  ),
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    width: 52,
                                                                    height: 60,
                                                                    decoration: BoxDecoration(
                                                                      color: color
                                                                          .withOpacity(
                                                                            0.10,
                                                                          ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            8,
                                                                          ),
                                                                    ),
                                                                    child: Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'Per',
                                                                          style: TextStyle(
                                                                            color:
                                                                                color,
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              4,
                                                                        ),
                                                                        Text(
                                                                          item.periodNo ??
                                                                              '-',
                                                                          style: TextStyle(
                                                                            color:
                                                                                color,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 17,
                                                                  ),
                                                                  Expanded(
                                                                    child: Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          item.subjectName ??
                                                                              'Subject',
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: const TextStyle(
                                                                            color: Color(
                                                                              0xFF5F5A64,
                                                                            ),
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              9,
                                                                        ),
                                                                        Text(
                                                                          '${item.standardName ?? ''} ${item.divisionName ?? ''}',
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: const TextStyle(
                                                                            color: Color(
                                                                              0xFF5138ED,
                                                                            ),
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
