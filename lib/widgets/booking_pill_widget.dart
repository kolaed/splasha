import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splasha/models/event_model.dart';
import 'package:splasha/screens/booking_screen.dart';
import 'package:splasha/screens/checkout_screen.dart';

class BookingPillWidget extends StatelessWidget {
  const BookingPillWidget({
    Key key,
    @required this.slots,
    @required this.color,
    @required this.width,
    @required this.selectedVehicleMake,
    @required this.selectedVehicleModel,
    @required this.selectedVehicleReg,
    @required this.formKey, this.formData,
  }) : super(key: key);

  final EventModel slots;
  final Color color;
  final double width;
  final String selectedVehicleMake;
  final String selectedVehicleModel;
  final String selectedVehicleReg;
  final GlobalKey<FormState> formKey;

  final Map<String,dynamic> formData;

  @override
  Widget build(BuildContext context) {



    return InkWell(
      onTap: () {
        if (formKey.currentState.validate()) {
          // If the form is valid, display a snackbar. In the real world,
          // you'd often call a server or save the information in a database.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CheckoutScreen();
              },
            ),
          );

        }
          formKey.currentState.save();
print(formData);


        Provider.of<SelectedTime>(context, listen: false)
            .changeString(slots.date.toString());
        Provider.of<SelectedDate>(context, listen: false)
            .changeString(slots.date.toString());
        Provider.of<SelectedVehicleMake>(context, listen: false)
            .changeString(formData['vehicleMake']);
        Provider.of<SelectedVehicleModel>(context, listen: false)
            .changeString(formData['vehicleModel']);
        Provider.of<SelectedVehicleReg>(context, listen: false)
            .changeString(formData['vehicleReg']);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        width: width / 4,
        child: Center(
          child: Text(slots.date.toString().substring(10, 16)),
        ),
      ),
    );
  }
}
