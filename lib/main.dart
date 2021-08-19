import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splasha/screens/address_look_up.dart';
import 'package:splasha/screens/checkoutmethodcard.dart';
import 'package:splasha/screens/favourites_page.dart';
import 'package:splasha/screens/home_page.dart';
import 'package:splasha/screens/login_screen.dart';
import 'package:splasha/screens/product_selection_screen.dart';
import 'package:splasha/screens/registration_screen.dart';
import 'package:splasha/screens/sorry_screen.dart';
import 'package:splasha/screens/welcome_screen.dart';
import 'package:splasha/services/auth_wrapper.dart';
import 'package:splasha/services/authentication_service.dart';
import 'screens/main_page.dart';
import 'package:splasha/screens/booking_screen.dart';
import 'screens/checkout_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_)=>AuthenticationService(),
        ),
        StreamProvider(
            create:(context)=>context.read<AuthenticationService>().authStateChanges, initialData: null, ),
        ChangeNotifierProvider<SelectedTime>(
          create: (context) => SelectedTime(),
        ),
        ChangeNotifierProvider<SelectedDate>(
          create: (context) => SelectedDate(),
        ),
        ChangeNotifierProvider<SelectedAddress>(
          create: (context) => SelectedAddress(),
        ),
        ChangeNotifierProvider<SelectedCity>(
          create: (context) => SelectedCity(),
        ),
        ChangeNotifierProvider<SelectedZipCode>(
          create: (context) => SelectedZipCode(),
        ),
        ChangeNotifierProvider<SelectedStreet>(
          create: (context) => SelectedStreet(),
        ),
        ChangeNotifierProvider<SelectedStreetNumber>(
          create: (context) => SelectedStreetNumber(),
        ),
        ChangeNotifierProvider<SelectedEmail>(
          create: (context) => SelectedEmail(),
        ),
        ChangeNotifierProvider<SelectedWashType>(
          create: (context) => SelectedWashType(),
        ),
        ChangeNotifierProvider<SelectedVehicleType>(
          create: (context) => SelectedVehicleType(),
        ),
        ChangeNotifierProvider<SelectedPrice>(
          create: (context) => SelectedPrice(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: 'authentication_wrapper',
        routes: {
          'main_page': (context) => MainPage(),
          'product_selection_screen': (context) => ProductSelectionScreen(),
          'booking_screen': (context) => BookingScreen(),
          'checkout_screen': (context) => CheckoutScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          'address_screen': (context) => AddressScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          'checkoutMethodCard': (context) => CheckoutMethodCard(),
          'sorry_screen': (context) => SorryScreen(),
          'authentication_wrapper': (context) => AuthenticationWrapper(),
        },
      ),
    );
  }
}
