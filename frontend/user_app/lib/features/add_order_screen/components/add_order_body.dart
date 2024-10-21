import 'package:flutter/material.dart';
import 'package:user_app/features/add_order_screen/components/components_export.dart';

class AddOrderBody extends StatefulWidget {
  const AddOrderBody({super.key});

  @override
  State<AddOrderBody> createState() => _AddOrderBodyState();
}

class _AddOrderBodyState extends State<AddOrderBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Thông tin địa chỉ',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        const SizedBox(
          height: 24.0,
        ),
        const AddressInfo()
      ],
    );
  }
}
