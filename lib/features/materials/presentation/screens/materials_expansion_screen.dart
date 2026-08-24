import 'package:cristalteacher/core/appdata/appdata.dart';
import 'package:cristalteacher/core/utils/date_utils_helper.dart';
import 'package:cristalteacher/features/materials/domain/entities/fetch_material_entity.dart';
import 'package:cristalteacher/features/materials/domain/parameter/fetch_material_parameter.dart';
import 'package:cristalteacher/features/materials/presentation/cubit/material_cubit.dart';
import 'package:cristalteacher/features/materials/presentation/screens/addmaterials_screen.dart';
import 'package:flutter/material.dart' hide MaterialState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class MaterialsExpansionScreen extends StatefulWidget {
  final int? subjectId;
  final String subjectName;

  const MaterialsExpansionScreen({
    super.key,
    required this.subjectId,
    required this.subjectName,
  });

  @override
  State<MaterialsExpansionScreen> createState() => _MaterialsExpansionScreen();
}

class _MaterialsExpansionScreen extends State<MaterialsExpansionScreen> {
  @override
  void initState() {
    super.initState();
    final String currentDate = DateUtilsHelper.getCurrentDate();
    context.read<MaterialCubit>().fetchMaterials(
      FetchMaterialParameter(
        subjectId: widget.subjectId!,
        accYear: AppData.accYear!,
        branchId: 1,
        fromDate: currentDate,
        toDate: currentDate,
        staffId: null,
      ),
    );
  }

  int selectedTab = 0;

  final List<String> tabs = ["Documents", "Links", "Notes"];

