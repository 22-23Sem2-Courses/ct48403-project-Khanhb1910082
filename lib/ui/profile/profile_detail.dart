import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/model/user.dart';
import 'package:myproject_app/ui/screen.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({super.key});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  final idUser = FirebaseAuth.instance.currentUser;
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  late Users updateUser;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cập nhật thông tin"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                _buidAvataField(width),
                _buildEmailField(),
                _buildAddressField(),
                _buildPhoneField(),
                _buildSubmitField(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildEmailField() {
    return TextFormField(
      enabled: false,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.email_rounded,
          color: Colors.pink,
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: FirebaseAuth.instance.currentUser!.email,
        hintStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
      ),
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.pink,
    );
  }

  _buildAddressField() {
    return TextFormField(
      controller: _addressController,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.store_mall_directory,
          color: Colors.pink,
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: "Địa chỉ nhận hàng",
        hintStyle: const TextStyle(color: Colors.black45),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
      ),
      keyboardType: TextInputType.streetAddress,
      cursorColor: Colors.pink,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập địa chỉ nhận hàng.";
        } else if (value.length < 10) {
          return 'Địa chỉ giao hàng gồm đường, quận/huyện, tỉnh.';
        }
        return null;
      },
      onSaved: (newValue) {
        updateUser = updateUser.copyWith(address: newValue);
      },
    );
  }

  _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.phone,
          color: Colors.pink,
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: "Số điện thoại",
        hintStyle: const TextStyle(color: Colors.black45),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
      ),
      keyboardType: TextInputType.phone,
      cursorColor: Colors.pink,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập số điện thoại.";
        }
        if (value.length < 9 || value.length > 14) {
          return 'Số điện thoại không hợp lệ.';
        }
        return null;
      },
      onSaved: (newValue) {
        updateUser = updateUser.copyWith(phone: newValue);
      },
    );
  }

  _buildSubmitField() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(idUser!.email)
              .update(
            {
              "address": _addressController.text.trim(),
              "phone": _phoneController.text.trim(),
            },
          );
          return;
        }

        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => ProfileView()));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 12),
      ),
      child: const Text(
        "Cập nhật",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buidAvataField(double width) {
    return InkWell(
      child: Container(
        width: width / 3.5,
        height: width / 3.5,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(width),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
                height: width / 10,
                width: width / 3.5,
                decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(width),
                        bottomRight: Radius.circular(width))),
                child: const Center(
                    child: Text(
                  "Sửa",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ))),
          ],
        ),
      ),
    );
  }
}
