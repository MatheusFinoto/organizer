// import 'package:another_flushbar/flushbar.dart';
// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:organizer/src/utils/theme.dart';

MaskTextInputFormatter cpfMaskFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});

MaskTextInputFormatter cnpjMaskFormatter = MaskTextInputFormatter(
    mask: '##.###.###/####-##', filter: {"#": RegExp(r'[0-9]')});

MaskTextInputFormatter cepMask = MaskTextInputFormatter(
  mask: '#####-###',
  filter: {"#": RegExp(r'[0-9]')},
);

MaskTextInputFormatter birthDateMask = MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {"#": RegExp(r'[0-9]')},
);

BoxDecoration customDecoration(context, {Color? color}) {
  return BoxDecoration(
    color: color,
    border: Border.all(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[300]!
            : Colors.black45,
        width: 0.5),
    borderRadius: BorderRadius.circular(10),
  );
}

enum HttpStatus { none, loading, success, fail, error }

const String profileImage =
    "https://images.unsplash.com/photo-1531891437562-4301cf35b7e4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80";

const String lorem =
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.';

// const String key = "C8CD500ADCF9487DB2954E51A5D3902E";
// const String secret =
//     "U2FsdGVkX19x956ljeR7Td+lOMDgByPkm6chBPllZ+FW2GDEmUo64wTkcMHPafMrLAgyulsiF9B5uJ5BVmP/6AxuIl0uFmX+onhs5Q2vX4pTkQtiHUpnO1jAcQNpdcsicfmyl11rwxxVg2qYGVDyMibmU6pNBq087++YQ8dj65g=";

const String key = "2651894BB4CD4A968533F822295588F0";
const String secret =
    "U2FsdGVkX18nsJetUeBiKdNBSclq6qrokVXdQPSkLEY8Ms74yU1CdmeDmh2PKeXwBDgNVv+qOuE5R7yzGzIRDnGOGOv1ctRAEo6yNOvID86VH/UnT5TP1vej3ADnEGddvxDj5mialZLo3QjSaj0IEwO3Zu3UR2jp73A/NonGgws=";

Future<dynamic> generateToken({required String body}) async {
  var bodyHash = sha256.convert(utf8.encode(body));

  final jwt = JWT(
    {
      "iss": key,
      "exp": DateTime.now().microsecondsSinceEpoch + 3600,
      "iat": DateTime.now().toString(),
      "hash": bodyHash.toString()
    },
  );
  var convert = jwt.sign(SecretKey(secret));
  return convert;
}

Future<String> convertImageToBase64({required File fileImage}) async {
  final bytes = File(fileImage.path).readAsBytesSync();
  String base64 = base64Encode(bytes);
  return base64;
}

Map<String, String> generateHeader({required String token}) {
  Map<String, String> header = {
    "Access-Control-Allow-Origin": "*",
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
    "Access-Control-Allow-Headers":
        "Origin, X-Requested-With, Content-Type, Accept",
    "Authorization": "Bearer $token",
  };
  return header;
}

Future<void> customFlushBar(
    {required String title,
    required String message,
    required Color color,
    required BuildContext context}) async {
  // ignore: avoid_single_cascade_in_expression_statements
  Flushbar(
    maxWidth: 350,
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(10),
    titleText: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
    messageText: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    duration: const Duration(seconds: 2),
    backgroundColor: color,
  )..show(context);
}

// DateFormat dateFormatBrl = DateFormat("dd.MM.yyyy");
DateFormat dateFormatEua = DateFormat("yyyy-MM-dd");

bool isDate(String input, String format) {
  try {
    final DateTime d = DateFormat(format).parseStrict(input);
    return true;
  } catch (e) {
    return false;
  }
}

String dateFormatEuaDate({required String date}) {
  var inputFormat = DateFormat('dd/MM/yyyy');
  var inputDate = inputFormat.parse(date).toLocal();
  var outputFormat = DateFormat('yyyy-MM-dd');
  return outputFormat.format(inputDate);
}

String dateFormatBrlComplete({required String date}) {
  var inputFormat = DateFormat('yyyy-MM-dd HH:mmZ');
  var inputDate = inputFormat.parse(date, true).toLocal();
  var outputFormat = DateFormat('HH:mm dd/MM/yyyy');
  return outputFormat.format(inputDate);
}

String dateFormatBrlTime({required String date}) {
  var inputFormat = DateFormat('yyyy-MM-ddTHH:mmZ');
  var inputDate = inputFormat.parse(date).toLocal();
  var outputFormat = DateFormat('HH:mm');
  return outputFormat.format(inputDate);
}

String dateFormatBrlDate({required String date}) {
  var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
  var inputDate = inputFormat.parse(date);
  var outputFormat = DateFormat('dd/MM/yyyy');
  return outputFormat.format(inputDate);
}

late var products = [
  'Sacola',
  'Ct de Visita',
  'Panfleto',
  'Cx de Pizza',
  'Calendário'
];

var appBarHeight = AppBar().preferredSize.height;

Color randomColor() {
  List colorList = [
    blue500,
    blue100,
    green200,
    green100,
  ];
  return colorList[Random().nextInt(colorList.length)];
}
