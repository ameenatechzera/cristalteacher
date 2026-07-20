import 'package:cristalteacher/core/appdata/appdata.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/login_parameter.dart';
import 'package:cristalteacher/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:cristalteacher/features/diary/presentation/screens/dashboard_screen.dart';
import 'package:cristalteacher/services/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController admissionController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  @override
  void dispose() {
    admissionController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) async {
        if (state is AuthenticationSuccess) {
          final pref = SharedPreferenceHelper();

          final loginResponse = state.loginEntity;
          final loginData = loginResponse.data;
          final user = loginData?.user;

          final String token = loginData?.token ?? '';

          if (token.isEmpty) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Token not found')));
            return;
          }

          await pref.setToken(token);
          await pref.saveLoginResponse(loginResponse);

          AppData.employeeId = user?.employeeId;
          AppData.userId = user?.id;

          debugPrint('===================================');
          debugPrint('APP DATA SAVED');
          debugPrint('Academic Year: ${AppData.accYear}');
          debugPrint('Employee ID: ${AppData.employeeId}');
          debugPrint('User ID: ${AppData.userId}');
          debugPrint('===================================');

          if (!context.mounted) {
            return;
          }

          // context.read<AuthenticationCubit>().fetchTutorshipClass(
          //   FetchTutorshipClassRequest(
          //     accyear: AppData.accYear,
          //     employeeId: AppData.employeeId,
          //     userId: AppData.userId,
          //   ),
          // );
          /// Call academic-year API
          // context.read<AuthenticationCubit>().fetchAccYear();

          // return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => TeacherDashboardPage()),
          );
        }

        // /// ACADEMIC YEAR SUCCESS
        // if (state is FetchAccYearSuccess) {
        //   final academicYears = state.response.data ?? [];

        //   debugPrint('===================================');
        //   debugPrint('ACADEMIC YEAR RESPONSE');
        //   debugPrint('Count: ${academicYears.length}');
        //   debugPrint('===================================');

        //   String? activeAccYear;

        //   for (final academicYear in academicYears) {
        //     debugPrint(
        //       'Academic Year: ${academicYear.accYear}, '
        //       'Status: ${academicYear.status}',
        //     );

        //     if (academicYear.status == true) {
        //       activeAccYear = academicYear.accYear;
        //       break;
        //     }
        //   }

        //   if (activeAccYear == null || activeAccYear.trim().isEmpty) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(content: Text('Active academic year not found')),
        //     );
        //     return;
        //   }

        //   /// Store active academic year in AppData
        //   AppData.accYear = activeAccYear;

        //   debugPrint('===================================');
        //   debugPrint('ACTIVE ACADEMIC YEAR SAVED');
        //   debugPrint('Academic Year: ${AppData.accYear}');
        //   debugPrint('Employee ID: ${AppData.employeeId}');
        //   debugPrint('User ID: ${AppData.userId}');
        //   debugPrint('===================================');

        //   if (!context.mounted) {
        //     return;
        //   }

        //   /// Fetch standard and division after academic year is available
        //   context.read<AuthenticationCubit>().fetchTutorshipClass(
        //     FetchTutorshipClassRequest(
        //       accyear: AppData.accYear,
        //       employeeId: AppData.employeeId,
        //       userId: AppData.userId,
        //     ),
        //   );

        //   return;
        // }

        // /// ACADEMIC YEAR FAILURE
        // if (state is FetchAccYearFailure) {
        //   ScaffoldMessenger.of(
        //     context,
        //   ).showSnackBar(SnackBar(content: Text(state.message)));

        //   return;
        // }
        // if (state is FetchTutorshipClassSuccess) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text("Standard & Division Loaded")),
        //   );

        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (_) => TeacherDashboardPage()),
        //   );
        // }

        if (state is AuthenticationFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }

        if (state is FetchTutorshipClassFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final bool isLoading =
            state is AuthenticationLoading ||
            state is FetchTutorshipClassLoading;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 340,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 40,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B84E8).withOpacity(0.55),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Welcome',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'School Name',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 35),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: TextField(
                      controller: admissionController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 15,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B84E8),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: TextField(
                      controller: dobController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 15,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B84E8),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (admissionController.text.trim().isEmpty ||
                                    dobController.text.trim().isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Please enter username and password",
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                context.read<AuthenticationCubit>().login(
                                  LoginRequest(
                                    username: admissionController.text.trim(),
                                    password: dobController.text.trim(),
                                  ),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B84E8),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
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
