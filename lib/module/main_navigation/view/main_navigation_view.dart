import 'package:flutter/material.dart';
import 'package:train_ticket_buying_app/module/myticket/my_ticket_view.dart';
import 'package:train_ticket_buying_app/module/search/search_view.dart';
import 'package:train_ticket_buying_app/module/user/user_view.dart';
import '../../dashboard/view/dashboard_view.dart';
import '../controller/main_navigation_controller.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({Key? key}) : super(key: key);

  Widget build(context, MainNavigationController controller) {
    controller.view = this;

    return DefaultTabController(
      length: 4,
      initialIndex: controller.selectedIndex,
      child: Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex,
          children: const [
            DashboardView(),
            SearchView(),
            MyTicketView(),
            UserView(),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              currentIndex: controller.selectedIndex,
              onTap: (newIndex) => controller.updateIndex(newIndex),
              showSelectedLabels: true,
              elevation: 0.0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 30.0,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    size: 30.0,
                  ),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.confirmation_num,
                    size: 30.0,
                  ),
                  label: "My Tickets",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 30.0,
                  ),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<MainNavigationView> createState() => MainNavigationController();
}
