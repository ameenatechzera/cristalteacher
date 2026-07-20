// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class FeedScreen extends StatelessWidget {
//   const FeedScreen({super.key});

//   final List<Map<String, String>> feedItems = const [
//     {
//       "title": "New School Block West Side And Basketball Court",
//       "date": "12-10-2026",
//       "image": "assets/images/Rectangle 95.png",
//     },
//     {
//       "title": "New School Block West Side And Basketball Court",
//       "date": "12-10-2026",
//       "image": "assets/images/Rectangle 95.png",
//     },
//     {
//       "title": "New School Block West Side And Basketball Court",
//       "date": "12-10-2026",
//       "image": "assets/images/Rectangle 95.png",
//     },
//     {
//       "title": "New School Block West Side And Basketball Court",
//       "date": "12-10-2026",
//       "image": "assets/images/Rectangle 95.png",
//     },
//     {
//       "title": "New School Block West Side And Basketball Court",
//       "date": "12-10-2026",
//       "image": "assets/images/Rectangle 95.png",
//     },
//     {
//       "title": "New School Block West Side And Basketball Court",
//       "date": "12-10-2026",
//       "image": "assets/images/Rectangle 95.png",
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xfff7f7f7),

//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text(
//           "Feed",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),

//       body: ListView.builder(
//         padding: const EdgeInsets.fromLTRB(18, 12, 18, 90),
//         itemCount: feedItems.length,
//         itemBuilder: (context, index) {
//           final item = feedItems[index];

//           return FeedCard(
//             title: item["title"]!,
//             date: item["date"]!,
//             imagePath: item["image"]!,
//             onEdit: () {
//               debugPrint("Edit tapped");
//             },
//             onDelete: () {
//               debugPrint("Delete tapped");
//             },
//           );
//         },
//       ),

//       floatingActionButton: FloatingActionButton(
//         backgroundColor: const Color(0xff9b6ce3),
//         elevation: 4,
//         shape: const CircleBorder(),
//         onPressed: () {
//           debugPrint("Add tapped");
//         },
//         child: const Icon(Icons.add, color: Colors.white, size: 34),
//       ),
//     );
//   }
// }

// class FeedCard extends StatelessWidget {
//   final String title;
//   final String date;
//   final String imagePath;
//   final VoidCallback onEdit;
//   final VoidCallback onDelete;

//   const FeedCard({
//     super.key,
//     required this.title,
//     required this.date,
//     required this.imagePath,
//     required this.onEdit,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 120,
//       margin: const EdgeInsets.only(bottom: 18),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(13),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.16),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),

//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(9),
//             child: Image.asset(
//               imagePath,
//               width: 150,
//               height: 100,
//               fit: BoxFit.cover,
//             ),
//           ),

//           const SizedBox(width: 12),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       _ActionCircleButton(
//                         svgIcon: "assets/icons/Group (6).svg",
//                         onTap: onEdit,
//                       ),
//                       const SizedBox(width: 8),
//                       _ActionCircleButton(
//                         svgIcon: "assets/icons/Group (7).svg",
//                         onTap: onDelete,
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 Text(
//                   title,
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 11.5,
//                     height: 1.25,
//                     color: Colors.black87,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),

//                 const Spacer(),

//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: Text(
//                     date,
//                     style: const TextStyle(
//                       fontSize: 9.5,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ActionCircleButton extends StatelessWidget {
//   final String svgIcon;
//   final VoidCallback onTap;

//   const _ActionCircleButton({
//     super.key,
//     required this.svgIcon,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(50),
//       child: Container(
//         width: 24,
//         height: 24,
//         decoration: const BoxDecoration(
//           color: Color(0xffdec9ff),
//           shape: BoxShape.circle,
//         ),
//         child: Center(child: SvgPicture.asset(svgIcon, width: 14, height: 14)),
//       ),
//     );
//   }
// }
import 'package:cristalteacher/features/feed/presentation/screens/addfeed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final List<Map<String, String>> feedItems = [
    {
      "title": "New School Block West Side And Basketball Court",
      "date": "12-10-2026",
      "image": "assets/images/Rectangle 95.png",
    },
    {
      "title": "New School Block West Side And Basketball Court",
      "date": "12-10-2026",
      "image": "assets/images/Rectangle 95.png",
    },
    {
      "title": "New School Block West Side And Basketball Court",
      "date": "12-10-2026",
      "image": "assets/images/Rectangle 95.png",
    },
    {
      "title": "New School Block West Side And Basketball Court",
      "date": "12-10-2026",
      "image": "assets/images/Rectangle 95.png",
    },
    {
      "title": "New School Block West Side And Basketball Court",
      "date": "12-10-2026",
      "image": "assets/images/Rectangle 95.png",
    },
    {
      "title": "New School Block West Side And Basketball Court",
      "date": "12-10-2026",
      "image": "assets/images/Rectangle 95.png",
    },
  ];

  void showDeleteDialog(int index) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 34),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Are You Sure You Want To\nDelete This Post?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    height: 1.3,
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 92,
                      height: 38,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffe9e9e9),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "NO",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 18),

                    SizedBox(
                      width: 92,
                      height: 38,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);

                          setState(() {
                            feedItems.removeAt(index);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff8f83dc),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "Yes",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Feed",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: feedItems.isEmpty
          ? const Center(
              child: Text(
                "No Feed Available",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 90),
              itemCount: feedItems.length,
              itemBuilder: (context, index) {
                final item = feedItems[index];

                return FeedCard(
                  title: item["title"]!,
                  date: item["date"]!,
                  imagePath: item["image"]!,
                  onEdit: () {
                    debugPrint("Edit tapped");
                  },
                  onDelete: () {
                    showDeleteDialog(index);
                  },
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff9b6ce3),
        elevation: 4,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddFeedScreen();
              },
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 34),
      ),
    );
  }
}

class FeedCard extends StatelessWidget {
  final String title;
  final String date;
  final String imagePath;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const FeedCard({
    super.key,
    required this.title,
    required this.date,
    required this.imagePath,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.asset(
              imagePath,
              width: 150,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _ActionCircleButton(
                        svgIcon: "assets/icons/Group (6).svg",
                        onTap: onEdit,
                      ),

                      const SizedBox(width: 8),

                      _ActionCircleButton(
                        svgIcon: "assets/icons/Group (7).svg",
                        onTap: onDelete,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11.5,
                    height: 1.25,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const Spacer(),

                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    date,
                    style: const TextStyle(
                      fontSize: 9.5,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCircleButton extends StatelessWidget {
  final String svgIcon;
  final VoidCallback onTap;

  const _ActionCircleButton({required this.svgIcon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          color: Color(0xffdec9ff),
          shape: BoxShape.circle,
        ),
        child: Center(child: SvgPicture.asset(svgIcon, width: 14, height: 14)),
      ),
    );
  }
}
