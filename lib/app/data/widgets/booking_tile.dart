import 'package:al_dana_admin/app/data/models/booking_model.dart';
import 'package:al_dana_admin/app/data/widgets/booking_details_page.dart';
import 'package:al_dana_admin/app/modules/home/controllers/home_controller.dart';
import 'package:al_dana_admin/app/modules/users/controllers/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    this.onChanged,
    this.controller,
  }) : super(key: key);
  final Data booking;
  final void Function(bool?)? onChanged;
  final HomeController? controller;

  @override
  State<BookingTile2> createState() => _BookingTile2State();
}

class _BookingTile2State extends State<BookingTile2> {
  final userController = Get.put(UsersController());
  Common common = Common();
  @override
  @override
  Widget build(BuildContext context) {
    String addressLocation = widget.booking.addressId?.location ?? '';

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BookingDetailPage(
            booking: widget.booking,
            addressLocaiton: addressLocation,
            controller: widget.controller,
          ),
        ));
      },
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
                          Text(
                            'Booking ID',
                            style: tsPoppins(
                                weight: FontWeight.bold, color: textDark40),
                          ),
                          Text(widget.booking.bookingId ?? '',
                              style: tsPoppins(
                                  weight: FontWeight.w400, color: textDark40)),
                          const SizedBox(height: 5),
                          Text(
                            'Branch',
                            style: tsPoppins(
                                weight: FontWeight.bold, color: textDark40),
                          ),
                          Text(
                            widget.booking.branchId?.name ?? '',
                            style: tsPoppins(
                                weight: FontWeight.w400, color: textDark40),
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
                                weight: FontWeight.w400, color: textDark40),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Price',
                                style: tsPoppins(
                                    weight: FontWeight.bold, color: textDark40),
                              ),
                              Text(
                                "AED ${widget.booking.totalAmount}",
                                textAlign: TextAlign.end,
                                style: tsPoppins(color: textDark40),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
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
