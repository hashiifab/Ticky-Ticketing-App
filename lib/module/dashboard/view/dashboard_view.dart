import 'package:flutter/material.dart';
import 'package:train_ticket_buying_app/module/notification/notification.dart';
import '../../../shared/widgets/category_picker.dart';
import '../../../shared/widgets/datepicker.dart';
import '../../../shared/widgets/dropdown.dart';
import '../../../state_util.dart';
import '../../seat_picker/view/seat_picker_view.dart';
import '../controller/dashboard_controller.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  Widget build(context, DashboardController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hello, Hashiifab",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                Get.to(const NotificationView());
              },
              child: const Badge(
                backgroundColor: Colors.red,
                label: Text(
                  "4",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: Icon(Icons.notifications_outlined),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Book Your Ticket Today",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20.0),
              Theme(
                data: ThemeData.light(),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8.0,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      QCategoryPicker(
                        items: const [
                          {"label": "One Way", "value": "1"},
                          {"label": "Round - Trip", "value": "2"},
                          {"label": "Multiple City", "value": "3"},
                        ],
                        value: "1",
                        onChanged: (index, label, value, item) {
                          controller.updateTravelOption(value);
                        },
                      ),
                      const SizedBox(height: 16.0),
                      QDropdownField(
                        label: "From",
                        value: "Pati",
                        items: const [
                          {"label": "Pati", "value": "Pati"},
                          {"label": "Kudus", "value": "Kudus"},
                          {"label": "Semarang", "value": "Semarang"},
                          {"label": "Surabaya", "value": "Surabaya"},
                          {"label": "Jakarta", "value": "Jakarta"},
                          {"label": "Yogyakarta", "value": "Yogyakarta"},
                          {"label": "Bali", "value": "Bali"},
                          {"label": "Bandung", "value": "Bandung"}
                        ],
                        onChanged: (value, label) {},
                      ),
                      const SizedBox(height: 16.0),
                      QDropdownField(
                        label: "To",
                        value: "Kudus",
                        items: const [
                          {"label": "Pati", "value": "Pati"},
                          {"label": "Kudus", "value": "Kudus"},
                          {"label": "Semarang", "value": "Semarang"},
                          {"label": "Surabaya", "value": "Surabaya"},
                          {"label": "Jakarta", "value": "Jakarta"},
                          {"label": "Yogyakarta", "value": "Yogyakarta"},
                          {"label": "Bali", "value": "Bali"},
                          {"label": "Bandung", "value": "Bandung"}
                        ],
                        onChanged: (value, label) {},
                      ),
                      const SizedBox(height: 16.0),
                      _buildDateFields(controller),
                      const SizedBox(height: 16.0),
                      const Text(
                        "Passengers",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xff393e48),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      _buildPassengerControls(controller),
                      const SizedBox(height: 20.0),
                      QDropdownField(
                        label: "Train Classes",
                        value: "Executive",
                        items: const [
                          {"label": "Executive", "value": "Executive"},
                          {"label": "Business", "value": "Business"},
                          {"label": "Economy", "value": "Economy"}
                        ],
                        onChanged: (value, label) {},
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        height: 48.0,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFB30F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          onPressed: () => Get.to(const SeatPickerView()),
                          child: const Text(
                            "Continue",
                            style: TextStyle(
                              color: Color(0xff383d47),
                              fontSize: 16.0,
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
        ),
      ),
    );
  }

  Widget _buildDateFields(DashboardController controller) {
    if (controller.travelOption == '1') {
      return QDatePicker(
        label: "Depart",
        value: DateTime.now(),
        onChanged: (value) {},
      );
    } else if (controller.travelOption == '2') {
      return Row(
        children: [
          Expanded(
            child: QDatePicker(
              label: "Depart",
              value: DateTime.now(),
              onChanged: (value) {},
            ),
          ),
          const SizedBox(width: 16.0),
          const Text(
            "-",
            style: TextStyle(
              fontSize: 24.0,
              color: Color(0xff393e48),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: QDatePicker(
              label: "Return",
              value: DateTime.now(),
              onChanged: (value) {},
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: List.generate(controller.cityCount, (index) {
          return Column(
            children: [
              QDatePicker(
                label: "Departure City ${index + 1}",
                value: DateTime.now(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 16.0),
              QDropdownField(
                label: "From City ${index + 1}",
                value: "Pati",
                items: const [
                  {"label": "Pati", "value": "Pati"},
                  {"label": "Kudus", "value": "Kudus"},
                  {"label": "Semarang", "value": "Semarang"},
                  {"label": "Surabaya", "value": "Surabaya"},
                  {"label": "Jakarta", "value": "Jakarta"},
                  {"label": "Yogyakarta", "value": "Yogyakarta"},
                  {"label": "Bali", "value": "Bali"},
                  {"label": "Bandung", "value": "Bandung"}
                ],
                onChanged: (value, label) {},
              ),
              const SizedBox(height: 16.0),
            ],
          );
        }),
      );
    }
  }

  Widget _buildPassengerControls(DashboardController controller) {
    return Row(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => controller.decrementAdult(),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: (controller.qtyAdult == 0)
                      ? Colors.grey.shade300
                      : const Color(0xFFFFB30F),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Icon(
                  Icons.remove,
                  size: 20.0,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              "${controller.qtyAdult} Adult",
              style: const TextStyle(
                fontSize: 16.0,
                color: Color(0xff393e48),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10.0),
            InkWell(
              onTap: () => controller.incrementAdult(),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFB30F),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Icon(
                  Icons.add,
                  size: 20.0,
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            InkWell(
              onTap: () => controller.decrementChild(),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: (controller.qtyChild == 0)
                      ? Colors.grey.shade300
                      : const Color(0xFFFFB30F),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Icon(
                  Icons.remove,
                  size: 20.0,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              "${controller.qtyChild} Child",
              style: const TextStyle(
                fontSize: 16.0,
                color: Color(0xff393e48),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10.0),
            InkWell(
              onTap: () => controller.incrementChild(),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFB30F),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Icon(
                  Icons.add,
                  size: 20.0,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  State<DashboardView> createState() => DashboardController();
}
