import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';
import 'widget.dart';

class ErrorStateWidget extends StatelessWidget {
  final Function() onPressed;

  const ErrorStateWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            alignment: const Alignment(0, 1.07),
            child: const ImageAssetWidget(
              asset: UIAssets.picachu,
              fit: BoxFit.contain,
              width: 275.0,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 120.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(HomeStrings.errorTitle,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: UIColors.colorGrayText(),
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(HomeStrings.errorSubTitle,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: UIColors.colorGrayText(),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                const Spacer(),
                Center(
                  child: ButtonWidget(
                    text: HomeStrings.tryAgain,
                    textColor: Colors.white,
                    onPressed: onPressed,
                    primary: UIColors.colorBackground(),
                    width: Get.width * 0.6,
                    height: 50.0,
                  ),
                ),
                const Spacer()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
