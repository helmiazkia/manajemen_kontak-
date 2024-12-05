import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../services/database_helper.dart';
import 'add_edit_contact_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Contact>> _contacts;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _loadContacts() {
    setState(() {
      _contacts = DatabaseHelper.instance.getContacts();
    });
  }

  void _deleteContact(int id) async {
    await DatabaseHelper.instance.deleteContact(id);
    _loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //judul pada contact
      appBar: AppBar(
        title: Padding(
          padding:
              const EdgeInsets.all(10.0), // Tambahkan padding di sekitar teks
          child: Text(
            "Manajemen Kontak",
            style: TextStyle(
              color: Colors.white, // Warna teks putih
              fontWeight: FontWeight.bold, // Teks tebal
              fontSize: 20, // Ukuran font lebih besar
            ),
          ),
        ),
        centerTitle: true, // Memposisikan judul di tengah
        backgroundColor: Colors.blue, // Warna latar belakang AppBar biru
        elevation: 5, // Memberikan bayangan pada AppBar
      ),
      body: FutureBuilder<List<Contact>>(
        future: _contacts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(child: Text('Belum ada kontak.'));
          } else {
            final contacts = snapshot.data!;
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 5,
                  color: const Color.fromARGB(255, 174, 211, 240),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Informasi Kontak
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              contact.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              contact.phoneNumber,
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ],
                        ),

                        // Tombol Edit dan Hapus
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                // Aksi saat tombol Edit ditekan
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddEditContactScreen(
                                      contact: contact,
                                      onSave: _loadContacts,
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // Aksi saat tombol Hapus ditekan
                                _deleteContact(contact.id!);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        //Tombol + atau tambah contact
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddEditContactScreen(onSave: _loadContacts),
          ),
        ),
        icon: Icon(Icons.add),
        label: Text("Tambah Kontak"),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
