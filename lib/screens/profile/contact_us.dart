import 'package:flutter/material.dart';
import 'package:vepay_app/common/common_widgets.dart';

import '../../resources/color_manager.dart';
import '../../services/app_info_service.dart';

class ContactUs extends StatefulWidget {
  ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CommonWidgets().buildFloatingWaButton(),
      appBar: CommonWidgets().buildCommonAppBar("Hubungi Kami"),
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                // margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  // borderRadius:
                  //     const BorderRadius.all(Radius.circular(10)), //here
                  color: ColorManager.primary,
                ),
              )
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.15,
                  image: const AssetImage('assets/logo_white.png'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.57,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              AppInfoService().removeHtmlTags(
                                  AppInfoService().getValueByKey('web_title')!),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Alamat",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            AppInfoService().removeHtmlTags(
                                AppInfoService().getValueByKey('web_alamat')!),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Email",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            AppInfoService().removeHtmlTags(
                                AppInfoService().getValueByKey('web_email')!),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "WhatsApp",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            AppInfoService().removeHtmlTags(
                                AppInfoService().getValueByKey('web_telepon')!),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Website",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            AppInfoService().removeHtmlTags(
                                AppInfoService().getValueByKey('web_website')!),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: Text(
                              AppInfoService().removeHtmlTags(AppInfoService()
                                  .getValueByKey('web_info_desc')!),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}