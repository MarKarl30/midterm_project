import 'package:flutter/material.dart';
import 'package:midterm_project/widgets/ewallet/e_wallet_transfer_widget.dart';

class SpayTopUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Menggunakan EWalletTransferWidget dengan parameter gambar
    return EWalletTransferWidget(
      bannerImage: "assets/images/banner/ewallet/spay.png",
      backgroundColor: const Color.fromARGB(255, 123, 34, 7),
      uniqueCode: "SPAY",
    );
  }
}