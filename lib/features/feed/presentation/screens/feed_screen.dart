import 'package:cristalteacher/core/appdata/appdata.dart';
import 'package:cristalteacher/features/feed/domain/parameters/fetch_feed_parameter.dart';
import 'package:cristalteacher/features/feed/presentation/cubit/feed_cubit.dart';
import 'package:cristalteacher/features/feed/presentation/screens/addfeed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();

    _fetchFeed();
  }

  void _fetchFeed() {
    context.read<FeedCubit>().fetchFeed(
      FetchFeedParams(
        accYear: AppData.accYear,
        standardId: AppData.studentStdId,
        divisionId: AppData.studentDivId,
        fromDate: "2026-06-01",
        toDate: "2026-08-01",
      ),
    );
  }

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
                        onPressed: () {},
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

      // body: feedItems.isEmpty
      //     ? const Center(
      //         child: Text(
      //           "No Feed Available",
      //           style: TextStyle(
      //             fontSize: 14,
      //             color: Colors.black54,
      //             fontWeight: FontWeight.w500,
      //           ),
      //         ),
      //       )
      //     : ListView.builder(
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
      //               showDeleteDialog(index);
      //             },
      //           );
      //         },
      //       ),
      body: BlocConsumer<FeedCubit, FeedState>(
        listener: (context, state) {
          if (state is FetchFeedFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is SaveFeedSuccess) {
            context.read<FeedCubit>().fetchFeed(
              FetchFeedParams(
                accYear: AppData.accYear,
                standardId: AppData.studentStdId,
                divisionId: AppData.studentDivId,
                fromDate: "2026-06-01",
                toDate: "2026-08-01",
              ),
            );
          }

          if (state is SaveFeedFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is FetchFeedLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FetchFeedSuccess) {
            final feeds = state.response.data ?? [];

            if (feeds.isEmpty) {
              return const Center(child: Text("No Feed Available"));
            }

            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 90),
              itemCount: feeds.length,
              itemBuilder: (context, index) {
                final item = feeds[index];

                // return FeedCard(
                //   title: item.feedText ?? "",
                //   date: item.createdDateFormatted ?? "",
                //   imagePath: item.files != null && item.files!.isNotEmpty
                //       ? item.files!.first.image ?? ""
                //       : "",
                //   onEdit: () {},
                //   onDelete: () {
                //     showDeleteDialog(index);
                //   },
                // );
                return FeedCard(
                  title: item.feedText ?? "",
                  date: item.createdDateFormatted ?? "",
                  imagePath: item.files != null && item.files!.isNotEmpty
                      ? item.files!.first.image ?? ""
                      : "",
                  onEdit: () {},
                  onDelete: () {},
                );
              },
            );
          }

          return const SizedBox();
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
        children: [
          SizedBox(
            width: 150,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: imagePath.isNotEmpty
                  ? Image.network(
                      imagePath,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;

                        return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade300,
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                            size: 35,
                          ),
                        );
                      },
                    )
                  : Container(
                      color: Colors.grey.shade300,
                      child: const Icon(
                        Icons.image,
                        color: Colors.grey,
                        size: 35,
                      ),
                    ),
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

                Expanded(
                  child: Text(
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
                ),

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
