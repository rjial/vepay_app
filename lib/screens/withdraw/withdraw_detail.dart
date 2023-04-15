import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vepay_app/common/common_widgets.dart';

import '../../common/common_dialog.dart';
import '../../common/common_method.dart';
import '../../models/rate_model.dart';
import '../../resources/color_manager.dart';
import '../home/product_payment_method.dart';

class WithdrawDetail extends StatefulWidget {
  RateModel rateModel;
  Map<String, dynamic> data;
  WithdrawDetail({required this.rateModel, required this.data, Key? key})
      : super(key: key);

  @override
  State<WithdrawDetail> createState() => _WithdrawDetailState();
}

class _WithdrawDetailState extends State<WithdrawDetail> {
  double? subtotal;
  double? total;
  double? feeFinal;
  double? totalPromo = 0;

  TextEditingController promoController = TextEditingController();

  double? biayaTransaksi;

  @override
  void initState() {
    countAll(
      double.parse(widget.rateModel.price!),
      double.parse(widget.data['jumlah']),
      double.parse(widget.rateModel.fee!),
      totalPromo!,
    );

    super.initState();
  }

  countAll(double price, double amount, double fee, double promo) {
    subtotal = price * amount;

    total = amount + fee;

    setState(() {});
  }

  buildTextItem(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: Text(title)),
        Expanded(
            child: Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontWeight: FontWeight.bold),
        )),
      ],
    );
  }

  buildTextItem2(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(title)),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  buildTopSection() {
    return Card(
      margin: EdgeInsets.zero,
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.all(
      //     Radius.circular(15),
      //   ),
      // ),
      child: SizedBox(
        height: widget.data['blockchain_name'] == null
            ? MediaQuery.of(context).size.height * 0.27
            : MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: FancyShimmerImage(
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.height * 0.06,
                        boxFit: BoxFit.cover,
                        imageUrl: widget.rateModel.image!,
                        errorWidget: Image.network(
                            'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${widget.rateModel.name!} ${widget.rateModel.type!}",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 17,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.grey,
                height: 2,
              ),
              const SizedBox(height: 10),
              buildTextItem("Jenis Produk", widget.rateModel.name!),
              const SizedBox(height: 10),
              widget.data['akun_tujuan'] == null
                  ? Container()
                  : buildTextItem(
                      CommonMethods().getFieldName(widget.rateModel.name!),
                      widget.data['akun_tujuan']!),
              widget.data['akun_tujuan'] == null
                  ? Container()
                  : const SizedBox(height: 10),
              widget.data['blockchain_name'] == null
                  ? Container()
                  : buildTextItem(
                      "Blockchain", widget.data['blockchain_name']!),
              widget.data['blockchain_name'] == null
                  ? Container()
                  : const SizedBox(height: 10),
              // ignore: prefer_interpolation_to_compose_strings
              buildTextItem("Jumlah", "\$" + widget.data['jumlah']!),
              const SizedBox(height: 10),
              buildTextItem(
                "Rate Withdraw",
                CommonMethods.formatCompleteCurrency(
                  double.parse(widget.rateModel.price!),
                ),
              ),
              const SizedBox(height: 10),
              buildTextItem(
                "Biaya Transaksi",
                "\$${widget.rateModel.fee}",
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildMiddleSection() {
    return Card(
      margin: EdgeInsets.zero,
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.all(
      //     Radius.circular(15),
      //   ),
      // ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Detail Withdraw",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 20),
              buildTextItem2(
                "Subtotal Tagihan",
                "\$${total!.toInt()}",
              ),
              const SizedBox(height: 10),
              buildTextItem2(
                "Subtotal Jumlah yang Diterima",
                CommonMethods.formatCompleteCurrency(
                  subtotal!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildBottomSection() {
    return Card(
      margin: EdgeInsets.zero,
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.all(
      //     Radius.circular(15),
      //   ),
      // ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.085,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "Total Pembayaran",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Text(
                "\$${total!.toInt()}",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets()
          .buildCommonAppBar("${widget.rateModel.name!} Withdraw"),
      body: ListView(
        children: [
          buildTopSection(),
          const SizedBox(height: 10),
          buildMiddleSection(),
          const SizedBox(height: 10),
          buildBottomSection(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary, // background
                    foregroundColor: Colors.white, // foreground
                  ),
                  child: const Text('Bayar'),
                  onPressed: () async {
                    // if (_formKey.currentState!.validate()) {
                    //   Map<String, dynamic> data = {
                    //     "email": emailController.text.trim(),
                    //     "jumlah": totalController.text.trim(),
                    //   };

                    widget.data['sub_total'] = subtotal!;
                    widget.data['total'] = total!;
                    widget.data['fee'] = feeFinal;
                    widget.data['total_promo'] = totalPromo;

                    // PersistentNavBarNavigator.pushNewScreen(
                    //   context,
                    //   screen: ProductPaymentMethod(
                    //     rateModel: widget.rateModel,
                    //     data: widget.data,
                    //   ),
                    //   withNavBar: false,
                    // );
                    // }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
