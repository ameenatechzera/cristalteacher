import 'package:cristalteacher/core/appdata/appdata.dart';
import 'package:cristalteacher/features/attendance/presentation/screens/attendance_report_screen.dart';
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

class TeacherDashboardPage extends StatefulWidget {
  const TeacherDashboardPage({super.key});

  @override
  State<TeacherDashboardPage> createState() => _TeacherDashboardPageState();
}

class _TeacherDashboardPageState extends State<TeacherDashboardPage> {
  final List<DashboardItem> dashboardItems = [
    DashboardItem(
      title: "Class Diary",
      subtitle: "Add daily notes",
      icon: Icons.menu_book_rounded,
      color: const Color(0xFFFFF3C4),
      page: DiaryTypeScreen(),
      // page: DiaryTypeScreen(branchId: AppData.branchId ?? 1, userId: '1'),
    ),
    DashboardItem(
      title: "Materials",
      subtitle: "Upload files",
      icon: Icons.folder_copy_rounded,
      color: const Color(0xFFDDF5C9),
      page: MaterialsScreen(),
      // page: const SubjectPage(), // Use this if your material page is SubjectPage
    ),
    DashboardItem(
      title: "Feed",
      subtitle: "Add Feeds",
      icon: Icons.folder_copy_rounded,
      color: const Color(0xFFDDF5C9),
      page: FeedScreen(),
      // page: const SubjectPage(), // Use this if your material page is SubjectPage
    ),
    DashboardItem(
      title: "Attendance",
      subtitle: "Add Attendance",
      icon: Icons.folder_copy_rounded,
      color: const Color(0xFFDDF5C9),
      page: AttendanceReportScreen(),
      // page: const SubjectPage(), // Use this if your material page is SubjectPage
    ),
    DashboardItem(
      title: "Exam",
      subtitle: "Exam Details",
      icon: Icons.folder_copy_rounded,
      color: const Color(0xFFDDF5C9),
      page: ExamScreen(),
      // page: const SubjectPage(), // Use this if your material page is SubjectPage
    ),
    DashboardItem(
      title: "TimeTable",
      subtitle: "Timetable",
      icon: Icons.folder_copy_rounded,
      color: const Color(0xFFDDF5C9),
      page: TimeTableScreen(),
      // page: const SubjectPage(), // Use this if your material page is SubjectPage
    ),
    DashboardItem(
      title: "GatePass",
      subtitle: "GatePass",
      icon: Icons.folder_copy_rounded,
      color: const Color(0xFFDDF5C9),
      page: GatePassScreen(),
      // page: const SubjectPage(), // Use this if your material page is SubjectPage
    ),
    DashboardItem(
      title: "WorkPlan",
      subtitle: "WorkPlan",
      icon: Icons.folder_copy_rounded,
      color: const Color(0xFFDDF5C9),
      page: WorkplanDetialsScreen(),
      // page: const SubjectPage(), // Use this if your material page is SubjectPage
    ),
  ];

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  void initState() {
    super.initState();

    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final pref = SharedPreferenceHelper();

    final login = await pref.getLoginResponse();

    if (login == null) return;

    AppData.employeeId = login.data?.user?.employeeId;
    AppData.userId = login.data?.user?.id;

    context.read<AuthenticationCubit>().fetchAccYear();
  }

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
      },
      builder: (context, state) {
        final bool loading =
            state is FetchAccYearLoading || state is FetchTutorshipClassLoading;
        return Stack(
          children: [
            Scaffold(
              backgroundColor: const Color(0xFFF3F2F7),
              body: SafeArea(
                child: Column(
                  children: [
                    _buildTeacherHeader(context),
                    const SizedBox(height: 18),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.fromLTRB(
                          16, // left
                          0, // top
                          16, // right
                          40, // bottom space
                        ),
                        // padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: dashboardItems.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 1.05,
                            ),
                        itemBuilder: (context, index) {
                          final item = dashboardItems[index];

                          return DashboardCard(
                            item: item,
                            onTap: () {
                              _navigateToPage(context, item.page);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (loading)
              Container(
                color: Colors.black26,
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        );
      },
    );
  }

  Widget _buildTeacherHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      decoration: const BoxDecoration(
        color: Color(0xFF6C4BCB),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.school_rounded,
              color: Color(0xFF6C4BCB),
              size: 30,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome, Teacher",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Manage your classes and students",
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final DashboardItem item;
  final VoidCallback onTap;

  const DashboardCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black.withOpacity(0.04)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.045),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: item.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(item.icon, color: const Color(0xFF252525), size: 26),
            ),
            const Spacer(),
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              item.subtitle,
              style: const TextStyle(fontSize: 11, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Widget page;

  DashboardItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.page,
  });
}