  final Color primaryColor = const Color(0xFF9B73E6);
  final Color darkColor = const Color(0xFF202020);
  final Color bgColor = const Color(0xFFFCFAFF);
  final Color cardColor = const Color(0xFFF5F2FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 30,
        ), // Increase to move it higher
        child: FloatingActionButton(
          backgroundColor: primaryColor,
          elevation: 3,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return AddMaterialPage();
                },
              ),
            );
          },
          child: const Icon(Icons.add, color: Colors.white, size: 34),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: primaryColor,
      //   elevation: 3,
      //   shape: const CircleBorder(),
      //   onPressed: () {},
      //   child: const Icon(Icons.add, color: Colors.white, size: 34),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 18),
            _buildTabBar(),
            const SizedBox(height: 14),
            _buildSearchRow(),
            const SizedBox(height: 14),

            // Expanded(
            //   child: ListView(
            //     padding: const EdgeInsets.fromLTRB(24, 0, 24, 90),
            //     children: [
            //       _buildDateText("12-10-2026 Monday"),
            //       const SizedBox(height: 12),
            //       _buildMaterialCard(),
            //       _buildMaterialCard(),
            //       _buildMaterialCard(),
            //       const SizedBox(height: 18),
            //       _buildDateText("12-10-2026 Monday"),
            //       const SizedBox(height: 12),
            //       _buildMaterialCard(),
            //       _buildMaterialCard(),
            //     ],
            //   ),
            // ),
            Expanded(
              child: BlocConsumer<MaterialCubit, MaterialState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is FetchMaterialLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is FetchMaterialFailure) {
                    return Center(child: Text(state.message));
                  }

                  if (state is FetchMaterialSuccess) {
                    //final materials = state.response.data ?? [];
                    final allMaterials = state.response.data ?? [];
                    for (final item in allMaterials) {
                      print(
                        "Document: ${item.documentName}, "
                        "Link: ${item.link}, "
                        "Notes: ${item.notes}",
                      );
                    }
                    List<MaterialEntity> materials;

                    switch (selectedTab) {
                      case 0: // Documents
                        materials = allMaterials
                            .where((e) => (e.documentName?.isNotEmpty ?? false))
                            .toList();
                        break;

                      case 1: // Links
                        materials = allMaterials
                            .where((e) => (e.link?.isNotEmpty ?? false))
                            .toList();
                        break;

                      case 2: // Notes
                        materials = allMaterials
                            .where((e) => (e.notes?.isNotEmpty ?? false))
                            .toList();
                        break;

                      default:
                        materials = allMaterials;
                    }
                    if (materials.isEmpty) {
                      return const Center(child: Text("No materials found"));
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 90),
                      itemCount: materials.length,
                      itemBuilder: (context, index) {
                        final material = materials[index];

                        return Column(
                          children: [
                            if (index == 0 ||
                                materials[index - 1].createdDate !=
                                    material.createdDate)
                              _buildDateText(material.createdDate ?? ""),

                            const SizedBox(height: 10),

                            _buildMaterialCard(material),
                          ],
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.black, size: 22),
          ),
          const Expanded(
            child: Center(
              child: Text(
                "Mathematics Material",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(width: 22),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22),
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: darkColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final bool isSelected = selectedTab == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTab = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                height: double.infinity,
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSearchRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.filter_list_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: primaryColor, width: 1),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, size: 18, color: Colors.grey),
                  SizedBox(width: 8),
                  Text(
                    "Search",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateText(String date) {
    return Center(
      child: Text(
        date,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildMaterialCard(MaterialEntity material) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          _buildLeadingIcon(),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              selectedTab == 0
                  ? (material.documentName ?? "")
                  : selectedTab == 1
                  ? (material.link ?? "")
                  : (material.notes ?? ""),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const SizedBox(width: 8),
          _buildTrailingSection(material),
        ],
      ),
    );
  }

  // Widget _buildLeadingIcon() {
  //   Widget icon;

  //   if (selectedTab == 0) {
  //     icon = SvgPicture.asset(
  //       "assets/icons/Group (10).svg",
  //       width: 24,
  //       height: 24,
  //     );
  //   } else if (selectedTab == 1) {
  //     icon = SvgPicture.asset(
  //       "assets/icons/Group (11).svg",
  //       width: 24,
  //       height: 24,
  //     );
  //   } else {
  //     icon = SvgPicture.asset(
  //       "assets/icons/Group (11).svg",
  //       width: 24,
  //       height: 24,
  //     );
  //   }

  //   return Icon(icon, color: primaryColor, size: 28);
  // }
  Widget _buildLeadingIcon() {
    String iconPath;

    switch (selectedTab) {
      case 0:
        iconPath = "assets/icons/Group (10).svg";
        break;
      case 1:
        iconPath = "assets/icons/Group (11).svg";
        break;
      default:
        iconPath = "assets/icons/Group (11).svg";
    }

    return SvgPicture.asset(
      iconPath,
      width: 24,
      height: 24,
      colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
    );
  }

  Widget _buildTrailingSection(MaterialEntity material) {
    return SizedBox(
      width: 55,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _SmallActionButton(iconPath: 'assets/icons/Group (6).svg'),
              const SizedBox(width: 5),
              _SmallActionButton(iconPath: 'assets/icons/Group (7).svg'),
            ],
          ),
          const SizedBox(height: 10),
          if (selectedTab == 0)
            Text(
              formatTime(material.createdDate),
              style: const TextStyle(fontSize: 9, color: Colors.black),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  selectedTab == 1 ? Icons.star : Icons.star_border,
                  color: selectedTab == 1 ? Colors.amber : Colors.black45,
                  size: 20,
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: primaryColor,
                  size: 14,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

String formatTime(String? dateTime) {
  if (dateTime == null || dateTime.isEmpty) return "";

  try {
    final date = DateTime.parse(dateTime);
    return DateFormat('hh:mm a').format(date);
  } catch (e) {
    return "";
  }
}

class _SmallActionButton extends StatelessWidget {
  final String iconPath;

  const _SmallActionButton({required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: const Color(0xFFDAC8FF),
        shape: BoxShape.circle,
      ),
      child: Center(child: SvgPicture.asset(iconPath, width: 14, height: 14)),
    );
  }
}
