import 'dart:async';

import 'package:flutter/material.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({super.key});

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  static const Color primaryColor = Color(0xFF5842E3);
  static const Color backgroundColor = Color(0xFFFAF8FF);

  int selectedDay = 0;
  Duration remaining = const Duration(minutes: 9, seconds: 3);
  Timer? timer;

  final List<DayItem> days = const [
    DayItem('M', '10'),
    DayItem('Tu', '11'),
    DayItem('W', '12'),
    DayItem('Th', '13'),
    DayItem('F', '14'),
    DayItem('S', '15'),
  ];

  final List<ClassItem> classes = const [
    ClassItem(
      time: '09:00 AM',
      period: '2',
      subject: 'Mathematics',
      division: '10 D',
      color: Color(0xFF63D795),
    ),
    ClassItem(
      time: '10:00 AM',
      period: '3',
      subject: 'Mathematics',
      division: '10 D',
      color: Color(0xFF5672FF),
      isOngoing: true,
    ),
    ClassItem(
      time: '01:00 PM',
      period: '4',
      subject: 'Mathematics',
      division: '10 D',
      color: Color(0xFFFFA142),
    ),
    ClassItem(
      time: '03:00 PM',
      period: '1',
      subject: 'Mathematics',
      division: '10 D',
      color: Color(0xFF5672FF),
    ),
  ];

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;

      if (remaining.inSeconds <= 0) {
        timer?.cancel();
        return;
      }

      setState(() {
        remaining -= const Duration(seconds: 1);
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String get countdown {
    final String hours = remaining.inHours.toString().padLeft(2, '0');

    final String minutes = (remaining.inMinutes % 60).toString().padLeft(
      2,
      '0',
    );

    final String seconds = (remaining.inSeconds % 60).toString().padLeft(
      2,
      '0',
    );

    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildDateSelector(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(18, 26, 18, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle(text: 'Next Class'),
                    const SizedBox(height: 13),
                    _buildNextClassCard(),
                    const SizedBox(height: 28),
                    const SectionTitle(text: 'Upcoming Classes'),
                    const SizedBox(height: 20),
                    _buildTimeline(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 70,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.maybePop(context),
            padding: const EdgeInsets.all(12),
            icon: const Icon(Icons.arrow_back, size: 24),
          ),
          const Expanded(
            child: Text(
              'Time Table',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chevron_left, size: 26),
          ),
          const Text(
            'JAN 2025',
            style: TextStyle(
              color: primaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chevron_right, size: 26),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      height: 78,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(23),
        boxShadow: const [
          BoxShadow(
            color: Color(0x285842E3),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: List.generate(days.length, (index) {
          final bool isSelected = index == selectedDay;

          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                setState(() {
                  selectedDay = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      days[index].day,
                      style: TextStyle(
                        color: isSelected ? primaryColor : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      days[index].date,
                      style: TextStyle(
                        color: isSelected ? primaryColor : Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNextClassCard() {
    const Color accentColor = Color(0xFFFFA142);

    return CardShell(
      accentColor: accentColor,
      child: Row(
        children: [
          _buildPeriodBox('4', accentColor),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mathematics - 09 D',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 11),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 17, color: Color(0xFF55515C)),
                    SizedBox(width: 7),
                    Flexible(
                      child: Text(
                        '01:00 AM To 02:00 AM',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF55515C),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                countdown,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              const Text('Left', style: TextStyle(fontSize: 9)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Column(
      children: List.generate(classes.length, (index) {
        final ClassItem item = classes[index];
        final bool isLastItem = index == classes.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 74,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 14,
                      left: 0,
                      child: Text(
                        item.time,
                        style: const TextStyle(
                          fontSize: 9,
                          color: Color(0xFFAAA6AE),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 59,
                      top: 18,
                      bottom: isLastItem ? 18 : -10,
                      child: Container(
                        width: 2,
                        color: item.color.withOpacity(0.65),
                      ),
                    ),
                    Positioned(
                      left: 55,
                      top: 14,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: item.color, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: ClassCard(
                    item: item,
                    periodBox: _buildPeriodBox(item.period, item.color),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPeriodBox(String period, Color color) {
    return Container(
      width: 52,
      height: 60,
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Per',
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            period,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class ClassCard extends StatelessWidget {
  const ClassCard({super.key, required this.item, required this.periodBox});

  final ClassItem item;
  final Widget periodBox;

  @override
  Widget build(BuildContext context) {
    return CardShell(
      accentColor: item.color,
      child: Row(
        children: [
          periodBox,
          const SizedBox(width: 17),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.subject,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: item.isOngoing
                        ? const Color(0xFF242129)
                        : const Color(0xFF97939C),
                    fontSize: 15,
                    fontWeight: item.isOngoing
                        ? FontWeight.w600
                        : FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    Text(
                      item.division,
                      style: const TextStyle(
                        color: Color(0xFF5138ED),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (item.isOngoing) ...[
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD8D8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Ongoing',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardShell extends StatelessWidget {
  const CardShell({super.key, required this.accentColor, required this.child});

  final Color accentColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: const [
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 13,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(11),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    );
  }
}

class DayItem {
  const DayItem(this.day, this.date);

  final String day;
  final String date;
}

class ClassItem {
  const ClassItem({
    required this.time,
    required this.period,
    required this.subject,
    required this.division,
    required this.color,
    this.isOngoing = false,
  });

  final String time;
  final String period;
  final String subject;
  final String division;
  final Color color;
  final bool isOngoing;
}
