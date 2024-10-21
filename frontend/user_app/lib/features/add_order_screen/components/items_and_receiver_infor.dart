// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:user_app/app_export.dart';
import 'package:user_app/bloc_export.dart';
import 'package:user_app/configs/configs_export.dart';
import 'package:user_app/features/add_order_screen/components/components_export.dart';
import 'package:user_app/features/features_export.dart';
import 'package:user_app/models/models_export.dart';
import 'package:user_app/ultis/ultis_export.dart';
import 'package:user_app/widgets/widgets_export.dart';
import 'dart:convert';

import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

class ReceiverInfor extends StatefulWidget {
  const ReceiverInfor(
      {super.key,
      required this.refIdFromAddress,
      required this.refIdToAddress});

  final String refIdFromAddress;
  final String refIdToAddress;

  @override
  State<ReceiverInfor> createState() => _ReceiverInforState();
}

class _ReceiverInforState extends State<ReceiverInfor> {
  final TextEditingController _receiverNameController = TextEditingController();
  final TextEditingController _receiverPhoneNumberController =
      TextEditingController();
  final TextEditingController _userNodeController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemQuantityController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();

  final GlobalKey<FormState> _keyFormReceiver = GlobalKey<FormState>();
  final GlobalKey<FormState> _keyFormItem = GlobalKey<FormState>();

  double _totalPrice = 0;
  List<ItemModel> itemsList = [];
  String items = '';

  @override
  void dispose() {
    super.dispose();
    _receiverNameController.dispose();
    _receiverPhoneNumberController.dispose();
    _userNodeController.dispose();
    _itemNameController.dispose();
    _itemQuantityController.dispose();
    _itemPriceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            key: _keyFormReceiver,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Thông tin người nhận',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  validator: (value) {
                    if (_receiverNameController.text.isEmpty) {
                      return 'Tên người nhận không được trống';
                    }
                    return null;
                  },
                  controller: _receiverNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Tên người nhận',
                      enabledBorder: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green.shade900),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0))),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0)))),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (_receiverPhoneNumberController.text.isEmpty) {
                      return 'Số điện thoại người nhận không được trống';
                    }
                    return null;
                  },
                  controller: _receiverPhoneNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Số điện thoại người nhận',
                      enabledBorder: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green.shade900),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0))),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0)))),
                ),
                const SizedBox(
                  height: 24.0,
                ),
              ],
            )),
        Form(
            key: _keyFormItem,
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Thông tin đơn hàng',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (_itemNameController.text.isEmpty) {
                          return 'Tên sản phẩm không được trống';
                        }
                        return null;
                      },
                      controller: _itemNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Tên sản phẩm',
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green.shade900),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0))),
                          errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)))),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (_itemPriceController.text.isEmpty) {
                          return 'Đơn giá không được trống';
                        }
                        return null;
                      },
                      controller: _itemPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Đơn giá',
                          suffix: const Text('vnđ'),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green.shade900),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0))),
                          errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)))),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (_itemQuantityController.text.isEmpty) {
                          return 'Số lượng không được trống';
                        }
                        return null;
                      },
                      controller: _itemQuantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Số lượng',
                          suffix: const Text('cái'),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green.shade900),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0))),
                          errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)))),
                    ),
                    BlocBuilder<DriverOptionBloc, DriverOptionState>(
                      builder: (context, state) {
                        return TextButton(
                            onPressed: () => _pressAddItem(context),
                            child: const Text(
                              'Thêm',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 16),
                            ));
                      },
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Ghi chú',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      controller: _userNodeController,
                      keyboardType: TextInputType.text,
                      minLines: 5,
                      maxLines: 10,
                      decoration: InputDecoration(
                          hintText: 'Ghi chú',
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green.shade900),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0))),
                          errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)))),
                    ),
                    ItemsList(itemsList: itemsList),
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Thành tiền:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${_totalPrice.toStringAsFixed(2)} vnd',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.red),
                        )
                      ],
                    )
                  ],
                )
              ],
            )),
        const SizedBox(height: 24.0),
        ButtonCustom(
          width: MediaQuery.of(context).size.width * 3 / 4,
          height: 40.0,
          color: Colors.green.shade900,
          text: 'Tiếp tục',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
          radius: 30.0,
          onTap: () async {
            if (itemsList.isNotEmpty &&
                widget.refIdFromAddress.isNotEmpty &&
                widget.refIdToAddress.isNotEmpty) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
             
              String fromAddress = '';
              String toAddress = '';

              Either<Failure, VietmapPlaceModel> response =
                  await Vietmap.place(widget.refIdFromAddress);
              response.fold((l) => null, (r) {
                setState(() {
                  fromAddress = '{"lat":"${r.lat}","lng":"${r.lng}"}';
                });
              });

              response = await Vietmap.place(widget.refIdToAddress);
              response.fold((l) => null, (r) {
                setState(() {
                  toAddress = '{"lat":"${r.lat}","lng":"${r.lng}"}';
                });
              });

              prefs.setString('fromAddress', fromAddress);
              prefs.setString('toAddress', toAddress);
              prefs.setString('items', items);
              prefs.setString(
                  'receiver',
                  jsonEncode(
                      '{"name":"${_receiverNameController.text}","phone_number":"${_receiverPhoneNumberController.text}"}'));
              prefs.setString('userNote', _userNodeController.text.toString());
              prefs.setDouble('totalPrice', _totalPrice);

              context
                  .read<DriverOptionBloc>()
                  .add(GetDriverList(token: prefs.getString('token')!));
              navigatorKey.currentState!
                  .pushNamed(DriverOptionScreen.routeName);
            } else if (itemsList.isEmpty) {
              showSnackbar('Đơn hàng chưa có sản phẩm', context, false);
            } else {
              showSnackbar('Dữ liệu chưa hợp lệ', context, false);
            }
          },
        )
      ],
    );
  }

  void _pressAddItem(BuildContext context) async {
    if (_keyFormItem.currentState!.validate() &&
        _keyFormReceiver.currentState!.validate()) {
      setState(() {
        itemsList.add(ItemModel(
            itemName: _itemNameController.text.toString(),
            quantity: int.parse(_itemQuantityController.text.toString()),
            price: double.parse(_itemPriceController.text.toString())));
        _totalPrice += int.parse(_itemQuantityController.text.toString()) *
            double.parse(_itemPriceController.text.toString());

        String itemsTemp = '';
        for (var i = 0; i < itemsList.length; i++) {
          itemsTemp +=
              '"${itemsList[i].itemName}":"x${itemsList[i].quantity}",';
        }
        if (itemsTemp.isNotEmpty) {
          items = "{${itemsTemp.substring(0, itemsTemp.length - 1)}}";
        }
      });
      _itemNameController.text = '';
      _itemQuantityController.text = '';
      _itemPriceController.text = '';
    }
  }
}
