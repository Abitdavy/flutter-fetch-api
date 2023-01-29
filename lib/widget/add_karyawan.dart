import 'package:flutter/material.dart';
import 'package:karyawan_list/database/db_helper.dart';
import 'package:karyawan_list/models/model.dart';

class AddKaryawan extends StatefulWidget {
  static const routeName = '/add';

  AddKaryawan({Key? key, this.karyawan}) : super(key: key);

  final KaryawanModel? karyawan;

  @override
  State<AddKaryawan> createState() => _AddKaryawanState();
}

class _AddKaryawanState extends State<AddKaryawan> {
  final _nikController = TextEditingController();
  final _nameController = TextEditingController();
  final _umurController = TextEditingController();
  final _kotaController = TextEditingController();

  @override
  void initState() {
    if (widget.karyawan != null) {
      _nikController.text = widget.karyawan!.nik;
      _nameController.text = widget.karyawan!.nama;
      _umurController.text = widget.karyawan!.umur.toString();
      _kotaController.text = widget.karyawan!.kota;
    }
    super.initState();
  }

  @override
  void dispose() {
    _nikController.dispose();
    _nameController.dispose();
    _umurController.dispose();
    _kotaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.karyawan != null ? 'Edit Karyawan' : 'Add Karyawan'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(
            12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField(_nikController, 'NIK'),
              SizedBox(
                height: 20,
              ),
              _buildTextField(_nameController, 'Nama'),
              SizedBox(
                height: 20,
              ),
              _buildTextField(_umurController, 'Umur'),
              SizedBox(
                height: 20,
              ),
              _buildTextField(_kotaController, 'Kota'),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (widget.karyawan != null) {
                    await DBHelper.updateList(KaryawanModel(
                      id: widget.karyawan!.id,
                      nik: _nikController.text,
                      nama:_nameController.text,
                      umur: int.parse(_umurController.text),
                      kota: _kotaController.text,
                    ));
                    Navigator.of(context).pop();
                    print('data updated');
                  } else {
                    await DBHelper.createList(
                      KaryawanModel(
                        nik: _nikController.text,
                        nama: _nameController.text,
                        umur: int.parse(_umurController.text),
                        kota: _kotaController.text,
                      ),
                    );
                    Navigator.of(context).pop(true);
                  }
                },
                child: Text('Add to Karyawan List'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField _buildTextField(TextEditingController _controller, String hint) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: hint,
        hintText: hint,
        border: OutlineInputBorder(),
      ),
    );
  }
}
