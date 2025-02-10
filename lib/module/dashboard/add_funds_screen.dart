
import 'package:defiastra_hackathon/core/app_theme/app_theme.dart';
import 'package:defiastra_hackathon/module/common/app_button.dart';
import 'package:defiastra_hackathon/util/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddFundsScreen extends StatelessWidget {

  static const route = "/add_funds";

  final String address;

  const AddFundsScreen({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Funds",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          24.r,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: EdgeInsets.all(
                16.r,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Deposit to',
                    style: context.textStyles
                        .uiTextRegular(context.colors.surface1, bold: true),
                  ),
                  SizedBox(
                    height: 20.r,
                  ),
                  Center(child: QrImageView(
                    data: "address",
                    backgroundColor: Colors.transparent,
                    eyeStyle: const QrEyeStyle(color: Colors.black26),
                    dataModuleStyle: QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: context.colors.surface1),
                    size: 158.r,
                  ),),
                  SizedBox(
                    height: 20.r,
                  ),
                  _WalletAddressWidget(address),
                ],
              ),
            ),
            SizedBox(height: 20.r,),
            Text(
              'Note: Please add POL token in Polygon chain.',
              style: context.textStyles
                  .uiTextRegular(context.colors.surface1, bold: true),
            ),
            Expanded(child: SizedBox(height: 24.r,)),
            AppButton.primary(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: address ?? ''));
                UIUtils().showSnackBar("Copied");
              },
              title: "Copy",
              icon: Icon(
                Icons.copy,
                size: 24.r,
                color: Colors.white,
              ),
              iconPadding: 12.r,
              backgroundColor: Colors.red,
            )
          ],
        ),
      )
    );
  }
}

class _WalletAddressWidget extends StatelessWidget {
  final String address;

  const _WalletAddressWidget(this.address);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Wallet Address",
            style: context.textStyles.uiTextNormal(context.colors.surface1, bold: true)),
        SizedBox(
          height: 4.r,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                address,
                style: context.textStyles.uiTextNormal(context.colors.surface1),
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
