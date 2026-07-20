import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddFeedScreen extends StatefulWidget {
  const AddFeedScreen({super.key});

  @override
  State<AddFeedScreen> createState() => _AddFeedScreenState();
}

class _AddFeedScreenState extends State<AddFeedScreen> {
  final TextEditingController captionController = TextEditingController();

  final List<String> classes = [
    "I A",
    "II B",
    "II C",
    "I B",
    "II A",
    "II F",
    "I G",
    "II E",
    "II I",
  ];

  final Set<String> selectedClasses = {"I A", "I B", "I G"};

  @override
  void dispose() {
    captionController.dispose();
    super.dispose();
  }

  void toggleClass(String className, bool? value) {
    setState(() {
      if (value == true) {
        selectedClasses.add(className);
      } else {
        selectedClasses.remove(className);
      }
    });
  }

  void chooseFile() {
    debugPrint("Choose file tapped");
  }

  void saveFeed() {
    debugPrint("Caption: ${captionController.text}");
    debugPrint("Selected Classes: $selectedClasses");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 22),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Add  Feed",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: chooseFile,
              child: CustomPaint(
                painter: DashedBorderPainter(
                  color: Colors.black54,
                  strokeWidth: 1.2,
                  radius: 12,
                  dashWidth: 7,
                  dashSpace: 6,
                ),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xffeef3ff),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/Group (9).svg',
                        // width: 14,
                        // height: 14,
                        colorFilter: const ColorFilter.mode(
                          Color(0xff2E5CE9), // Your desired color
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Choose File",
                        style: TextStyle(
                          color: Color(0xff1f60ff),
                          fontSize: 11,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xff1f60ff),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 17),

            Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.fromLTRB(12, 5, 12, 10),
              decoration: BoxDecoration(
                color: const Color(0xffeef3ff),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  TextField(
                    controller: captionController,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                      hintText: "Add A Caption",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(right: 28, top: 0),
                    ),
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),

                  Positioned(
                    top: 5,
                    right: 2,
                    child: Container(
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/Group (8).svg',
                          width: 14,
                          height: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 23),

            const Text(
              "Select You Classes",
              style: TextStyle(
                color: Colors.black,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 18),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: classes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 46,
                crossAxisSpacing: 28,
              ),
              itemBuilder: (context, index) {
                final className = classes[index];
                final isSelected = selectedClasses.contains(className);

                return Row(
                  children: [
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: Checkbox(
                        value: isSelected,
                        onChanged: (value) {
                          toggleClass(className, value);
                        },
                        activeColor: const Color(0xff8f83dc),
                        checkColor: Colors.black,
                        side: WidgetStateBorderSide.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return const BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            );
                          }
                          return const BorderSide(
                            color: Colors.black54,
                            width: 1,
                          );
                        }),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Text(
                      className,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? const Color(0xff7d6dff)
                            : Colors.black87,
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: saveFeed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff9b78dc),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double radius;
  final double dashWidth;
  final double dashSpace;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.radius,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rect);
    final pathMetrics = path.computeMetrics();

    for (final metric in pathMetrics) {
      double distance = 0;

      while (distance < metric.length) {
        final nextDistance = distance + dashWidth;
        final dashPath = metric.extractPath(
          distance,
          nextDistance.clamp(0, metric.length),
        );

        canvas.drawPath(dashPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
