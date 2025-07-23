import 'package:flutter/material.dart';
import 'package:vibe_zo/core/utils/constants.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How do you want to be verified?',
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
                      groupValue: _selectedMethod,
                      activeColor: kPrimaryColor,
                      onChanged: (value) {
                        setState(() {
                          _selectedMethod = value;
                        });
                      },
                    ),
                  ),
                  const Text(
                    "By SMS",
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

                      groupValue: _selectedMethod,
                      onChanged: (value) {
                        setState(() {
                          _selectedMethod = value;
                        });
                      },
                    ),
                  ),
                  const Text(
                    "By Whatsapp",
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
