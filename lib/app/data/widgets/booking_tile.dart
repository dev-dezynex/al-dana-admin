import 'dart:developer';

import 'package:al_dana_admin/app/data/models/booking_model.dart';
import 'package:al_dana_admin/app/modules/home/controllers/home_controller.dart';
import 'package:al_dana_admin/app/modules/profile/providers/profile_provider.dart';
import 'package:al_dana_admin/app/modules/users/controllers/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../data.dart';

class BookingTile extends StatelessWidget {
  const BookingTile({
    Key? key,
    required this.booking,
    this.onTap,
    this.onChanged,
  }) : super(key: key);
  final Data booking;
  final GestureTapCallback? onTap;
  final void Function(bool?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: white,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    '${booking.sId}',
                    style: tsPoppins(
                      weight: FontWeight.w600,
                      color: white,
                      size: 18,
                    ),
                  ),
                  Text(
                    // booking.packageList![0].title!,
                    booking.package?[0].packageId?.title ?? '',
                    style: tsPoppins(
                      weight: FontWeight.w600,
                      color: textDark80,
                      size: 18,
                    ),
                  ),
                  Container(
                      height: 2,
                      width: 30,
                      decoration: BoxDecoration(
                          color: accent60,
                          borderRadius: BorderRadius.circular(100))),
                  const SizedBox(height: 8),
                  Text(
                    'Service Includes',
                    style: tsPoppins(
                      color: bgColor27,
                      size: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      // itemCount: booking.packageList![0].packageDetailList![0].services!.length,
                      itemCount:
                          booking.package?[0].packageId?.services?.length,
                      itemBuilder: (con, i) {
                        return Row(
                          children: [
                            const Icon(
                              Icons.arrow_right_rounded,
                              color: textDark80,
                            ),
                            Text(
                              // booking.packageList![0].packageDetailList![0].services![i].title,
                              booking.package?[0].packageId?.services?[i]
                                      .title ??
                                  '',
                              style: tsPoppins(
                                  color: textDark80, weight: FontWeight.w400),
                            )
                          ],
                        );
                      }),
                  const SizedBox(height: 5),
                  Text(
                    'Add-Once',
                    style: tsPoppins(
                      color: bgColor27,
                      size: 14,
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      // itemCount: booking.services!.length,
                      itemCount: booking.service?.length,
                      itemBuilder: (con, i) {
                        return Row(
                          children: [
                            const Icon(
                              Icons.arrow_right_rounded,
                              color: textDark80,
                            ),
                            Text(
                              // booking.services![i].title,
                              booking.service?[i].serviceId?.title ?? '',
                              style: tsPoppins(
                                  color: textDark80, weight: FontWeight.w400),
                            )
                          ],
                        );
                      }),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            Positioned(
                top: 20,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        outputDateFormat2
                            .format(outputDateFormat.parse(booking.date!)),
                        textAlign: TextAlign.right,
                        style: tsPoppins(
                            color: textDark80, weight: FontWeight.w400)),
                    Text('AED ${booking.totalAmount?.toStringAsFixed(2)}',
                        textAlign: TextAlign.center,
                        style: tsRubik(color: bgColor27, size: 14)),
                  ],
                )),
            Positioned(
              bottom: 10,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 100,
                    width: 150,
                    //padding: const EdgeInsets.only(top: 1.0, left: 5, right: 5),
                    child: Image.network(
                      // booking.packageList![0].image!,
                      booking.package?[0].packageId?.image ?? '',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/img_placeholder.png',
                          fit: BoxFit.contain,
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: onTap,
                      style:
                          ElevatedButton.styleFrom(backgroundColor: bgColor27),
                      child: Text(
                        'Track >>',
                        style: tsPoppins(weight: FontWeight.w600, color: white),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BookingTile2 extends StatefulWidget {
  const BookingTile2({
    Key? key,
    required this.booking,
    this.onTap,
    this.onChanged,
    this.controller,
  }) : super(key: key);
  final Data booking;
  final GestureTapCallback? onTap;
  final void Function(bool?)? onChanged;
  final HomeController? controller;

  @override
  State<BookingTile2> createState() => _BookingTile2State();
}

class _BookingTile2State extends State<BookingTile2> {
  final userController = Get.put(UsersController());
  @override
  void initState() {
    super.initState();

    Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
    userController.getDetails();
  }

  @override
  Widget build(BuildContext context) {
    final managerList = userController.managerList.toList();
    final technicianList = userController.technicianList.toList();
    String role =
        Provider.of<ProfileProvider>(context).profile?.data?.role ?? '';
    String addressLocation = widget.booking.addressId?.location ?? '';
    String? managerId;
    return InkWell(
      onTap: widget.onTap,
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: white,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: Get.width * .3, maxHeight: 100),
                    padding: const EdgeInsets.all(10),
                    child: widget.booking.package!.isNotEmpty
                        ? Image.network(
                            "$domainName${widget.booking.package?[0].packageId?.image}",
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/img_placeholder.png',
                                fit: BoxFit.contain,
                              );
                            },
                          )
                        : Image.asset(
                            'assets/images/img_placeholder.png',
                            fit: BoxFit.contain,
                          ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Date',
                                style: tsPoppins(
                                    weight: FontWeight.bold, color: textDark40),
                              ),
                              Text(
                                widget.booking.date!.substring(
                                    0, widget.booking.date!.indexOf('T')),
                                textAlign: TextAlign.end,
                                style: tsPoppins(color: textDark40),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Booking Type',
                                style: tsPoppins(
                                    color: textDark40, weight: FontWeight.bold),
                              ),
                              Text(
                                widget.booking.bookingType ?? '',
                                style: tsPoppins(
                                    weight: FontWeight.w400, color: textDark40),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          if (addressLocation != "")
                            Text(
                              'Address',
                              style: tsPoppins(
                                  weight: FontWeight.bold, color: textDark40),
                            ),
                          if (addressLocation != "")
                            Text(
                              widget.booking.addressId?.location ?? '',
                              style: tsPoppins(
                                  weight: FontWeight.w400,
                                  color: textDark40,
                                  size: 10),
                            ),
                          if (addressLocation != "") const SizedBox(height: 5),
                          Text(
                            'Branch',
                            style: tsPoppins(
                                weight: FontWeight.bold, color: textDark40),
                          ),
                          Text(
                            widget.booking.branchId?.name ?? '',
                            style: tsPoppins(
                                weight: FontWeight.w400,
                                color: textDark40,
                                size: 10),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Time Slot',
                            style: tsPoppins(
                                weight: FontWeight.bold, color: textDark40),
                          ),
                          Text(
                            '${widget.booking.timeSlotId?.startTime}-${widget.booking.timeSlotId?.endTime}',
                            style: tsPoppins(
                                weight: FontWeight.w400,
                                color: textDark40,
                                size: 10),
                          ),
                          Text(
                            'Customer Details',
                            style: tsPoppins(
                                weight: FontWeight.bold, color: textDark40),
                          ),
                          Text(
                            'Name  ${widget.booking.customerId?.name ?? ''}',
                            style: tsPoppins(
                                weight: FontWeight.w400,
                                color: textDark40,
                                size: 10),
                          ),
                          Text(
                            'Email  ${widget.booking.customerId?.email ?? ''}',
                            style: tsPoppins(
                                weight: FontWeight.w400,
                                color: textDark40,
                                size: 10),
                          ),
                          Text(
                            'Phone  ${widget.booking.customerId?.phoneNumber ?? ''}',
                            style: tsPoppins(
                                weight: FontWeight.w400,
                                color: textDark40,
                                size: 10),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              if (role == 'superAdmin' ||
                  role == 'admin' ||
                  role == 'serviceManager')
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (widget.booking.approvalStatus == 'Pending' ||
                        widget.booking.approvalStatus == 'Confirmed' ||
                        widget.booking.approvalStatus == 'Assigned')
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ElevatedButton(
                            onPressed: () {
                              widget.controller?.updateBookingStatus(
                                  'Cancelled', widget.booking.sId ?? '');
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: bgColor29),
                            child: Text(
                              '   Cancel   ',
                              style: tsPoppins(
                                  weight: FontWeight.w600, color: white),
                            )),
                      ),
                    if (widget.booking.approvalStatus == 'Pending')
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ElevatedButton(
                            onPressed: () {
                              widget.controller?.updateBookingStatus(
                                  'Confirmed', widget.booking.sId ?? '');
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: bgColor37),
                            child: Text(
                              '  Confirmed  ',
                              style: tsPoppins(
                                  weight: FontWeight.w600, color: white),
                            )),
                      ),
                    if (widget.booking.approvalStatus == 'Confirmed')
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (role == 'superAdmin' ||
                                            role == 'admin')
                                          DropdownButtonFormField<String>(
                                            decoration: const InputDecoration(
                                                labelText: 'Select Manager'),
                                            items: managerList
                                                .map<DropdownMenuItem<String>>(
                                                    (manager) {
                                              return DropdownMenuItem<String>(
                                                value: manager.id,
                                                child: Text(manager.name),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              managerId = value ?? '';
                                              log(managerId.toString());
                                            },
                                          ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'Cancel',
                                                style:
                                                    TextStyle(color: bgColor29),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: bgColor38),
                                              onPressed: () {
                                                widget.controller
                                                    ?.assignToServiceManager(
                                                  widget.booking.sId ?? '',
                                                  managerId ?? '',
                                                );
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Assign'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: bgColor38),
                            child: Text(
                              '   Assign   ',
                              style: tsPoppins(
                                  weight: FontWeight.w600, color: white),
                            )),
                      ),
                  ],
                ),
              const SizedBox(
                height: 10,
              )
            ],
          )),
    );
  }
}
