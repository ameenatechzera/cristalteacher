import 'package:cristalteacher/features/authentication/domain/entities/class_details_entity.dart';
import 'package:flutter/material.dart';

class AppData {
  static String appVersion =
      '2.2'; //extra 1 not passing issue (formtype) fixed 05-02-2026
  static String? admissionNo;
  static String? studentName;
  static String? studentStdId;
  static String? studentDivId;
  static String? accYear;
  static String? dob;
  static String? profileUrl;
  static String? gender;
  static String? schoolName;
  // Simple global state manager
  static ValueNotifier<bool> showDeleteButtonNotifier = ValueNotifier(false);
  //final deleteButtonNotifier = ValueNotifier<bool>(false);
  static String? branchName;
  static String? logo;
  static String? place;
  static String? studentClass;
  static int? branchId;
  static bool feeCollectionStatus = false;
  static int? employeeId;
  static int? userId;
  static String? teacherName;
  // Complete teacher-specific tutorship data.
  static List<TutorshipClass> tutorshipClasses = [];

  // Standards available to the logged-in teacher.
  static List<TutorshipClass> standards = [];

  static bool get hasTutorshipData {
    return tutorshipClasses.isNotEmpty || standards.isNotEmpty;
  }

  static void clearTutorshipData() {
    tutorshipClasses = [];
    standards = [];
  }

  static void clearUserData() {
    accYear = null;
    employeeId = null;
    userId = null;
    branchId = null;
    teacherName = null;

    clearTutorshipData();
  }
}
