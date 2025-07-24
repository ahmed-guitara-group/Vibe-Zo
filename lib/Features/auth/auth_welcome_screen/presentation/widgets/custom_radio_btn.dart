import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vibe_zo/core/utils/constants.dart';
import 'package:vibe_zo/core/utils/helper.dart';

enum VerifyMethod { sms, whatsapp }

class VerificationMethodSelector extends StatefulWidget {
  const VerificationMethodSelector({super.key});

  @override
  State<VerificationMethodSelector> createState() =>
      _VerificationMethodSelectorState();
}

class _VerificationMethodSelectorState
    extends State<VerificationMethodSelector> {
  VerifyMethod? _selectedMethod;
  var selectedMethod = Hive.box(kSelectedMethodBox);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.locale.translate("how_do_you_want_to_verify")!,
          style: TextStyle(color: kBlackTextColor, fontSize: 14, height: 1.29),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  Transform.scale(
                    scale: 1.2,
                    child: Radio<VerifyMethod>(
                      value: VerifyMethod.sms,
                      groupValue:
                          selectedMethod.get(kSelectedMethodBox) ==
                              VerifyMethod.sms.name
                          ? VerifyMethod.sms
                          : null,
                      activeColor: kPrimaryColor,
                      onChanged: (value) {
                        setState(() {
                          _selectedMethod = value;
                          selectedMethod.put(kSelectedMethodBox, value!.name);
                        });
                      },
                    ),
                  ),
                  Text(
                    context.locale.translate("by_sms")!,
                    style: TextStyle(
                      color: kBlackTextColor,

                      fontSize: 14,

                      height: 1.29,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Transform.scale(
                    scale: 1.2,
                    child: Radio<VerifyMethod>(
                      value: VerifyMethod.whatsapp,
                      activeColor: kPrimaryColor,
                      groupValue:
                          selectedMethod.get(kSelectedMethodBox) ==
                              VerifyMethod.whatsapp.name
                          ? VerifyMethod.whatsapp
                          : null,
                      onChanged: (value) {
                        setState(() {
                          _selectedMethod = value;
                          selectedMethod.put(kSelectedMethodBox, value!.name);
                        });
                      },
                    ),
                  ),
                  Text(
                    context.locale.translate("by_whatsapp")!,
                    style: TextStyle(
                      color: kBlackTextColor,

                      fontSize: 14,

                      height: 1.29,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
