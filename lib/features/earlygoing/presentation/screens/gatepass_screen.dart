// import 'package:cristalteacher/core/appdata/appdata.dart';
// import 'package:cristalteacher/features/earlygoing/domain/entities/gatepass_entity.dart';
// import 'package:cristalteacher/features/earlygoing/domain/parameter/gatepass_parameter.dart';
// import 'package:cristalteacher/features/earlygoing/presentation/cubit/gatepass_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class GatePassScreen extends StatefulWidget {
//   const GatePassScreen({super.key});

//   @override
//   State<GatePassScreen> createState() => _GatePassScreenState();
// }

// class _GatePassScreenState extends State<GatePassScreen> {
//   final List<GatePassData> requests = [];
//   final Set<int> expandedRequestIds = {};

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (!mounted) return;

//       if (AppData.accYear == null || AppData.accYear!.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Academic year is unavailable'),
//             behavior: SnackBarBehavior.floating,
//           ),
//         );

//         return;
//       }

//       final today = DateTime.now();

//       final date =
//           '${today.year.toString().padLeft(4, '0')}-'
//           '${today.month.toString().padLeft(2, '0')}-'
//           '${today.day.toString().padLeft(2, '0')}';

//       context.read<GatepassCubit>().fetchGatePass(
//         FetchGatePassParameter(
//           accYear: AppData.accYear!,
//           branchId: 1,
//           employeeId: null,
//           fromDate: date,
//           status: 'pending',
//           toDate: date,
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<GatepassCubit, GatepassState>(
//       listener: (context, state) {
//         if (state is GatepassSuccess) {
//           setState(() {
//             requests
//               ..clear()
//               ..addAll(state.response.data ?? []);
//           });
//         }

//         if (state is GatepassFailure) {
//           ScaffoldMessenger.of(context)
//             ..hideCurrentSnackBar()
//             ..showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//                 behavior: SnackBarBehavior.floating,
//               ),
//             );
//         }
//       },
//       builder: (context, state) {
//         final isLoading = state is GatepassLoading;

//         final approvedCount = requests.where((request) {
//           return request.teacherStatus?.trim().toLowerCase() == 'approved' ||
//               request.finalStatus?.trim().toLowerCase() == 'approved';
//         }).length;

//         return Scaffold(
//           backgroundColor: const Color(0xFFF8F8F8),
//           appBar: AppBar(
//             toolbarHeight: 64,
//             backgroundColor: Colors.white,
//             surfaceTintColor: Colors.white,
//             elevation: 0,
//             centerTitle: true,
//             leading: IconButton(
//               onPressed: () => Navigator.maybePop(context),
//               icon: const Icon(Icons.arrow_back, color: Colors.black, size: 25),
//             ),
//             title: const Text(
//               'Gate Pass',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//           body: SafeArea(
//             top: false,
//             child: Column(
//               children: [
//                 Container(
//                   color: Colors.white,
//                   padding: const EdgeInsets.fromLTRB(22, 12, 22, 19),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           height: 124,
//                           padding: const EdgeInsets.fromLTRB(14, 15, 14, 14),
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFF0EDFF),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'All Requested',
//                                 style: TextStyle(
//                                   color: Color(0xFF27232E),
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               Text(
//                                 requests.length.toString(),
//                                 style: const TextStyle(
//                                   color: Color(0xFF303035),
//                                   fontSize: 29,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               const Spacer(),
//                               const Text(
//                                 'View All',
//                                 style: TextStyle(
//                                   color: Color(0xFF4730D9),
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w500,
//                                   decoration: TextDecoration.underline,
//                                   decorationColor: Color(0xFF4730D9),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 6),
//                       Expanded(
//                         child: Container(
//                           height: 124,
//                           padding: const EdgeInsets.fromLTRB(14, 15, 14, 14),
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFE7F8EC),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Approved',
//                                 style: TextStyle(
//                                   color: Color(0xFF27232E),
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               Text(
//                                 approvedCount.toString(),
//                                 style: const TextStyle(
//                                   color: Color(0xFF303035),
//                                   fontSize: 29,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               const Spacer(),
//                               const Text(
//                                 'View All',
//                                 style: TextStyle(
//                                   color: Color(0xFF4730D9),
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w500,
//                                   decoration: TextDecoration.underline,
//                                   decorationColor: Color(0xFF4730D9),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: isLoading
//                       ? const Center(
//                           child: CircularProgressIndicator(
//                             color: Color(0xFF0758C9),
//                           ),
//                         )
//                       : RefreshIndicator(
//                           color: const Color(0xFF0758C9),
//                           onRefresh: () async {
//                             if (AppData.accYear == null ||
//                                 AppData.accYear!.isEmpty) {
//                               return;
//                             }

//                             final today = DateTime.now();

//                             final date =
//                                 '${today.year.toString().padLeft(4, '0')}-'
//                                 '${today.month.toString().padLeft(2, '0')}-'
//                                 '${today.day.toString().padLeft(2, '0')}';

//                             await context.read<GatepassCubit>().fetchGatePass(
//                               FetchGatePassParameter(
//                                 accYear: AppData.accYear!,
//                                 branchId: 1,
//                                 employeeId: null,
//                                 fromDate: date,
//                                 status: 'pending',
//                                 toDate: date,
//                               ),
//                             );
//                           },
//                           child: requests.isEmpty
//                               ? ListView(
//                                   physics:
//                                       const AlwaysScrollableScrollPhysics(),
//                                   children: const [
//                                     SizedBox(height: 180),
//                                     Icon(
//                                       Icons.directions_walk_outlined,
//                                       color: Color(0xFFB5B0BC),
//                                       size: 48,
//                                     ),
//                                     SizedBox(height: 12),
//                                     Center(
//                                       child: Text(
//                                         'No gate pass requests found',
//                                         style: TextStyle(
//                                           color: Color(0xFF77717D),
//                                           fontSize: 13,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               : ListView(
//                                   physics: const AlwaysScrollableScrollPhysics(
//                                     parent: BouncingScrollPhysics(),
//                                   ),
//                                   padding: const EdgeInsets.fromLTRB(
//                                     22,
//                                     18,
//                                     22,
//                                     30,
//                                   ),
//                                   children: [
//                                     const Text(
//                                       'Today Request',
//                                       style: TextStyle(
//                                         color: Color(0xFF242129),
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 16),
//                                     ...List.generate(requests.length, (index) {
//                                       final request = requests[index];

