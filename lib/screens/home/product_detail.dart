import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vepay_app/common/common_dialog.dart';
import 'package:vepay_app/common/common_method.dart';
import 'package:vepay_app/common/common_widgets.dart';
import 'package:vepay_app/models/blockchain_model.dart';
import 'package:vepay_app/models/payment_method_model.dart';
import 'package:vepay_app/models/rate_model.dart';
import 'package:vepay_app/screens/home/product_buy_detail.dart';
import 'package:vepay_app/screens/withdraw/withdraw_detail.dart';
import 'package:vepay_app/services/blockchain_service.dart';

import '../../resources/color_manager.dart';

class ProductDetail extends StatefulWidget {
  RateModel rateModel;
  ProductDetail({required this.rateModel, Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  TextEditingController emailController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController fieldController = TextEditingController();

  List<BlockchainModel> chains = [];
  BlockchainModel? selectedChain;

  final _akunValidator = MultiValidator([
    RequiredValidator(errorText: 'Harap masukan akun yang sesuai'),
  ]);

  final _totalValidator = MultiValidator([
    RequiredValidator(errorText: 'Harap masukan jumlah'),
  ]);

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    getRates();
    super.initState();
  }

  getRates() async {
    try {
      chains = await BlockchainService().getChains();

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CommonWidgets().buildCommonAppBar("Top up ${widget.rateModel.name!}"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: fieldController,
                  validator: _akunValidator,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText:
                        CommonMethods().getFieldName(widget.rateModel.name!),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextFormField(
                  controller: totalController,
                  validator: _totalValidator,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'(^\d*[\.\,]?\d{0,2})')),
                  ],
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Jumlah',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorManager.primary,
                      ),
                    ),
                    // suffixIcon: SizedBox(
                    //   height: 50,
                    //   width: 100,
                    //   child: IntrinsicHeight(
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       children: [
                    //         GestureDetector(
                    //           onTap: () {
                    //             if (totalController.text == "" ||
                    //                 int.parse(totalController.text.trim()) ==
                    //                     0) {
                    //               CommonDialog.buildOkDialog(context, false,
                    //                   "Jumlah harus lebih dari 0");

                    //               totalController.text = 1.toString();
                    //             } else {
                    //               setState(() {
                    //                 int total =
                    //                     int.parse(totalController.text) - 1;
                    //                 totalController.text = total.toString();
                    //               });
                    //             }
                    //           },
                    //           child: Align(
                    //               alignment: Alignment.center,
                    //               child: Container(
                    //                 width: 30,
                    //                 height: 30,
                    //                 decoration: BoxDecoration(
                    //                     borderRadius:
                    //                         BorderRadius.circular(100),
                    //                     border: Border.all(
                    //                         width: 2, color: Colors.grey)),
                    //                 child: const Icon(
                    //                   FontAwesomeIcons.minus,
                    //                   color: Colors.grey,
                    //                   size: 20,
                    //                 ),
                    //               )),
                    //         ),
                    //         GestureDetector(
                    //           onTap: () {
                    //             if (totalController.text == "") {
                    //               totalController.text = 1.toString();
                    //             } else {
                    //               int total =
                    //                   int.parse(totalController.text) + 1;
                    //               totalController.text = total.toString();
                    //             }
                    //           },
                    //           child: Align(
                    //               alignment: Alignment.center,
                    //               child: Container(
                    //                 width: 30,
                    //                 height: 30,
                    //                 decoration: BoxDecoration(
                    //                     borderRadius:
                    //                         BorderRadius.circular(100),
                    //                     border: Border.all(
                    //                         width: 2, color: Colors.grey)),
                    //                 child: const Icon(
                    //                   FontAwesomeIcons.plus,
                    //                   color: Colors.grey,
                    //                   size: 20,
                    //                 ),
                    //               )),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              ),
              widget.rateModel.categories != "crypto"
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<BlockchainModel>(
                                  isExpanded: true,
                                  icon: const FaIcon(FontAwesomeIcons.sortDown),
                                  iconSize: 16,
                                  underline: const SizedBox(),
                                  value: selectedChain,
                                  hint: const Text("Blockchain"),
                                  items: chains
                                      .map<DropdownMenuItem<BlockchainModel>>(
                                          (value) {
                                    return DropdownMenuItem<BlockchainModel>(
                                      value: value,
                                      child: Text(value.blockchain!),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        selectedChain = value;
                                      },
                                    );

                                    //showFields();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary, // background
                          foregroundColor: Colors.white, // foreground
                        ),
                        child: const Text('Selanjutnya'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if ((widget.rateModel.name!.toLowerCase() ==
                                        "paypal" ||
                                    widget.rateModel.name!.toLowerCase() ==
                                        "skrill" ||
                                    widget.rateModel.name!.toLowerCase() ==
                                        "neteller") &&
                                !CommonMethods()
                                    .isEmail(fieldController.text)) {
                              CommonDialog.buildOkDialog(
                                  context, false, "Harap isi email yang valid");
                            } else {
                              if (totalController.text.contains(",")) {
                                CommonDialog.buildOkDialog(context, false,
                                    "Gunakan titik (.) sebagai pemisah desimal");
                              } else {
                                if (double.parse(totalController.text.trim()) ==
                                    0) {
                                  CommonDialog.buildOkDialog(context, false,
                                      "Jumlah harus lebih dari 0");
                                } else {
                                  if (widget.rateModel.categories!
                                              .toLowerCase() ==
                                          "crypto" &&
                                      selectedChain == null) {
                                    CommonDialog.buildOkDialog(context, false,
                                        "Harap pilih blockchain terlebih dahulu");
                                  } else {
                                    Map<String, dynamic> data = {
                                      "akun_tujuan":
                                          fieldController.text.trim(),
                                      "jumlah": totalController.text.trim(),
                                      "blockchain_id": selectedChain == null
                                          ? null
                                          : selectedChain!.id,
                                      "blockchain_name": selectedChain == null
                                          ? null
                                          : selectedChain!.blockchain,
                                    };

                                    if (selectedChain == null) {
                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: ProductBuyDetail(
                                          rateModel: widget.rateModel,
                                          blockchainModel: null,
                                          data: data,
                                        ),
                                        withNavBar: false,
                                      );
                                    } else {
                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: ProductBuyDetail(
                                          rateModel: widget.rateModel,
                                          blockchainModel: selectedChain,
                                          data: data,
                                        ),
                                        withNavBar: false,
                                      );
                                    }
                                  }
                                }
                              }
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
