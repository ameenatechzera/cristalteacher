import 'package:cristalteacher/core/appdata/appdata.dart';
import 'package:cristalteacher/core/functions/functions.dart';
import 'package:cristalteacher/features/attendance/presentation/screens/attendance_report_screen.dart';
import 'package:cristalteacher/features/authentication/domain/entities/teacher_dashboard_result.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/fetch_teacherdashboard_request.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/fetch_tutorshipclass_parameter.dart';
import 'package:cristalteacher/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:cristalteacher/features/diary/presentation/screens/diary_screen.dart';
import 'package:cristalteacher/features/earlygoing/presentation/screens/gatepass_screen.dart';
import 'package:cristalteacher/features/exams/presentation/screens/exam_screen.dart';
import 'package:cristalteacher/features/feed/presentation/screens/feed_screen.dart';
import 'package:cristalteacher/features/materials/presentation/screens/materials_screen.dart';
import 'package:cristalteacher/features/timetable/presentation/screens/timetable_screen.dart';
import 'package:cristalteacher/features/workplan/presentation/screens/workplan_detials_screen.dart';
import 'package:cristalteacher/services/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TeacherDashboardNewPage extends StatefulWidget {
  const TeacherDashboardNewPage({super.key});

  @override
  State<TeacherDashboardNewPage> createState() =>
      _TeacherDashboardNewPageState();
}

class _TeacherDashboardNewPageState extends State<TeacherDashboardNewPage> {
  @override
  void initState() {
    AppData.teacherSubject = '';
    _loadInitialData();
    DailyTaskRunner.runOncePerDay(() async {
      print('Running once per day!');
      if (!mounted) return;
      context.read<AuthenticationCubit>().fetchTeacherDashboard(
        TeacherDashboardRequest(
          accYear: AppData.accYear!,
          employeeId: AppData.employeeId!,
          branchId: 1,
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teacher Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto', useMaterial3: true),
      home: const TeacherDashboardScreen(),
    );
  }

  Future<void> _loadInitialData() async {
    final pref = SharedPreferenceHelper();

    final login = await pref.getLoginResponse();

    if (login == null) return;

    AppData.employeeId = login.data?.user?.employeeId;
    AppData.userId = login.data?.user?.id;
    AppData.teacherName = login.data?.user!.name;

    context.read<AuthenticationCubit>().fetchAccYear();
  }
}

class TeacherDashboardScreen extends StatefulWidget {
  const TeacherDashboardScreen({super.key});

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  static const Color deepBlue = Color(0xFF1B2A6B);
  static const Color accentPurple = Color(0xFF6C4CE0);
  static const Color cardNavy = Color(0xFF25336E);

  String _classInCharge = '';
  String _divisionInCharge = '';
  int _studentCount = 0;
  String _staffCode = '';
  List<TodayPeriod> _todayPeriods = [];
  bool _dashboardLoading = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is FetchAccYearSuccess) {
          final academicYears = state.response.data ?? [];

          String? activeAccYear;

          for (final year in academicYears) {
            if (year.status == true) {
              activeAccYear = year.accYear;
              break;
            }
          }

          if (activeAccYear == null && academicYears.isNotEmpty) {
            activeAccYear = academicYears.first.accYear;
          }

          if (activeAccYear != null) {
            AppData.accYear = activeAccYear;

            debugPrint("Academic Year : ${AppData.accYear}");

            context.read<AuthenticationCubit>().fetchTutorshipClass(
              FetchTutorshipClassRequest(
                accyear: AppData.accYear,
                employeeId: AppData.employeeId,
                userId: AppData.userId,
              ),
            );

            context.read<AuthenticationCubit>().fetchTeacherDashboard(
              TeacherDashboardRequest(
                accYear: AppData.accYear!,
                employeeId: AppData.employeeId!,
                branchId: 1,
              ),
            );
          }
        }

        if (state is FetchAccYearFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }

        if (state is FetchTutorshipClassSuccess) {
          debugPrint("Tutorship Class Loaded");
        }

        if (state is FetchTutorshipClassFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }

        if (state is FetchDashboardSuccess) {
          final TeacherDashboardResult result = state.response;
          final list = result.data;
          if (list.isNotEmpty) {
            final datum = list.first;
            setState(() {
              _classInCharge = datum.classInCharge;
              _divisionInCharge = datum.divisionInCharge;
              _studentCount = datum.studentCountInCharge;
              _staffCode = datum.employeeCode;
              _todayPeriods = datum.todayPeriods;
              _dashboardLoading = false;
              AppData.teacherSubject = datum.classChargeSubjects;
            });
          } else {
            setState(() => _dashboardLoading = false);
          }
          debugPrint("Teacher Dashboard Loaded");
        }

        if (state is FetchDashboardFailure) {
          setState(() => _dashboardLoading = false);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF4F6FB),
          // 👇 Column instead of SingleChildScrollView — page itself
          // no longer scrolls as a whole. Only Quick Access (below) scrolls.
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ---- Fixed header + stats card (gradient section) ----
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF004BBC),
                      Color(0xFF9BB9E5),
                      Color(0xFFF4F6FB),
                    ],
                    stops: [0.0, 0.42, 0.78],
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        _ProfileRow(),
                        const SizedBox(height: 20),
                        _dashboardLoading
                            ? const _CardLoadingSkeleton()
                            : _CombinedCard(
                          accentPurple: accentPurple,
                          cardNavy: cardNavy,
                          classAndDivision: _classInCharge.isEmpty
                              ? '-'
                              : '$_classInCharge $_divisionInCharge',
                          studentCount: _studentCount,
                          staffCode: _staffCode.isEmpty
                              ? '-'
                              : _staffCode,
                          todayPeriods: _todayPeriods,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ---- Quick Access section — the ONLY scrollable part ----
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quick Access',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 3,
                          physics: const ClampingScrollPhysics(), // 👈 scrollable
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.98,
                          children: const [
                            _QuickAccessItem(
                              imagePath: 'assets/images/diary.png',
                              label: 'Diary',
                            ),
                            _QuickAccessItem(
                              imagePath: 'assets/images/material.png',
                              label: 'Material',
                            ),
                            _QuickAccessItem(
                              imagePath: 'assets/images/feed.png',
                              label: 'Feed',
                            ),
                            _QuickAccessItem(
                              imagePath: 'assets/images/attendance.png',
                              label: 'Attendance',
                            ),
                            _QuickAccessItem(
                              imagePath: 'assets/images/exam.png',
                              label: 'Exam',
                            ),
                            _QuickAccessItem(
                              imagePath: 'assets/images/timetable.png',
                              label: 'Time Table',
                            ),
                            _QuickAccessItem(
                              imagePath: 'assets/images/gatepass.png',
                              label: 'Gate Pass',
                            ),
                            _QuickAccessItem(
                              imagePath: 'assets/images/workplan.png',
                              label: 'Work Plan',
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
        );
      },
    );
  }
}

