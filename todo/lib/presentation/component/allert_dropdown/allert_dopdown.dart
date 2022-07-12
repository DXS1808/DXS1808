import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';

class AlertDropdown{
  static success(String success){
    AlertController.show("Success", success,TypeAlert.success );
  }
  static error(String error){
    return AlertController.show("Error", error,TypeAlert.error );
  }
}