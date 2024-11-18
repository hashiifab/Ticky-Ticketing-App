import 'package:flutter/material.dart';
import '../../../state_util.dart';
import '../view/dashboard_view.dart';

class DashboardController extends State<DashboardView> implements MvcController {
  static late DashboardController instance;
  late DashboardView view;

  // Variables for passenger count
  int qtyAdult = 0;
  int qtyChild = 0;

  // Travel option variable (1: One Way, 2: Round Trip, 3: Multiple City)
  String travelOption = '1'; // Default is 'One Way'
  int cityCount = 1; // Number of cities for "Multiple Cities" option

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  // Increment and decrement methods for adults
  void incrementAdult() {
    setState(() {
      qtyAdult = qtyAdult + 1;
    });
  }

  void decrementAdult() {
    setState(() {
      if (qtyAdult > 0) {
        qtyAdult = qtyAdult - 1;
      }
    });
  }

  // Increment and decrement methods for children
  void incrementChild() {
    setState(() {
      qtyChild = qtyChild + 1;
    });
  }

  void decrementChild() {
    setState(() {
      if (qtyChild > 0) {
        qtyChild = qtyChild - 1;
      }
    });
  }

  // Method to update travel option (One Way, Round Trip, Multiple City)
  void updateTravelOption(String value) {
    setState(() {
      travelOption = value;
      if (value == '3') {
        // If "Multiple City" is selected, allow user to select more cities
        cityCount = 3; // Or any number based on your requirement
      } else {
        // Reset to 1 city for One Way or Round Trip
        cityCount = 1;
      }
    });
  }
}
