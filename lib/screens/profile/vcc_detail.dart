import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:vepay_app/common/common_method.dart';
import 'package:vepay_app/common/common_widgets.dart';
import 'package:vepay_app/models/vcc_model.dart';
import 'package:vepay_app/screens/vcc/topup_vcc.dart';
import 'package:vepay_app/screens/vcc/withdraw_vcc.dart';

import '../../resources/color_manager.dart';

class VccDetail extends StatefulWidget {
  VccModel vcc;
  VccDetail({required this.vcc, Key? key}) : super(key: key);

  @override
  State<VccDetail> createState() => _VccDetailState();
}

class _VccDetailState extends State<VccDetail> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets().buildCommonAppBar("Detail VCC"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isLandscape = MediaQuery.of(context).orientation ==
                      Orientation.landscape;

                  // Determine width based on device type and orientation
                  double cardWidth;
                  if (ResponsiveBreakpoints.of(context).isTablet || 
                      ResponsiveBreakpoints.of(context).isDesktop) {
                    cardWidth =
                        constraints.maxWidth * (isLandscape ? 0.32 : 0.6); // 80% width for tablets
                  } else if (ResponsiveBreakpoints.of(context).isMobile) {
                    cardWidth = constraints.maxWidth *
                        (isLandscape ? 0.5 : 1); // 50% width for phones in landscape
                  } else {
                    cardWidth = double.infinity; // Default for other cases
                  }

                  return SizedBox(
                    width: cardWidth,
                    child: AspectRatio(
                      aspectRatio: 1.6,
                      child: CreditCardWidget(
                        cardBgColor: ColorManager.primary,
                        bankName: "VCC",
                        cardNumber: widget.vcc.number!,
                        expiryDate: widget.vcc.validDate!,
                        cardHolderName: widget.vcc.holder!,
                        cvvCode: widget.vcc.securityCode!,
                        isHolderNameVisible: true,
                        isChipVisible: true,
                        showBackView: false,
                        obscureCardCvv: false,
                        obscureCardNumber: false,
                        onCreditCardWidgetChange:
                            (CreditCardBrand) {}, //true when you want to show cvv(back) view
                        cardType: widget.vcc.jenisVcc!.toLowerCase() == "visa"
                            ? CardType.visa
                            : CardType
                                .mastercard, //Optional if you want to override Card Type
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Detail",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Nama Pemegang Kartu",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.vcc.holder!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Jenis VCC",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.vcc.jenisVcc!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Nomor Kartu",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.vcc.number!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Clipboard.setData(
                                  ClipboardData(text: widget.vcc.number!))
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Berhasil menyalin nomor VCC ke clipboard")));
                          });
                        },
                        child: Icon(
                          Icons.copy,
                          size: 17,
                          color: ColorManager.primary,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Tanggal Kadaluarsa",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.vcc.validDate!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Kode Keamanan",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isObscure ? "***" : widget.vcc.securityCode!,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            //isObscure = isObscure ? false : true;
                            isObscure = !isObscure;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.lock,
                              color: ColorManager.primary,
                            ),
                            Text(
                              "Lihat Kode",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: ColorManager.primary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Saldo",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    CommonMethods.formatCompleteCurrency(
                        double.parse(widget.vcc.saldo!)),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  // ListTile(
                  //   onTap: () {
                  //     PersistentNavBarNavigator.pushNewScreen(
                  //       context,
                  //       screen: WithdrawVcc(
                  //         vccModel: widget.vcc,
                  //       ),
                  //       withNavBar: false,
                  //     );
                  //   },
                  //   contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  //   leading: Container(
                  //     width: 50,
                  //     height: 50,
                  //     decoration: BoxDecoration(
                  //         color: ColorManager.primary.withOpacity(0.2),
                  //         borderRadius: BorderRadius.circular(12)),
                  //     padding: const EdgeInsets.all(10),
                  //     child: Center(
                  //       child: FaIcon(
                  //         FontAwesomeIcons.moneyBillTransfer,
                  //         color: ColorManager.primary,
                  //       ),
                  //     ),
                  //   ),
                  //   title: const Text("Withdraw"),
                  // ),
                  // ListTile(
                  //   onTap: () {
                  //     PersistentNavBarNavigator.pushNewScreen(
                  //       context,
                  //       screen: TopupVcc(
                  //         vccModel: widget.vcc,
                  //       ),
                  //       withNavBar: false,
                  //     );
                  //   },
                  //   contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  //   leading: Container(
                  //     width: 50,
                  //     height: 50,
                  //     decoration: BoxDecoration(
                  //         color: ColorManager.primary.withOpacity(0.2),
                  //         borderRadius: BorderRadius.circular(12)),
                  //     padding: const EdgeInsets.all(10),
                  //     child: Center(
                  //       child: FaIcon(
                  //         FontAwesomeIcons.moneyCheck,
                  //         color: ColorManager.primary,
                  //       ),
                  //     ),
                  //   ),
                  //   title: const Text("Top up"),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
