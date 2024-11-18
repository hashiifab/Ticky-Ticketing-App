import 'package:flutter/material.dart';
import 'package:train_ticket_buying_app/module/myticket/my_ticket_view.dart';
import 'package:train_ticket_buying_app/module/search/search_view.dart';
import 'package:train_ticket_buying_app/module/user/user_view.dart';
import '../../dashboard/view/dashboard_view.dart';
import '../../../state_util.dart';
import '../view/main_navigation_view.dart';

class MainNavigationController extends State<MainNavigationView>
    implements MvcController {
  static late MainNavigationController instance;
  late MainNavigationView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  int selectedIndex = 0;

  updateIndex(int newIndex) {
    selectedIndex = newIndex;
    setState(() {});
  }

  Widget getSelectedPage() {
    switch (selectedIndex) {
      case 0:
        return const DashboardView();
      case 1:
        return const SearchView();
      case 2:
        return const MyTicketView();
      case 3:
        return const UserView();
      default:
        return const DashboardView();
    }
  }
}