class _ProfileRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/defaultstudent.png'),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppData.teacherName!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              AppData.teacherSubject!,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }
}

class _CardLoadingSkeleton extends StatelessWidget {
  const _CardLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(color: Colors.white),
    );
  }
}

class _CombinedCard extends StatelessWidget {
  final Color accentPurple;
  final Color cardNavy;
  final String classAndDivision;
  final int studentCount;
  final String staffCode;
  final List<TodayPeriod> todayPeriods;

  const _CombinedCard({
    required this.accentPurple,
    required this.cardNavy,
    required this.classAndDivision,
    required this.studentCount,
    required this.staffCode,
    required this.todayPeriods,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _StatItem(
                    icon: Icons.apartment_rounded,
                    label: 'Class & Division',
                    value: classAndDivision,
                    accentPurple: accentPurple,
                  ),
                  _VerticalDivider(),
                  _StatItem(
                    icon: Icons.groups_rounded,
                    label: 'Students',
                    value: '$studentCount',
                    accentPurple: accentPurple,
                  ),
                  _VerticalDivider(),
                  _StatItem(
                    icon: Icons.badge_rounded,
                    label: 'Staff Code',
                    value: staffCode,
                    accentPurple: accentPurple,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: const Color(0xFF004BBC),
              padding: const EdgeInsets.all(18),
              child: _ScheduleContent(todayPeriods: todayPeriods),
            ),
          ],
        ),
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 60, width: 1, color: Colors.grey.shade200);
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color accentPurple;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.accentPurple,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: accentPurple,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B2A6B),
          ),
        ),
      ],
    );
  }
}