//                                       final requestId = request.id ?? index;

//                                       final isExpanded = expandedRequestIds
//                                           .contains(requestId);

//                                       DateTime? requestDate;

//                                       if (request.requestDate != null) {
//                                         requestDate = DateTime.tryParse(
//                                           request.requestDate!,
//                                         );
//                                       }

//                                       String formattedDate =
//                                           request.requestDate ?? '';

//                                       String dayName = '';

//                                       if (requestDate != null) {
//                                         formattedDate =
//                                             '${requestDate.day.toString().padLeft(2, '0')}-'
//                                             '${requestDate.month.toString().padLeft(2, '0')}-'
//                                             '${requestDate.year}';

//                                         const days = [
//                                           'Monday',
//                                           'Tuesday',
//                                           'Wednesday',
//                                           'Thursday',
//                                           'Friday',
//                                           'Saturday',
//                                           'Sunday',
//                                         ];

//                                         dayName = days[requestDate.weekday - 1];
//                                       }

//                                       return Padding(
//                                         padding: const EdgeInsets.only(
//                                           bottom: 21,
//                                         ),
//                                         child: AnimatedContainer(
//                                           duration: const Duration(
//                                             milliseconds: 250,
//                                           ),
//                                           curve: Curves.easeInOut,
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.circular(
//                                               19,
//                                             ),
//                                             border: Border.all(
//                                               color: const Color(0xFFEEEEEE),
//                                             ),
//                                             boxShadow: const [
//                                               BoxShadow(
//                                                 color: Color(0x14000000),
//                                                 blurRadius: 12,
//                                                 offset: Offset(0, 4),
//                                               ),
//                                             ],
//                                           ),
//                                           child: Column(
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.fromLTRB(
//                                                       15,
//                                                       15,
//                                                       15,
//                                                       14,
//                                                     ),
//                                                 child: Column(
//                                                   children: [
//                                                     Row(
//                                                       children: [
//                                                         Container(
//                                                           width: 42,
//                                                           height: 42,
//                                                           decoration: BoxDecoration(
//                                                             color: const Color(
//                                                               0xFFDED8FF,
//                                                             ),
//                                                             shape:
//                                                                 BoxShape.circle,
//                                                             border: Border.all(
//                                                               color:
//                                                                   const Color(
//                                                                     0xFFE7E3FF,
//                                                                   ),
//                                                             ),
//                                                           ),
//                                                           child: const Icon(
//                                                             Icons.person,
//                                                             color: Color(
//                                                               0xFF5842E3,
//                                                             ),
//                                                             size: 25,
//                                                           ),
//                                                         ),
//                                                         const SizedBox(
//                                                           width: 11,
//                                                         ),
//                                                         Expanded(
//                                                           child: Column(
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                             children: [
//                                                               Text(
//                                                                 request.name ??
//                                                                     'Unknown Student',
//                                                                 maxLines: 1,
//                                                                 overflow:
//                                                                     TextOverflow
//                                                                         .ellipsis,
//                                                                 style: const TextStyle(
//                                                                   color: Color(
//                                                                     0xFF16131A,
//                                                                   ),
//                                                                   fontSize: 14,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w600,
//                                                                 ),
//                                                               ),
//                                                               const SizedBox(
//                                                                 height: 6,
//                                                               ),
//                                                               Row(
//                                                                 children: [
//                                                                   Flexible(
//                                                                     child: Text(
//                                                                       formattedDate,
//                                                                       maxLines:
//                                                                           1,
//                                                                       overflow:
//                                                                           TextOverflow
//                                                                               .ellipsis,
//                                                                       style: const TextStyle(
//                                                                         color: Color(
//                                                                           0xFF0052C8,
//                                                                         ),
//                                                                         fontSize:
//                                                                             10,
//                                                                         fontWeight:
//                                                                             FontWeight.w500,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   if (dayName
//                                                                       .isNotEmpty) ...[
//                                                                     const Padding(
//                                                                       padding: EdgeInsets.symmetric(
//                                                                         horizontal:
//                                                                             7,
//                                                                       ),
//                                                                       child: Text(
//                                                                         '|',
//                                                                         style: TextStyle(
//                                                                           color: Color(
//                                                                             0xFF0052C8,
//                                                                           ),
//                                                                           fontSize:
//                                                                               10,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Flexible(
//                                                                       child: Text(
//                                                                         dayName,
//                                                                         maxLines:
//                                                                             1,
//                                                                         overflow:
//                                                                             TextOverflow.ellipsis,
//                                                                         style: const TextStyle(
//                                                                           color: Color(
//                                                                             0xFF0052C8,
//                                                                           ),
//                                                                           fontSize:
//                                                                               10,
//                                                                           fontWeight:
//                                                                               FontWeight.w500,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ],
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     const SizedBox(height: 15),
//                                                     Container(
//                                                       width: double.infinity,
//                                                       padding:
//                                                           const EdgeInsets.fromLTRB(
//                                                             15,
//                                                             14,
//                                                             10,
//                                                             14,
//                                                           ),
//                                                       decoration: BoxDecoration(
//                                                         color: const Color(
//                                                           0xFFF0EEFF,
//                                                         ),
//                                                         borderRadius:
//                                                             BorderRadius.circular(
//                                                               9,
//                                                             ),
//                                                         border: const Border(
//                                                           left: BorderSide(
//                                                             color: Color(
//                                                               0xFF5138ED,
//                                                             ),
//                                                             width: 4,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       child: Column(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           Text(
//                                                             request.requestNo ==
//                                                                         null ||
//                                                                     request
//                                                                         .requestNo!
//                                                                         .isEmpty
//                                                                 ? 'GATE PASS REQUEST'
//                                                                 : 'REQUEST NO: ${request.requestNo}',
//                                                             style:
//                                                                 const TextStyle(
//                                                                   color: Color(
//                                                                     0xFF0052C8,
//                                                                   ),
//                                                                   fontSize: 10,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w700,
//                                                                 ),
//                                                           ),
//                                                           const SizedBox(
//                                                             height: 10,
//                                                           ),
//                                                           Row(
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                             children: [
//                                                               Expanded(
//                                                                 child: Text(
//                                                                   request.reason ??
//                                                                       'No reason provided',
//                                                                   style: const TextStyle(
//                                                                     color: Color(
//                                                                       0xFF27232E,
//                                                                     ),
//                                                                     fontSize:
//                                                                         13,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w400,
//                                                                     height:
//                                                                         1.45,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               const SizedBox(
//                                                                 width: 4,
//                                                               ),
//                                                               InkWell(
//                                                                 onTap: () {
//                                                                   setState(() {
//                                                                     if (isExpanded) {
//                                                                       expandedRequestIds
//                                                                           .remove(
//                                                                             requestId,
//                                                                           );
//                                                                     } else {
//                                                                       expandedRequestIds
//                                                                           .add(
//                                                                             requestId,
//                                                                           );
//                                                                     }
//                                                                   });
//                                                                 },
//                                                                 borderRadius:
//                                                                     BorderRadius.circular(
//                                                                       20,
//                                                                     ),
//                                                                 child: Padding(
//                                                                   padding:
//                                                                       const EdgeInsets.all(
//                                                                         4,
//                                                                       ),
//                                                                   child: AnimatedRotation(
//                                                                     turns:
//                                                                         isExpanded
//                                                                         ? 0.5
//                                                                         : 0,
//                                                                     duration: const Duration(
//                                                                       milliseconds:
//                                                                           250,
//                                                                     ),
//                                                                     child: const Icon(
//                                                                       Icons
//                                                                           .keyboard_arrow_down_rounded,
//                                                                       color: Color(
//                                                                         0xFF615C67,
//                                                                       ),
//                                                                       size: 23,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                           const SizedBox(
//                                                             height: 15,
//                                                           ),
//                                                           Text(
//                                                             '$formattedDate'
//                                                             '${dayName.isEmpty ? '' : ' $dayName'}',
//                                                             style:
//                                                                 const TextStyle(
//                                                                   color: Color(
//                                                                     0xFF0052C8,
//                                                                   ),
//                                                                   fontSize: 10,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w500,
//                                                                 ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     AnimatedSize(
//                                                       duration: const Duration(
//                                                         milliseconds: 250,
//                                                       ),
//                                                       curve: Curves.easeInOut,
//                                                       child: isExpanded
//                                                           ? Padding(
//                                                               padding:
//                                                                   const EdgeInsets.fromLTRB(
//                                                                     10,
//                                                                     15,
//                                                                     10,
//                                                                     2,
//                                                                   ),
//                                                               child: Row(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                 children: [
//                                                                   Expanded(
//                                                                     child: Column(
//                                                                       crossAxisAlignment:
//                                                                           CrossAxisAlignment
//                                                                               .start,
//                                                                       children: [
//                                                                         const Text(
//                                                                           'Pickup by',
//                                                                           style: TextStyle(
//                                                                             color: Color(
//                                                                               0xFF8B8790,
//                                                                             ),
//                                                                             fontSize:
//                                                                                 10,
//                                                                           ),
//                                                                         ),
//                                                                         const SizedBox(
//                                                                           height:
//                                                                               7,
//                                                                         ),
//                                                                         Text(
//                                                                           request.pickupPersonName ??
//                                                                               '-',
//                                                                           style: const TextStyle(
//                                                                             color: Color(
//                                                                               0xFF242129,
//                                                                             ),
//                                                                             fontSize:
//                                                                                 11,
//                                                                             fontWeight:
//                                                                                 FontWeight.w600,
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   const SizedBox(
//                                                                     width: 10,
//                                                                   ),
//                                                                   Expanded(
//                                                                     child: Column(
//                                                                       crossAxisAlignment:
//                                                                           CrossAxisAlignment
//                                                                               .start,
//                                                                       children: [
//                                                                         const Text(
//                                                                           'Relation',
//                                                                           style: TextStyle(
//                                                                             color: Color(
//                                                                               0xFF8B8790,
//                                                                             ),
//                                                                             fontSize:
//                                                                                 10,
//                                                                           ),
//                                                                         ),
//                                                                         const SizedBox(
//                                                                           height:
//                                                                               7,
//                                                                         ),
//                                                                         Text(
//                                                                           request.pickupPersonRelation ??
//                                                                               '-',
//                                                                           style: const TextStyle(
//                                                                             color: Color(
//                                                                               0xFF242129,
//                                                                             ),
//                                                                             fontSize:
//                                                                                 11,
//                                                                             fontWeight:
//                                                                                 FontWeight.w600,
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   const SizedBox(
//                                                                     width: 10,
//                                                                   ),
//                                                                   Expanded(
//                                                                     child: Column(
//                                                                       crossAxisAlignment:
//                                                                           CrossAxisAlignment
//                                                                               .start,
//                                                                       children: [
//                                                                         const Text(
//                                                                           'Mobile Number',
//                                                                           style: TextStyle(
//                                                                             color: Color(
//                                                                               0xFF8B8790,
//                                                                             ),
//                                                                             fontSize:
//                                                                                 10,
//                                                                           ),
//                                                                         ),
//                                                                         const SizedBox(
//                                                                           height:
//                                                                               7,
//                                                                         ),
//                                                                         Text(
//                                                                           request.pickupPersonMobile ??
//                                                                               '-',
//                                                                           maxLines:
//                                                                               1,
//                                                                           overflow:
//                                                                               TextOverflow.ellipsis,
//                                                                           style: const TextStyle(
//                                                                             color: Color(
//                                                                               0xFF242129,
//                                                                             ),
//                                                                             fontSize:
//                                                                                 11,
//                                                                             fontWeight:
//                                                                                 FontWeight.w600,
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             )
//                                                           : const SizedBox.shrink(),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               ClipRRect(
//                                                 borderRadius:
//                                                     const BorderRadius.vertical(
//                                                       bottom: Radius.circular(
//                                                         18,
//                                                       ),
//                                                     ),
//                                                 child: SizedBox(
//                                                   height: 52,
//                                                   child: Row(
//                                                     children: [
//                                                       Expanded(
//                                                         child: Material(
//                                                           color: const Color(
//                                                             0xFF0758C9,
//                                                           ),
//                                                           child: InkWell(
//                                                             onTap: () {
//                                                               ScaffoldMessenger.of(
//                                                                   context,
//                                                                 )
//                                                                 ..hideCurrentSnackBar()
//                                                                 ..showSnackBar(
//                                                                   const SnackBar(
//                                                                     content: Text(
//                                                                       'Approve API is not implemented',
//                                                                     ),
//                                                                     behavior:
//                                                                         SnackBarBehavior
//                                                                             .floating,
//                                                                   ),
//                                                                 );
//                                                             },
//                                                             child: const Center(
//                                                               child: Text(
//                                                                 'Approve',
//                                                                 style: TextStyle(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   fontSize: 15,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w500,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         width: 1,
//                                                         color: Colors.white,
//                                                       ),
//                                                       Expanded(
//                                                         child: Material(
//                                                           color: const Color(
//                                                             0xFFFF7774,
//                                                           ),
//                                                           child: InkWell(
//                                                             onTap: () {
//                                                               ScaffoldMessenger.of(
//                                                                   context,
//                                                                 )
//                                                                 ..hideCurrentSnackBar()
//                                                                 ..showSnackBar(
//                                                                   const SnackBar(
//                                                                     content: Text(
//                                                                       'Reject API is not implemented',
//                                                                     ),
//                                                                     behavior:
//                                                                         SnackBarBehavior
//                                                                             .floating,
//                                                                   ),
//                                                                 );
//                                                             },
//                                                             child: const Center(
//                                                               child: Text(
//                                                                 'Rejected',
//                                                                 style: TextStyle(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   fontSize: 15,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w500,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     }),
//                                   ],
//                                 ),
//                         ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:cristalteacher/core/appdata/appdata.dart';
import 'package:cristalteacher/features/earlygoing/domain/entities/gatepass_entity.dart';
import 'package:cristalteacher/features/earlygoing/domain/parameter/gatepass_parameter.dart';
import 'package:cristalteacher/features/earlygoing/domain/parameter/update_gatepass_parameter.dart';
import 'package:cristalteacher/features/earlygoing/presentation/cubit/gatepass_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GatePassScreen extends StatefulWidget {
  const GatePassScreen({super.key});

  @override
  State<GatePassScreen> createState() => _GatePassScreenState();
}

class _GatePassScreenState extends State<GatePassScreen> {
  final List<GatePassData> requests = [];
  final Set<int> expandedRequestIds = {};

  int? updatingRequestId;
  String? updatingStatus;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (AppData.accYear == null || AppData.accYear!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Academic year is unavailable'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      final now = DateTime.now();

      final date =
          '${now.year.toString().padLeft(4, '0')}-'
          '${now.month.toString().padLeft(2, '0')}-'
          '${now.day.toString().padLeft(2, '0')}';

      context.read<GatepassCubit>().fetchGatePass(
        FetchGatePassParameter(
          accYear: AppData.accYear!,
          branchId: 1,
          employeeId: null,
          fromDate: date,
          status: 'pending',
          toDate: date,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GatepassCubit, GatepassState>(
      listener: (context, state) {
        if (state is GatepassSuccess) {
          setState(() {
            requests
              ..clear()
              ..addAll(state.response.data ?? []);
          });
        }

        if (state is GatepassFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
              ),
            );
        }

        if (state is UpdateGatePassSuccess) {
          setState(() {
            requests.removeWhere((request) => request.id == updatingRequestId);

            if (updatingRequestId != null) {
              expandedRequestIds.remove(updatingRequestId);
            }

            updatingRequestId = null;
            updatingStatus = null;
          });

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Gate pass updated successfully'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
              ),
            );
        }

        if (state is UpdateGatePassFailure) {
          setState(() {
            updatingRequestId = null;
            updatingStatus = null;
          });

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      builder: (context, state) {
        final isLoading = state is GatepassLoading;

        final approvedCount = requests.where((request) {
          return request.teacherStatus?.toLowerCase() == 'approved' ||
              request.finalStatus?.toLowerCase() == 'approved';
        }).length;

        return Scaffold(
          backgroundColor: const Color(0xFFF8F8F8),
          appBar: AppBar(
            toolbarHeight: 64,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 25),
            ),
            title: const Text(
              'Gate Pass',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(22, 12, 22, 19),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 124,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0EDFF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'All Requested',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                requests.length.toString(),
                                style: const TextStyle(
                                  fontSize: 29,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                'View All',
                                style: TextStyle(
                                  color: Color(0xFF4730D9),
                                  fontSize: 11,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Container(
                          height: 124,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE7F8EC),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Approved',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                approvedCount.toString(),
                                style: const TextStyle(
                                  fontSize: 29,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                'View All',
                                style: TextStyle(
                                  color: Color(0xFF4730D9),
                                  fontSize: 11,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF0758C9),
                          ),
                        )
                      : RefreshIndicator(
                          color: const Color(0xFF0758C9),
                          onRefresh: () async {
                            if (AppData.accYear == null ||
                                AppData.accYear!.isEmpty) {
                              return;
                            }

                            final now = DateTime.now();

                            final date =
                                '${now.year.toString().padLeft(4, '0')}-'
                                '${now.month.toString().padLeft(2, '0')}-'
                                '${now.day.toString().padLeft(2, '0')}';

                            await context.read<GatepassCubit>().fetchGatePass(
                              FetchGatePassParameter(
                                accYear: AppData.accYear!,
                                branchId: 1,
                                employeeId: null,
                                fromDate: date,
                                status: 'pending',
                                toDate: date,
                              ),
                            );
                          },
                          child: requests.isEmpty
                              ? ListView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  children: const [
                                    SizedBox(height: 180),
                                    Icon(
                                      Icons.directions_walk_outlined,
                                      color: Color(0xFFB5B0BC),
                                      size: 48,
                                    ),
                                    SizedBox(height: 12),
                                    Center(
                                      child: Text(
                                        'No gate pass requests found',
                                        style: TextStyle(
                                          color: Color(0xFF77717D),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : ListView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  padding: const EdgeInsets.fromLTRB(
                                    22,
                                    18,
                                    22,
                                    30,
                                  ),
                                  children: [
                                    const Text(
                                      'Today Request',
                                      style: TextStyle(
                                        color: Color(0xFF242129),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    ...List.generate(requests.length, (index) {
                                      final request = requests[index];
                                      final requestId = request.id ?? index;

                                      final isExpanded = expandedRequestIds
                                          .contains(requestId);

                                      final isUpdating =
                                          state is UpdateGatePassLoading &&
                                          updatingRequestId == request.id;

                                      final parsedDate = DateTime.tryParse(
                                        request.requestDate ?? '',
                                      );

                                      String formattedDate =
                                          request.requestDate ?? '';

                                      String dayName = '';

                                      if (parsedDate != null) {
                                        formattedDate =
                                            '${parsedDate.day.toString().padLeft(2, '0')}-'
                                            '${parsedDate.month.toString().padLeft(2, '0')}-'
                                            '${parsedDate.year}';

                                        const days = [
                                          'Monday',
                                          'Tuesday',
                                          'Wednesday',
                                          'Thursday',
                                          'Friday',
                                          'Saturday',
                                          'Sunday',
                                        ];

                                        dayName = days[parsedDate.weekday - 1];
                                      }

                                      return Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 21,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            19,
                                          ),
                                          border: Border.all(
                                            color: const Color(0xFFEEEEEE),
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(0x14000000),
                                              blurRadius: 12,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                    15,
                                                    15,
                                                    15,
                                                    14,
                                                  ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 42,
                                                        height: 42,
                                                        decoration:
                                                            const BoxDecoration(
                                                              color: Color(
                                                                0xFFDED8FF,
                                                              ),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                        child: const Icon(
                                                          Icons.person,
                                                          color: Color(
                                                            0xFF5842E3,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 11),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              request.name ??
                                                                  'Unknown Student',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 6,
                                                            ),
                                                            Text(
                                                              '$formattedDate'
                                                              '${dayName.isEmpty ? '' : '  |  $dayName'}',
                                                              style: const TextStyle(
                                                                color: Color(
                                                                  0xFF0052C8,
                                                                ),
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Container(
                                                    width: double.infinity,
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                          15,
                                                          14,
                                                          10,
                                                          14,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                        0xFFF0EEFF,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            9,
                                                          ),
                                                      border: const Border(
                                                        left: BorderSide(
                                                          color: Color(
                                                            0xFF5138ED,
                                                          ),
                                                          width: 4,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          request.requestNo ==
                                                                      null ||
                                                                  request
                                                                      .requestNo!
                                                                      .isEmpty
                                                              ? 'GATE PASS REQUEST'
                                                              : 'REQUEST NO: ${request.requestNo}',
                                                          style:
                                                              const TextStyle(
                                                                color: Color(
                                                                  0xFF0052C8,
                                                                ),
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                request.reason ??
                                                                    'No reason provided',
                                                                style:
                                                                    const TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      height:
                                                                          1.45,
                                                                    ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  if (isExpanded) {
                                                                    expandedRequestIds
                                                                        .remove(
                                                                          requestId,
                                                                        );
                                                                  } else {
                                                                    expandedRequestIds
                                                                        .add(
                                                                          requestId,
                                                                        );
                                                                  }
                                                                });
                                                              },
                                                              child: AnimatedRotation(
                                                                turns:
                                                                    isExpanded
                                                                    ? 0.5
                                                                    : 0,
                                                                duration:
                                                                    const Duration(
                                                                      milliseconds:
                                                                          250,
                                                                    ),
                                                                child: const Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down_rounded,
                                                                  size: 24,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        Text(
                                                          '$formattedDate'
                                                          '${dayName.isEmpty ? '' : ' $dayName'}',
                                                          style:
                                                              const TextStyle(
                                                                color: Color(
                                                                  0xFF0052C8,
                                                                ),
                                                                fontSize: 10,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  AnimatedSize(
                                                    duration: const Duration(
                                                      milliseconds: 250,
                                                    ),
                                                    child: isExpanded
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets.fromLTRB(
                                                                  10,
                                                                  16,
                                                                  10,
                                                                  2,
                                                                ),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      const Text(
                                                                        'Pickup by',
                                                                        style: TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                          fontSize:
                                                                              10,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            7,
                                                                      ),
                                                                      Text(
                                                                        request.pickupPersonName ??
                                                                            '-',
                                                                        style: const TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      const Text(
                                                                        'Relation',
                                                                        style: TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                          fontSize:
                                                                              10,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            7,
                                                                      ),
                                                                      Text(
                                                                        request.pickupPersonRelation ??
                                                                            '-',
                                                                        style: const TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      const Text(
                                                                        'Mobile Number',
                                                                        style: TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                          fontSize:
                                                                              10,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            7,
                                                                      ),
                                                                      Text(
                                                                        request.pickupPersonMobile ??
                                                                            '-',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : const SizedBox.shrink(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                    bottom: Radius.circular(18),
                                                  ),
                                              child: SizedBox(
                                                height: 52,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Material(
                                                        color: const Color(
                                                          0xFF0758C9,
                                                        ),
                                                        child: InkWell(
                                                          onTap: isUpdating
                                                              ? null
                                                              : () {
                                                                  if (request.id ==
                                                                          null ||
                                                                      AppData.accYear ==
                                                                          null ||
                                                                      AppData.userId ==
                                                                          null) {
                                                                    ScaffoldMessenger.of(
                                                                        context,
                                                                      )
                                                                      ..hideCurrentSnackBar()
                                                                      ..showSnackBar(
                                                                        const SnackBar(
                                                                          content: Text(
                                                                            'Required gate pass data is unavailable',
                                                                          ),
                                                                        ),
                                                                      );
                                                                    return;
                                                                  }

                                                                  final now =
                                                                      DateTime.now();

                                                                  final dateTime =
                                                                      '${now.year.toString().padLeft(4, '0')}-'
                                                                      '${now.month.toString().padLeft(2, '0')}-'
                                                                      '${now.day.toString().padLeft(2, '0')} '
                                                                      '${now.hour.toString().padLeft(2, '0')}:'
                                                                      '${now.minute.toString().padLeft(2, '0')}:'
                                                                      '${now.second.toString().padLeft(2, '0')}';

                                                                  final hour =
                                                                      now.hour ==
                                                                          0
                                                                      ? 12
                                                                      : now.hour >
                                                                            12
                                                                      ? now.hour -
                                                                            12
                                                                      : now.hour;

                                                                  final time =
                                                                      '${hour.toString().padLeft(2, '0')}:'
                                                                      '${now.minute.toString().padLeft(2, '0')} '
                                                                      '${now.hour >= 12 ? 'PM' : 'AM'}';

                                                                  setState(() {
                                                                    updatingRequestId =
                                                                        request
                                                                            .id;
                                                                    updatingStatus =
                                                                        'Approved';
                                                                  });

                                                                  context
                                                                      .read<
                                                                        GatepassCubit
                                                                      >()
                                                                      .updateGatePass(
                                                                        UpdateGatePassParameter(
                                                                          accYear:
                                                                              AppData.accYear!,
                                                                          admno:
                                                                              request.admno ??
                                                                              '',
                                                                          requestDate:
                                                                              request.requestDate ??
                                                                              '',
                                                                          earlyLeaveData:
                                                                              request.requestDate ??
                                                                              '',
                                                                          leaveTime:
                                                                              time,
                                                                          reason:
                                                                              request.reason ??
                                                                              '',
                                                                          pickupPersonName:
                                                                              request.pickupPersonName ??
                                                                              '',
                                                                          pickupPersonMobile:
                                                                              request.pickupPersonMobile ??
                                                                              '',
                                                                          pickupPersonRelation:
                                                                              request.pickupPersonRelation ??
                                                                              '',
                                                                          teacherStatus:
                                                                              'Approved',
                                                                          teacherRemarks:
                                                                              '',
                                                                          teacherApprovedAt:
                                                                              dateTime,
                                                                          requestNo:
                                                                              request.requestNo ??
                                                                              '',
                                                                          modifiedUser: AppData
                                                                              .userId
                                                                              .toString(),
                                                                          branchId:
                                                                              1,
                                                                          finalStatus:
                                                                              'Approved',
                                                                        ),
                                                                        request
                                                                            .id!,
                                                                      );
                                                                },
                                                          child: Center(
                                                            child:
                                                                isUpdating &&
                                                                    updatingStatus ==
                                                                        'Approved'
                                                                ? const SizedBox(
                                                                    width: 20,
                                                                    height: 20,
                                                                    child: CircularProgressIndicator(
                                                                      strokeWidth:
                                                                          2,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  )
                                                                : const Text(
                                                                    'Approve',
                                                                    style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 1,
                                                      color: Colors.white,
                                                    ),
                                                    Expanded(
                                                      child: Material(
                                                        color: const Color(
                                                          0xFFFF7774,
                                                        ),
                                                        child: InkWell(
                                                          onTap: isUpdating
                                                              ? null
                                                              : () {
                                                                  if (request.id ==
                                                                          null ||
                                                                      AppData.accYear ==
                                                                          null ||
                                                                      AppData.userId ==
                                                                          null) {
                                                                    ScaffoldMessenger.of(
                                                                        context,
                                                                      )
                                                                      ..hideCurrentSnackBar()
                                                                      ..showSnackBar(
                                                                        const SnackBar(
                                                                          content: Text(
                                                                            'Required gate pass data is unavailable',
                                                                          ),
                                                                        ),
                                                                      );
                                                                    return;
                                                                  }

                                                                  final now =
                                                                      DateTime.now();

                                                                  final dateTime =
                                                                      '${now.year.toString().padLeft(4, '0')}-'
                                                                      '${now.month.toString().padLeft(2, '0')}-'
                                                                      '${now.day.toString().padLeft(2, '0')} '
                                                                      '${now.hour.toString().padLeft(2, '0')}:'
                                                                      '${now.minute.toString().padLeft(2, '0')}:'
                                                                      '${now.second.toString().padLeft(2, '0')}';

                                                                  final hour =
                                                                      now.hour ==
                                                                          0
                                                                      ? 12
                                                                      : now.hour >
                                                                            12
                                                                      ? now.hour -
                                                                            12
                                                                      : now.hour;

                                                                  final time =
                                                                      '${hour.toString().padLeft(2, '0')}:'
                                                                      '${now.minute.toString().padLeft(2, '0')} '
                                                                      '${now.hour >= 12 ? 'PM' : 'AM'}';

                                                                  setState(() {
                                                                    updatingRequestId =
                                                                        request
                                                                            .id;
                                                                    updatingStatus =
                                                                        'Rejected';
                                                                  });

                                                                  context
                                                                      .read<
                                                                        GatepassCubit
                                                                      >()
                                                                      .updateGatePass(
                                                                        UpdateGatePassParameter(
                                                                          accYear:
                                                                              AppData.accYear!,
                                                                          admno:
                                                                              request.admno ??
                                                                              '',
                                                                          requestDate:
                                                                              request.requestDate ??
                                                                              '',
                                                                          earlyLeaveData:
                                                                              request.requestDate ??
                                                                              '',
                                                                          leaveTime:
                                                                              time,
                                                                          reason:
                                                                              request.reason ??
                                                                              '',
                                                                          pickupPersonName:
                                                                              request.pickupPersonName ??
                                                                              '',
                                                                          pickupPersonMobile:
                                                                              request.pickupPersonMobile ??
                                                                              '',
                                                                          pickupPersonRelation:
                                                                              request.pickupPersonRelation ??
                                                                              '',
                                                                          teacherStatus:
                                                                              'Rejected',
                                                                          teacherRemarks:
                                                                              '',
                                                                          teacherApprovedAt:
                                                                              dateTime,
                                                                          requestNo:
                                                                              request.requestNo ??
                                                                              '',
                                                                          modifiedUser: AppData
                                                                              .userId
                                                                              .toString(),
                                                                          branchId:
                                                                              1,
                                                                          finalStatus:
                                                                              'Rejected',
                                                                        ),
                                                                        request
                                                                            .id!,
                                                                      );
                                                                },
                                                          child: Center(
                                                            child:
                                                                isUpdating &&
                                                                    updatingStatus ==
                                                                        'Rejected'
                                                                ? const SizedBox(
                                                                    width: 20,
                                                                    height: 20,
                                                                    child: CircularProgressIndicator(
                                                                      strokeWidth:
                                                                          2,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  )
                                                                : const Text(
                                                                    'Reject',
                                                                    style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
