import 'package:cristalteacher/core/appdata/appdata.dart';
import 'package:cristalteacher/features/attendance/presentation/screens/attendance_report_screen.dart';
import 'package:cristalteacher/features/authentication/domain/entities/class_details_entity.dart';
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

// TODO: point this at wherever TeacherDashboardResult / Datum / TodayPeriod
// actually live in your project (the model you pasted earlier).

class TeacherDashboardNewPage extends StatefulWidget {
  const TeacherDashboardNewPage({super.key});

  @override
  State<TeacherDashboardNewPage> createState() =>
      _TeacherDashboardNewPageState();
}

class _TeacherDashboardNewPageState extends State<TeacherDashboardNewPage> {
  @override
  void initState() {
    _loadInitialData();
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

    // NOTE: fetchTeacherDashboard needs AppData.accYear, which fetchAccYear()
    // sets asynchronously. Do NOT call fetchTeacherDashboard here — it must
    // fire only after FetchAccYearSuccess arrives (see the listener below),
    // otherwise AppData.accYear! will throw a null-check error.
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

  // Populated once FetchTeacherDashboardSuccess arrives — kept in State so
  // the values survive later bloc state changes (e.g. loading states).
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
            AppData.clearTutorshipData();
            context.read<AuthenticationCubit>().fetchTutorshipClass(
              FetchTutorshipClassRequest(
                accyear: AppData.accYear,
                employeeId: AppData.employeeId,
                userId: AppData.userId,
              ),
            );

            // Fired here — the first point where AppData.accYear and
            // AppData.employeeId are guaranteed to be non-null.
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
          final data = state.response.data;

          AppData.tutorshipClasses = List<TutorshipClass>.from(
            data?.tutorshipClass ?? <TutorshipClass>[],
          );

          AppData.standards = List<TutorshipClass>.from(
            data?.standard ?? <TutorshipClass>[],
          );

          debugPrint('===================================');
          debugPrint('TUTORSHIP DATA SAVED IN APPDATA');
          debugPrint('Employee ID: ${AppData.employeeId}');
          debugPrint('Tutorship classes: ${AppData.tutorshipClasses.length}');
          debugPrint('Standards: ${AppData.standards.length}');
          debugPrint('===================================');
        }

        if (state is FetchTutorshipClassFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }

        // ---- Teacher dashboard result: drives the stats + class cards ----
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
          body: SingleChildScrollView(
            child: Container(
              // ---- Single continuous gradient for the whole page ----
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF3355D8),
                    Color(0xFF1B2A6B),
                    Color(0xFFF4F6FB),
                  ],
                  stops: [0.0, 0.42, 0.78],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
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
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                  // ---- Quick Access ----
                  Padding(
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
                        GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.90,
                          children: const [
                            _QuickAccessItem(
                              icon: Icons.menu_book_rounded,
                              label: 'Diary',
                            ),
                            _QuickAccessItem(
                              icon: Icons.library_books_rounded,
                              label: 'Material',
                            ),
                            _QuickAccessItem(
                              icon: Icons.photo_library_rounded,
                              label: 'Feed',
                            ),
                            _QuickAccessItem(
                              icon: Icons.person_search_rounded,
                              label: 'Attendance',
                            ),
                            _QuickAccessItem(
                              icon: Icons.assignment_rounded,
                              label: 'Exam',
                            ),
                            _QuickAccessItem(
                              icon: Icons.calendar_month_rounded,
                              label: 'Time Table',
                            ),

                            _QuickAccessItem(
                              icon: Icons.calendar_month_rounded,
                              label: 'Gate Pass',
                            ),
                            _QuickAccessItem(
                              icon: Icons.calendar_month_rounded,
                              label: 'Work Plan',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
        const CircleAvatar(
          radius: 26,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage('assets/images/defaultstudent.png'),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppData.teacherName!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('', style: TextStyle(color: Colors.white70, fontSize: 13)),
          ],
        ),
      ],
    );
  }
}

/// Shown in place of the card while the teacher-dashboard request is
/// in flight, so the layout doesn't jump once data arrives.
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

/// One rounded card containing BOTH the white stats section on top and the
/// dark navy schedule section on the bottom, with a single sharp boundary
/// between them (no gap, no blur, no color bleed) and one outer shadow.
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
            // ---- White stats section (top) ----
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
            // ---- Dark navy schedule section (bottom) ----
            Container(
              width: double.infinity,
              color: cardNavy,
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
                color: Color(0xFF1B2A6B),
                size: 16,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Today You Have',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const Spacer(),
            const Text(
              'View Full Schedule',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                decoration: TextDecoration.underline,
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
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: todayPeriods.length,
              separatorBuilder: (_, __) => const _DottedConnector(),
              itemBuilder: (context, index) {
                final p = todayPeriods[index];
                // "class" + "division" combined, e.g. "10" + "A" -> "10 A"
                final classAndDivision = [
                  p.todayPeriodClass,
                  p.division,
                ].where((s) => s.trim().isNotEmpty).join(' ');
                return SizedBox(
                  width: 110,
                  child: _ClassCard(
                    classAndDivision: classAndDivision.isEmpty
                        ? '-'
                        : classAndDivision,
                    subject: p.subject,
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
    return SizedBox(
      width: 14,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          4,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white54,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Time is intentionally skipped — shows only the combined class/division
/// (e.g. "10 A") and the subject.
class _ClassCard extends StatelessWidget {
  final String classAndDivision;
  final String subject;

  const _ClassCard({required this.classAndDivision, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        // Fixed size for every card, regardless of text length — long
        // subject names truncate with an ellipsis instead of overflowing.
        SizedBox(
          width: 110,
          height: 125,

          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  classAndDivision,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
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
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 12),
          ),
        ),
      ],
    );
  }
}

class _QuickAccessItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickAccessItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (label == 'Material') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MaterialsScreen()),
              );
            }
            if (label == 'Feed') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FeedScreen()),
              );
            }
            if (label == 'Diary') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DiaryTypeScreen()),
              );
            }
            if (label == 'Attendance') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AttendanceReportScreen()),
              );
            }
            if (label == 'Exam') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ExamScreen()),
              );
            }
            if (label == 'Time Table') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TimeTableScreen()),
              );
            }
            if (label == 'Gate Pass') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => GatePassScreen()),
              );
            }
            if (label == 'Work Plan') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => WorkplanDetialsScreen()),
              );
            }
          },
          child: Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: const Color(0xFF6C4CE0), size: 26),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.black87),
        ),
      ],
    );
  }
}