class _ScheduleContent extends StatelessWidget {
  final List<TodayPeriod> todayPeriods;

  const _ScheduleContent({required this.todayPeriods});

  static const double _rowHeight = 130;
  static const double _cardHeight = 118;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.calendar_today_rounded,
                color: Color(0xFF004BBC),
                size: 16,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Today You Have',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TimeTableScreen()),
                );
              },
              child: const Text(
                'View Full Schedule',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 34),
          child: Text(
            '${todayPeriods.length} Classes',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        if (todayPeriods.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'No classes scheduled today',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
          )
        else
          SizedBox(
            height: _rowHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: todayPeriods.length,
              separatorBuilder: (_, __) => const SizedBox(
                width: 27,
                height: _rowHeight,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: _cardHeight,
                    child: _DottedConnector(),
                  ),
                ),
              ),
              itemBuilder: (context, index) {
                final p = todayPeriods[index];
                final classAndDivision = [
                  p.todayPeriodClass,
                  p.division,
                ].where((s) => s.trim().isNotEmpty).join(' ');
                return Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: 90,
                    height: _cardHeight,
                    child: _ClassCard(
                      time: '',
                      classAndDivision: classAndDivision.isEmpty
                          ? '-'
                          : classAndDivision,
                      subject: p.subject,
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _DottedConnector extends StatelessWidget {
  const _DottedConnector();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          bottom: 52,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              3,
                  (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ClassCard extends StatelessWidget {
  final String time;
  final String classAndDivision;
  final String subject;

  const _ClassCard({
    required this.time,
    required this.classAndDivision,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: 90,
          height: 118,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.14),
                  Colors.white.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white38, width: 1.2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  time,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  classAndDivision,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subject,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: -10,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF25336E), width: 2),
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 14),
            ),
          ),
        ),
      ],
    );
  }
}

class _QuickAccessItem extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final String label;

  const _QuickAccessItem({this.icon, this.imagePath, required this.label})
      : assert(
  icon != null || imagePath != null,
  'Provide either an icon or an imagePath',
  );

  Future<void> _runDailyDashboardRefresh(BuildContext context) async {
    if (!context.mounted) return;
    await DailyTaskRunner.runOncePerDay(() async {
      print('Running once per day!');
      if (!context.mounted) return;
      context.read<AuthenticationCubit>().fetchTeacherDashboard(
        TeacherDashboardRequest(
          accYear: AppData.accYear!,
          employeeId: AppData.employeeId!,
          branchId: 1,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            if (label == 'Material') {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MaterialsScreen()),
              );
              await _runDailyDashboardRefresh(context);
            }
            if (label == 'Feed') {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FeedScreen()),
              );
              await _runDailyDashboardRefresh(context);
            }
            if (label == 'Diary') {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DiaryTypeScreen()),
              );
              await _runDailyDashboardRefresh(context);
            }
            if (label == 'Attendance') {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AttendanceReportScreen()),
              );
              await _runDailyDashboardRefresh(context);
            }
            if (label == 'Exam') {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ExamScreen()),
              );
              await _runDailyDashboardRefresh(context);
            }
            if (label == 'Time Table') {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TimeTableScreen()),
              );
              await _runDailyDashboardRefresh(context);
            }
            if (label == 'Gate Pass') {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => GatePassScreen()),
              );
              await _runDailyDashboardRefresh(context);
            }
            if (label == 'Work Plan') {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => WorkplanDetialsScreen()),
              );
              await _runDailyDashboardRefresh(context);
            }
          },
          child: Container(
            height: 76,
            width: 76,
            child: imagePath != null
                ? Padding(
              padding: const EdgeInsets.only(left: 4, right: 8),
              child: Image.asset(imagePath!, fit: BoxFit.contain),
            )
                : Icon(icon, color: const Color(0xFF6C4CE0), size: 26),
          ),
        ),
        const SizedBox(height: 0),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.black87),
        ),
      ],
    );
  }
}