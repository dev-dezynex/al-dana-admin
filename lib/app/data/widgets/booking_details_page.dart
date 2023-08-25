import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/data/models/booking_model.dart';
import 'package:flutter/material.dart';

class BookingDetailPage extends StatefulWidget {
  const BookingDetailPage({
    super.key,
    this.booking,
    this.addressLocaiton,
  });
  final Data? booking;
  final String? addressLocaiton;
  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  @override
  Widget build(BuildContext context) {
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
            Text(
              'Booking ID',
              style: tsPoppins(
                weight: FontWeight.bold,
                color: textDark40,
                size: 18,
              ),
            ),
            Text(
              widget.booking?.sId ?? '',
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
                  return Text(
                    widget.booking?.package?[packageIndex].packageId?.title ??
                        '',
                    style: tsPoppins(
                      weight: FontWeight.w400,
                      color: textDark40,
                      size: 16,
                    ),
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
                  return Text(
                    widget.booking?.service?[serviceIndex].serviceId?.title ??
                        '',
                    style: tsPoppins(
                      weight: FontWeight.w400,
                      color: textDark40,
                      size: 16,
                    ),
                  );
                },
              ),
            const SizedBox(height: 5),
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
          ],
        ),
      ),
    );
  }
}
