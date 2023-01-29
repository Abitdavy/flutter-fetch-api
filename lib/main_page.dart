import 'package:flutter/material.dart';
import 'package:karyawan_list/database/db_helper.dart';
import 'package:karyawan_list/models/model.dart';
import 'package:karyawan_list/provider/karyawan_provider.dart';
import 'package:karyawan_list/widget/add_karyawan.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _dependChange = true;

  @override
  void didChangeDependencies() {
    if (_dependChange) {
      Provider.of<KaryawanProvider>(context).fetchData();
    }
    _dependChange = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final karyawanItems = Provider.of<KaryawanProvider>(context, listen: false);
    // final karyawan = karyawanItems.items;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    scrollable: true,
                    title: Text('Delete data'),
                    content: Text('Are you sure want to delete all data?'),
                    actions: [
                      ElevatedButton(
                        onPressed: () async {
                          await DBHelper.deleteTable();
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                        child: Text('Yes'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('No'),
                      ),
                    ],
                  ),
                );
              } catch (e) {
                throw e;
              }
            },
            icon: Icon(
              Icons.delete_forever_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: DBHelper.readList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return snapshot.data!.isEmpty
              ? Center(
                  child: Text('No Karyawan List yet!'),
                )
              : ListView(
                  children: snapshot.data!
                      .map((element) => Card(
                        elevation: 5,
                        margin: EdgeInsets.all(12),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: ListTile(
                            leading: CircleAvatar(
                              // radius: 50,
                              backgroundImage:
                                  AssetImage('images/Avatar-img.png'),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  element.nama,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('NIK: ${element.nik}'),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Text('Umur: ${element.umur.toString()},'),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Kota: ${element.kota}')
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                await DBHelper.deleteList(element.id!);
                                setState(() {});
                              },
                              icon: Icon(Icons.delete),
                            ),
                            onTap: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => AddKaryawan(
                                    karyawan: KaryawanModel(
                                      id: element.id,
                                      nik: element.nik,
                                      nama: element.nama,
                                      umur: element.umur,
                                      kota: element.kota,
                                    ),
                                  ),
                                ),
                              );
                              setState(() {});
                            },
                          ),
                        ),
                      ))
                      .toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await Navigator.of(context).pushNamed(AddKaryawan.routeName);
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => AddKaryawan(),
          ));
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
