import 'dart:developer';

import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/data/models/booking_model.dart';
import 'package:al_dana_admin/app/modules/manual_spare_add/views/manual_spare_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../modules/home/controllers/home_controller.dart';
import '../../modules/invoice/provider/invoice_provider.dart';
import '../../modules/invoice/views/invoice_view.dart';
import '../../modules/tracking/views/tracking_view.dart';
import '../../modules/users/controllers/users_controller.dart';

class BookingDetailPage extends StatefulWidget {
  const BookingDetailPage({
    super.key,
    this.booking,
    this.addressLocaiton,
    this.controller,
  });
  final Data? booking;
  final String? addressLocaiton;
  final HomeController? controller;
  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  Common common = Common();
  final userController = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
    String role = common.currentUser.scope;
    final managerList = userController.managerList.toList();
    final technicianList = userController.technicianList.toList();
    String? managerId;
    String? technicianId;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text(
          'Booking Details',
          style: TextStyle(color: white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 6,
        ),
        child: ListView(
          children: [
            Container(
              constraints:
                  BoxConstraints(maxWidth: Get.width * .8, maxHeight: 100),
              padding: const EdgeInsets.all(10),
              child: widget.booking?.vehicleId?.image != ''
                  ? Image.network(
                      "$domainName${widget.booking?.vehicleId?.image}",
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
            const SizedBox(height: 5),
            Text(
              'Booking ID',
              style: tsPoppins(
                weight: FontWeight.bold,
                color: textDark40,
                size: 18,
              ),
            ),
            Text(
              widget.booking?.bookingId ?? '',
              style: tsPoppins(
                weight: FontWeight.w400,
                color: textDark40,
                size: 16,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date',
                  style: tsPoppins(
                    weight: FontWeight.bold,
                    color: textDark40,
                    size: 18,
                  ),
                ),
                Text(
                  widget.booking!.date!
                      .substring(0, widget.booking!.date!.indexOf('T')),
                  textAlign: TextAlign.end,
                  style: tsPoppins(
                    color: textDark40,
                    size: 16,
                  ),
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
                    color: textDark40,
                    weight: FontWeight.bold,
                    size: 18,
                  ),
                ),
                Text(
                  widget.booking?.bookingType ?? '',
                  style: tsPoppins(
                    weight: FontWeight.w400,
                    color: textDark40,
                    size: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            if (widget.addressLocaiton != "")
              Text(
                'Address',
                style: tsPoppins(
                  weight: FontWeight.bold,
                  color: textDark40,
                  size: 18,
                ),
              ),
            if (widget.addressLocaiton != "")
              Text(
                widget.booking?.addressId?.location ?? '',
                style: tsPoppins(
                  weight: FontWeight.w400,
                  color: textDark40,
                  size: 16,
                ),
              ),
            if (widget.addressLocaiton != "") const SizedBox(height: 5),
            Text(
              'Branch',
              style: tsPoppins(
                weight: FontWeight.bold,
                color: textDark40,
                size: 18,
              ),
            ),
            Text(
              widget.booking?.branchId?.name ?? '',
              style: tsPoppins(
                weight: FontWeight.w400,
                color: textDark40,
                size: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Time Slot',
              style: tsPoppins(
                weight: FontWeight.bold,
                color: textDark40,
                size: 18,
              ),
            ),
            Text(
              '${widget.booking?.timeSlotId?.startTime}-${widget.booking?.timeSlotId?.endTime}',
              style: tsPoppins(
                weight: FontWeight.w400,
                color: textDark40,
                size: 16,
              ),
            ),
            Text(
              'Customer Details',
              style: tsPoppins(
                weight: FontWeight.bold,
                color: textDark40,
                size: 18,
              ),
            ),
            Text(
              'Name  ${widget.booking?.customerId?.name ?? ''}',
              style: tsPoppins(
                weight: FontWeight.w400,
                color: textDark40,
                size: 16,
              ),
            ),
            Text(
              'Email  ${widget.booking?.customerId?.email ?? ''}',
              style: tsPoppins(
                weight: FontWeight.w400,
                color: textDark40,
                size: 16,
              ),
            ),
            Text(
              'Phone  ${widget.booking?.customerId?.phoneNumber ?? ''}',
              style: tsPoppins(
                weight: FontWeight.w400,
                color: textDark40,
                size: 16,
              ),
            ),
            if (widget.booking!.package!.isNotEmpty)
              Text(
                'Package',
                style: tsPoppins(
                    weight: FontWeight.bold, color: textDark40, size: 18),
              ),
            if (widget.booking!.package!.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.booking?.package?.length,
                itemBuilder: (context, packageIndex) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.booking?.package?[packageIndex].packageId
                                ?.title ??
                            '',
                        style: tsPoppins(
                          weight: FontWeight.w400,
                          color: textDark40,
                          size: 16,
                        ),
                      ),
                      Text(
                        "Price - ${widget.booking?.package?[packageIndex].packageId?.price}",
                        style: tsPoppins(
                          weight: FontWeight.w400,
                          color: textDark40,
                          size: 16,
                        ),
                      ),
                    ],
                  );
                },
              ),
            if (widget.booking!.service!.isNotEmpty)
              Text(
                'Service',
                style: tsPoppins(
                  weight: FontWeight.bold,
                  color: textDark40,
                  size: 18,
                ),
              ),
            if (widget.booking!.service!.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.booking?.service?.length,
                itemBuilder: (context, serviceIndex) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.booking?.service?[serviceIndex].serviceId
                                ?.title ??
                            '',
                        style: tsPoppins(
                          weight: FontWeight.w400,
                          color: textDark40,
                          size: 16,
                        ),
                      ),
                      Text(
                        "Price - ${widget.booking?.service?[serviceIndex].serviceId?.price}",
                        style: tsPoppins(
                          weight: FontWeight.w400,
                          color: textDark40,
                          size: 16,
                        ),
                      ),
                    ],
                  );
                },
              ),
            if (widget.booking!.service!.isNotEmpty) const SizedBox(height: 5),
            if (widget.booking!.spare!.isNotEmpty)
              Text(
                'Spare',
                style: tsPoppins(
                  weight: FontWeight.bold,
                  color: textDark40,
                  size: 18,
                ),
              ),
            if (widget.booking!.spare!.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.booking?.spare?.length,
                itemBuilder: (context, spareIndex) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.booking?.spare?[spareIndex].spareId?.title ?? '',
                        style: tsPoppins(
                          weight: FontWeight.w400,
                          color: textDark40,
                          size: 16,
                        ),
                      ),
                      Text(
                        "Price - ${widget.booking?.spare?[spareIndex].spareId?.price} AED",
                        style: tsPoppins(
                          weight: FontWeight.w400,
                          color: textDark40,
                          size: 16,
                        ),
                      ),
                    ],
                  );
                },
              ),
            if (widget.booking!.spare!.isNotEmpty) const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price',
                  style: tsPoppins(
                    weight: FontWeight.bold,
                    color: textDark40,
                    size: 18,
                  ),
                ),
                Text(
                  "AED ${widget.booking?.totalAmount}",
                  textAlign: TextAlign.end,
                  style: tsPoppins(
                    color: textDark40,
                    size: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (role == 'superAdmin' ||
                role == 'admin' ||
                role == 'serviceManager')
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (widget.booking?.approvalStatus == 'Pending' ||
                      widget.booking?.approvalStatus == 'Confirmed' ||
                      widget.booking?.approvalStatus == 'Assigned')
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ElevatedButton(
                          onPressed: () {
                            widget.controller?.updateBookingStatus(
                                'Cancelled', widget.booking?.sId ?? '');
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: bgColor29),
                          child: Text(
                            '   Cancel   ',
                            style: tsPoppins(
                                weight: FontWeight.w600, color: white),
                          )),
                    ),
                  if (widget.booking?.approvalStatus == 'Pending')
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ElevatedButton(
                          onPressed: () {
                            widget.controller?.updateBookingStatus(
                                'Confirmed', widget.booking?.sId ?? '');
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: bgColor37),
                          child: Text(
                            '  Confirm  ',
                            style: tsPoppins(
                                weight: FontWeight.w600, color: white),
                          )),
                    ),
                  if (widget.booking!.approvalStatus == 'Confirmed' &&
                      widget.booking!.spare!.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ElevatedButton(
                        onPressed: () {
                          // add spare comment

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ManualSpareScreen(
                              bookingId: widget.booking?.sId ?? '',
                              totalAmount:
                                  widget.booking?.totalAmount.toString() ?? '',
                            ),
                          ));
                        },
                        child: Text(
                          '  Add Spare  ',
                          style:
                              tsPoppins(weight: FontWeight.w600, color: white),
                        ),
                      ),
                    ),
                  if (widget.booking!.approvalStatus == 'Confirmed')
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
                                      if (role == "serviceManager")
                                        DropdownButtonFormField<String>(
                                          decoration: const InputDecoration(
                                              labelText: 'Select Technician'),
                                          items: technicianList
                                              .map<DropdownMenuItem<String>>(
                                                  (technician) {
                                            return DropdownMenuItem<String>(
                                              value: technician.id,
                                              child: Text(technician.name),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            technicianId = value ?? '';
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
                                              if (role == 'superAdmin' ||
                                                  role == 'admin') {
                                                widget.controller
                                                    ?.assignToServiceManager(
                                                  widget.booking?.sId ?? '',
                                                  managerId ?? '',
                                                );
                                              } else {
                                                widget.controller
                                                    ?.assignToTechnician(
                                                  widget.booking?.sId ?? '',
                                                  technicianId ?? '',
                                                );
                                              }
                                              Navigator.of(context).pop();
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
                  if (widget.booking?.approvalStatus == 'Assigned')
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: bgColor37),
                        onPressed: () {
                          log(widget.booking!.sId.toString());
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TrackingView(
                              bookingId: widget.booking?.sId ?? '',
                            ),
                          ));
                        },
                        child: const Text('   Track   '),
                      ),
                    ),
                  if (widget.booking?.approvalStatus == 'Assigned')
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: bgColor38),
                        onPressed: () {
                          log(widget.booking!.sId.toString());
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const InvoiceView(),
                            ),
                          );
                          Provider.of<InvoiceProvider>(context, listen: false)
                              .fetchInvoice(
                            widget.booking!.sId.toString(),
                          );
                        },
                        child: const Text('   Invoice   '),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
