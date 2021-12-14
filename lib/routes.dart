import 'package:coffee_shop/screens/address/address_screen.dart';
import 'package:coffee_shop/screens/cart/cart_screen.dart';
import 'package:coffee_shop/screens/checkout/checkout_screen.dart';
import 'package:coffee_shop/screens/contact_us/contact_us_screen.dart';
import 'package:coffee_shop/screens/enter_code.dart';
import 'package:coffee_shop/screens/favourite_product/favourite_product_screen.dart';
import 'package:coffee_shop/screens/google_map_screen.dart';
import 'package:coffee_shop/screens/home/home_screen.dart';
import 'package:coffee_shop/screens/loading/loading_screen.dart';
import 'package:coffee_shop/screens/more/more_screen.dart';
import 'package:coffee_shop/screens/notification/notification.dart';
import 'package:coffee_shop/screens/notification/notification_detail_screen.dart';
import 'package:coffee_shop/screens/order/order_screeen.dart';
import 'package:coffee_shop/screens/otp/otp_screen.dart';
import 'package:coffee_shop/screens/password/change_password/change_password.dart';
import 'package:coffee_shop/screens/password/enter_password/enter_password.dart';
import 'package:coffee_shop/screens/password/forgot_password/forgot_password_screen.dart';
import 'package:coffee_shop/screens/password/new_password/new_password_screen.dart';
import 'package:coffee_shop/screens/product_detail/product_detail_screen.dart';
import 'package:coffee_shop/screens/profile/profile_screen.dart';
import 'package:coffee_shop/screens/search/search_screen.dart';
import 'package:coffee_shop/screens/sign_in/sign_in_screen.dart';
import 'package:coffee_shop/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  NotificationScreen.routeName: (context) => NotificationScreen(),
  NotificationDetailScreen.routeName: (context) => NotificationDetailScreen(),
  'enterCode': (context) => EnterCodeScreen(),
  CheckoutScreen.routeName: (context) => CheckoutScreen(),
  SearchScreen.routeName: (context) => SearchScreen(),
  ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  LoadingScreen.routeName: (context) => LoadingScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  OTPScreen.routeName: (context) => OTPScreen(),
  MoreScreen.routeName: (context) => MoreScreen(),
  FavouriteProductScreen.routeName: (context) => FavouriteProductScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  AddressScreen.routeName: (context) => AddressScreen(),
  NewPasswordScreen.routeName: (context) => NewPasswordScreen(),
  OrderScreen.routeName: (context) => OrderScreen(),
  GoogleMapScreen.routeName: (context) => GoogleMapScreen(),
  ChangePassword.routeName: (context) => ChangePassword(),
  EnterPassword.routeName: (context) => EnterPassword(),
  ContactUsScreen.routeName: (context) => ContactUsScreen(),
};
