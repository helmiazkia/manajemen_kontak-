import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../services/database_helper.dart';

class AddEditContactScreen extends StatefulWidget {
  final Contact? contact;
  final VoidCallback? onSave;

  AddEditContactScreen({this.contact, this.onSave});

  @override
  _AddEditContactScreenState createState() => _AddEditContactScreenState();
}

class _AddEditContactScreenState extends State<AddEditContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      _nameController.text = widget.contact!.name;
      _phoneController.text = widget.contact!.phoneNumber;
      _emailController.text = widget.contact!.email ?? '';
    }
  }

  Future<void> _saveContact() async {
    if (_formKey.currentState!.validate()) {
      final contact = Contact(
        id: widget.contact?.id,
        name: _nameController.text,
        phoneNumber: _phoneController.text,
        email: _emailController.text,
      );

      if (widget.contact == null) {
        await DatabaseHelper.instance.addContact(contact);
      } else {
        await DatabaseHelper.instance.updateContact(contact);
      }

      if (widget.onSave != null) {
        widget.onSave!();
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) =>
                    value!.isEmpty ? 'Nama harus diisi' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Nomor Telepon'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Nomor telepon harus diisi' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email (Opsional)'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                // simpat
                onPressed: _saveContact,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Warna latar belakang tombol
                  foregroundColor: Colors.white, // Warna teks pada tombol
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 15), // Padding tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Membuat sudut tombol melengkung
                  ),
                  elevation: 5, // Efek bayangan tombol
                ),
                child: Text(
                  widget.contact == null ? 'Simpan' : 'Perbarui',
                  style: TextStyle(
                    fontSize: 16, // Ukuran teks
                    fontWeight: FontWeight.bold, // Teks tebal
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
