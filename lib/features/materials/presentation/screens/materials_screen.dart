import 'package:cristalteacher/features/materials/presentation/screens/materials_expansion_screen.dart';
import 'package:flutter/material.dart';

class MaterialsScreen extends StatelessWidget {
  MaterialsScreen({super.key});

  final List<SubjectUiModel> subjects = [
    SubjectUiModel(name: "Maths"),
    SubjectUiModel(name: "Physics"),
    SubjectUiModel(name: "Chemistry"),
    SubjectUiModel(name: "English"),
    SubjectUiModel(name: "GK"),
    SubjectUiModel(name: "Arabic"),
  ];

  Map<String, dynamic> getSubjectStyle(String name) {
    switch (name.toLowerCase()) {
      case "maths":
        return {
          "icon": "assets/icons/mathsicon.png",
          "color": const Color(0xFFFFF3C4),
        };

      case "physics":
        return {
          "icon": "assets/icons/physics_icon.png",
          "color": const Color(0xFFDDF5C9),
        };

      // case "chemistry":
      //   return {
      //     "icon": "assets/icons/chemistry_icon.png",
      //     "color": const Color(0xFFD4F5D0),
      //   };

      // case "english":
      //   return {
      //     "icon": "assets/icons/english_icon.png",
      //     "color": const Color(0xFFD6EAF8),
      //   };

      // case "gk":
      //   return {
      //     "icon": "assets/icons/chemistry_icon.png",
      //     "color": const Color(0xFFCFEEFF),
      //   };

      // case "arabic":
      //   return {
      //     "icon": "assets/icons/chemistry_icon.png",
      //     "color": const Color(0xFFCFEEFF),
      //   };

      default:
        return {
          "icon": "assets/icons/physics_icon.png",
          "color": const Color(0xFFF8D7EC),
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFEDEDED),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Subject",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];
          final style = getSubjectStyle(subject.name);

          return InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MaterialsExpansionScreen(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: style["color"] as Color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(
                        style["icon"] as String,
                        height: 24,
                        width: 24,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Text(
                    subject.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SubjectUiModel {
  final String name;

  SubjectUiModel({required this.name});
}
