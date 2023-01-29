import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karyawan_list/database/db_helper.dart';
import 'package:karyawan_list/models/model.dart';
import 'package:http/http.dart' as http;

class KaryawanProvider with ChangeNotifier {
  List<KaryawanModel> _items = [
    // KaryawanModel(
    //   nik: '3125',
    //   nama: 'Abit',
    //   umur: 32,
    //   kota: 'Jakarta',
    // ),
    // KaryawanModel(
    //   nik: '321521',
    //   nama: 'Joko',
    //   umur: 21,
    //   kota: 'Jambir',
    // ),
  ];
  List<KaryawanModel> get items => _items;

  Future<void> fetchData() async {
    final url = Uri.parse('http://103.146.244.206:600/b7/datadummy.php');
    final response = await http.get(url);
    final extractData = jsonDecode(response.body);
    // print(extractData['data'][0]['nik']);
    final extractDataIndex = extractData['data'] as List;
    // print(extractDataIndex);
    
    extractDataIndex.map((element) {
      DBHelper.createList(KaryawanModel.fromJson(element),);
    }).toList();

    // List<KaryawanModel> loadedKaryawan = [];
    // final loadedKaryawan = extractDataIndex.map((e) {
    //   return KaryawanModel(
    //     nik: e['nik'],
    //     nama: e['nama'],
    //     umur: e['umur'],
    //     kota: e['kota'],
    //   );
    // }).toList();
    
    // extractData.forEach((key, value) {
    //   loadedKaryawan.add(
    //     KaryawanModel(
    //       nik: value[0],
    //       nama: value['data']['nama'],
    //       umur: value['data']['umur'],
    //       kota: value['data']['kota'],
    //     ),
    //   );
    // });
    
    // _items = loadedKaryawan;
    notifyListeners();
  }
}
