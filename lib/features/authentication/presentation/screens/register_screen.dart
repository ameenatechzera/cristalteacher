import 'package:cristalteacher/core/appdata/appdata.dart';
import 'package:cristalteacher/core/navigation/navigator.dart';
import 'package:cristalteacher/features/authentication/data/models/fetch_branch_model.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/fetch_school_parameter.dart';
import 'package:cristalteacher/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:cristalteacher/features/authentication/presentation/screens/login_screen.dart';
import 'package:cristalteacher/services/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCodePage extends StatelessWidget {
  const RegisterCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController schoolCodeController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Purple Section
            Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                color: Color(0xFF273D8F),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                ),
              ),
              child: Stack(
                children: [
                  // // Background watermark
                  // Positioned(
                  //   right: -10,
                  //   top: 10,
                  //   bottom: 10,
                  //   child: Opacity(
                  //     opacity: 0.99, // 👈 adjust visibility
                  //     child: Image.asset(
                  //       "assets/images/mask_bg.png",
                  //       color: Colors.white,
                  //       height: 150,
                  //       fit: BoxFit.contain,
                  //     ),
                  //   ),
                  // ),

                  //Logo
                  Center(
                    child: Image.asset(
                      'assets/images/cristal_white.png',
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            // Register Code Title
            const Text(
              "Register Code",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 20),

            // TextField
            BlocConsumer<AuthenticationCubit, AuthenticationState>(
              listener: (context, state) async {
                if (state is FetchSchoolLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                  );
                }

                if (state is FetchSchoolSuccess) {
                  print('SuccessResult ${state.response.message}');
                  if (state.response.message == 'School Not Found') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('School Code not found..!')),
                    );
                  }
                  Navigator.pop(context); // close loader

                  // final school = state.response.schoolDetails?.first;
                  final pref = SharedPreferenceHelper();
                  // 👉 You can store baseUrl + dbName here if needed
                  await pref.saveSchoolRegistered(true); // 🔥 THIS IS IMPORTANT

                  print("Saved school registered TRUE"); // add this

                  /// 🔥 GET SCHOOL DATA
                  final school = state.response.schoolDetails?.first;

                  if (school != null) {
                    /// ✅ SAVE BASE URL
                    await pref.setBaseUrl(school.baseUrl ?? '');

                    // School Code
                    await pref.setSchoolCode(
                      schoolCodeController.text.toString(),
                    );

                    /// ✅ SAVE DB NAME
                    await pref.setDatabaseName(school.dbName ?? '');

                    await pref.setAppStoreVersion(school.appStoreVersion!);
                    await pref.setPlayStoreVersion(school.playStoreVersion!);

                    print("BaseURL saved: ${school.baseUrl}");
                    print("DB Name saved: ${school.dbName}");
                  }

                  /// 🔥 CALL NEXT API (branch)
                  context.read<AuthenticationCubit>().getBranchDetails();
                  // AppNavigator.pushSlide(context: context, page: MainSplashScreen());
                }

                if (state is FetchSchoolFailure) {
                  Navigator.pop(context); // close loader

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }

                /// 🔄 BRANCH LOADING
                if (state is GetBranchLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                  );
                }

                /// ✅ BRANCH SUCCESS
                if (state is GetBranchSuccess) {
                  Navigator.pop(context); // close loader

                  final pref = SharedPreferenceHelper();

                  final branch = state.response.data;

                  if (branch != null && branch is BranchDataModel) {
                    await pref.saveBranchData(branch.toJson());

                    /// Save to AppData
                    AppData.branchId = branch.branchId;
                    AppData.branchName = branch.branchName;
                    print("Branch saved successfully: ${branch.branchName}");
                    print("Branch saved successfully: ${branch.branchName}");
                    print("Branch Id: ${AppData.branchId}");
                  }
                  AppNavigator.pushReplacementSlide(
                    context: context,
                    page: LoginScreen(),
                  );
                }

                /// ❌ BRANCH FAILURE
                if (state is GetBranchFailure) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: schoolCodeController,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                      UpperCaseTextFormatter(),
                    ],
                    decoration: InputDecoration(
                      hintText: "Enter Code",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF8D84E8),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            const Spacer(),

            // Connect Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8D84E8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    final code = schoolCodeController.text.trim();

                    if (code.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter school code"),
                        ),
                      );
                      return;
                    }

                    /// 🔥 CALL API
                    context.read<AuthenticationCubit>().fetchSchools(
                      FetchSchoolRequest(slno: code),
                    );
                  },
                  child: const Text(
                    "Connect",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
