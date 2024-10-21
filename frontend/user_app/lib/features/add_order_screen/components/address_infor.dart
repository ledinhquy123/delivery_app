import 'package:flutter/material.dart';
import 'package:user_app/features/add_order_screen/components/components_export.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

class AddressInfo extends StatefulWidget {
  const AddressInfo({super.key});

  @override
  State<AddressInfo> createState() => _AddressInfoState();
}

class _AddressInfoState extends State<AddressInfo> {
  final TextEditingController _fromAddressController = TextEditingController();
  final TextEditingController _toAddressController = TextEditingController();

  List<VietmapAutocompleteModel> autoCompleteFromAddress = [];
  List<VietmapAutocompleteModel> autoCompleteToAddress = [];

  String refIdFromAddress = '';
  String refIdToAddress = '';

  @override
  void dispose() {
    _fromAddressController.dispose();
    _toAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            leading: Icon(
              Icons.location_on,
              size: 30,
              color: Colors.blue.shade500,
            ),
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              'Nhận hàng',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 18, color: Colors.black),
            ),
            subtitle: TextFormField(
              controller: _fromAddressController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Điểm nhận hàng',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                enabledBorder: null,
                focusedBorder: null,
                errorBorder: null,
              ),
              onChanged: (value) async {
                Either<Failure, List<VietmapAutocompleteModel>> x =
                    await Vietmap.autocomplete(
                        VietMapAutoCompleteParams(textSearch: value));
                x.fold((l) => null, (r) async {
                  setState(() {
                    autoCompleteFromAddress = r;
                  });
                });
              },
              onEditingComplete: () {
                setState(() {
                  autoCompleteFromAddress = [];
                });
              },
            )),
        autoCompleteFromAddress.isNotEmpty
            ? Container(
                padding: const EdgeInsets.all(12.0),
                height: 150.0,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: autoCompleteFromAddress.length,
                    itemBuilder: (context, index) {
                      VietmapAutocompleteModel location =
                          autoCompleteFromAddress[index];
                      return ListTile(
                        onTap: () {
                          _fromAddressController.text =
                              location.name.toString();
                          setState(() {
                            refIdFromAddress = location.refId.toString();
                          });
                        },
                        leading: Icon(
                          Icons.location_on,
                          size: 30,
                          color: Colors.blue.shade500,
                        ),
                        title: Text(location.name.toString()),
                        subtitle: Text(location.address.toString()),
                      );
                    }),
              )
            : const SizedBox(
                height: 24.0,
              ),
        ListTile(
          leading: const Icon(
            Icons.location_on,
            size: 30,
            color: Colors.red,
          ),
          contentPadding: const EdgeInsets.all(0),
          title: Text(
            'Giao hàng',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: 18, color: Colors.black),
          ),
          subtitle: TextFormField(
            controller: _toAddressController,
            keyboardType: TextInputType.text,
            onChanged: (value) async {
              Either<Failure, List<VietmapAutocompleteModel>> x =
                  await Vietmap.autocomplete(
                      VietMapAutoCompleteParams(textSearch: value));
              x.fold((l) => null, (r) async {
                setState(() {
                  autoCompleteToAddress = r;
                });
              });
            },
            onEditingComplete: () {
              setState(() {
                autoCompleteToAddress = [];
              });
            },
            decoration: InputDecoration(
              hintText: 'Điểm giao hàng',
              hintStyle: TextStyle(color: Colors.grey.shade400),
              enabledBorder: null,
              focusedBorder: null,
              errorBorder: null,
            ),
          ),
        ),
        autoCompleteToAddress.isNotEmpty
            ? Container(
                padding: const EdgeInsets.all(12.0),
                height: 150.0,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: autoCompleteToAddress.length,
                    itemBuilder: (context, index) {
                      VietmapAutocompleteModel location =
                          autoCompleteToAddress[index];
                      return ListTile(
                        onTap: () {
                          _toAddressController.text = location.name.toString();
                          setState(() {
                            refIdToAddress = location.refId.toString();
                          });
                        },
                        leading: Icon(
                          Icons.location_on,
                          size: 30,
                          color: Colors.blue.shade500,
                        ),
                        title: Text(location.name.toString()),
                        subtitle: Text(location.address.toString()),
                      );
                    }),
              )
            : const SizedBox(
                height: 24.0,
              ),
        ReceiverInfor(
          refIdFromAddress: refIdFromAddress,
          refIdToAddress: refIdToAddress,
        )
      ],
    );
  }
}
