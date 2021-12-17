import 'package:coffee_shop/models/address.dart';
import 'package:coffee_shop/models/api_response.dart';
import 'package:coffee_shop/models/user.dart';
import 'package:coffee_shop/screens/sign_in/sign_in_screen.dart';
import 'package:coffee_shop/services/user_service.dart' as sv;
import 'package:coffee_shop/services/user_service.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/values/api_end_point.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:coffee_shop/values/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user;
  List<dynamic> _addresses = [];
  bool _addressLoading = true;

  Map levelPoint = {
    LocaleKeys.new_text.tr(): 100, //lv0
    LocaleKeys.rank_bzone.tr(): 300, //lv1
    LocaleKeys.rank_silver.tr(): 600, //lv2
    LocaleKeys.rank_gold.tr(): 1000, //lv3
    LocaleKeys.rank_platinum.tr(): 3000 //lv4
  };

  //getter
  bool get isAuth => _user.token != null;
  List<dynamic> get addresses => _addresses;
  UserModel get getUser => _user;
  int get getUserId => _user.id;
  String get getToken => _user.token;
  bool get addressLoading => _addressLoading;
  //setter
  setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  setAddresses(List<dynamic> list) {
    _addresses = list;
    notifyListeners();
  }

  setAddressLoading(bool value) {
    _addressLoading = value;
    notifyListeners();
  }

  Future<String> fetAddresses() async {
    ApiResponse response = await sv.getUserAddresses();
    if (response.error == null) {
      setAddresses(response.data);
      notifyListeners();
      return null;
    }
    return response.error;
  }

  Future<int> updateAddress(BuildContext context,
      {AddressModel address, int id}) async {
    int result = -1;
    ApiResponse response = await sv.updateAddress(address: address, id: id);
    if (response.error == null) {
      int index = _addresses
          .indexOf(_addresses.firstWhere((element) => element.id == id));
      _addresses[index] = AddressModel(
        id: id,
        title: address.title,
        address: address.address,
        receiverName: address.receiverName,
        receiverPhone: address.receiverPhone,
        coordinates: address.coordinates,
        description: address.description,
      );

      result = id;
      notifyListeners();
    }
    if (response.error == unauthorized) {
      logout(context).then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => SignInScreen()),
                (route) => false)
          });
    } else {
      showToast(response.error);
    }
    return result;
  }

  Future<void> changePassword(BuildContext context,
      {String newPwd, String oldPwd}) async {
    final ApiResponse response =
        await sv.changePassword(newPwd: newPwd, oldPwd: oldPwd);
    if (response.error == null) {
      Navigator.of(context).pop();
      showToast(
          '${LocaleKeys.change_password.tr()} ${LocaleKeys.change_password.tr().toLowerCase()}',
          toastLength: Toast.LENGTH_LONG);
      logout(context);
    } else {
      showToast(response.error, toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<int> createAddress(BuildContext context,
      {AddressModel address}) async {
    int result = -1;
    ApiResponse response = await sv.createAddress(address: address);
    if (response.error == null) {
      _addresses.add(AddressModel(
          id: response.data,
          address: address.address,
          title: address.title,
          description: address.description,
          receiverName: address.receiverName,
          receiverPhone: address.receiverPhone,
          coordinates: address.coordinates));
      notifyListeners();
      result = response.data;
    } else {
      if (response.error == unauthorized) {
        logout(context).then((value) => {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                  (route) => false)
            });
      } else {
        showToast(response.error);
      }
    }

    return result;
  }

  Future<String> deleteAddress(int id) async {
    ApiResponse response = await sv.deleteAddress(id);
    if (response.error == null) {
      _addresses.removeWhere((element) => element.id == id);
      notifyListeners();
      return null;
    }
    return response.error;
  }

  updateUser(UserModel user) async {
    ApiResponse response = await sv.updateUser(
        image: user.image,
        displayName: user.displayName,
        email: user.email,
        gender: user.gender);
    if (response.error == null) {
      if (user.image != null) _user.image = user.image;
      if (user.displayName != null) _user.displayName = user.displayName;
      if (user.email != null) _user.email = user.email;
      if (user.gender != null) _user.gender = user.gender;
      showToast(LocaleKeys.update_profile_success.tr());
    } else {
      showToast(LocaleKeys.update_profile_fail.tr(),
          toastLength: Toast.LENGTH_LONG);
    }
    notifyListeners();
  }

  int caculateNextLevel() {
    for (var pts in levelPoint.values) {
      if (pts > _user.point) return pts - _user.point;
    }
    return 0;
  }

  String getLevelString({bool isNext = false}) {
    String oldKey = levelPoint.keys.first;
    bool flag = false;
    for (var key in levelPoint.keys) {
      if (flag == true) {
        return oldKey;
      }
      if (_user.point <= levelPoint[key]) {
        if (isNext == true) {
          flag = true;
        } else {
          return oldKey;
        }
      }
      oldKey = key;
    }
    return 'V.I.P';
  }

  Future<String> login({String phone, String password}) async {
    ApiResponse response = await sv.loginPhone(phone, password);
    if (response.error == null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final UserModel user = response.data as UserModel;
      setUser(user);

      pref.setString(PrefKey.TOKEN, user.token ?? '');
      pref.setInt(PrefKey.ID, user.id ?? 0);
      return null;
    }
    return response.error;
  }

  Future<bool> signup({UserModel user, String password}) async {
    ApiResponse response = await sv.register(
        displayName: user.displayName,
        email: user.email,
        phone: user.phone,
        birthday: user.birthday,
        password: password);
    if (response.error == null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final UserModel user = response.data as UserModel;
      setUser(user);
      pref.setString(PrefKey.TOKEN, user.token ?? '');
      pref.setInt(PrefKey.ID, user.id ?? 0);

      return true;
    }
    showToast(response.error, toastLength: Toast.LENGTH_LONG);
    return false;
  }
}
