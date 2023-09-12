import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/modules/reports/models/booking_report.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailBookingReport extends StatelessWidget {
  const DetailBookingReport({super.key, required this.bookingReport});

  final Data bookingReport;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Report Detail',
          style: TextStyle(
            color: white,
          ),
        ),
        backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
          top: 10,
        ),
        child: ListView(
          children: [
            Row(
              children: [
                const Text(
                  'Booking Id',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  ' - ${bookingReport.bookingId}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Branch Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  ' - ${bookingReport.branchId?.name}',
                  style: const TextStyle(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Customer name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  ' - ${bookingReport.customerId?.name}',
                  style: const TextStyle(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Customer email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  ' - ${bookingReport.customerId?.email}',
                  style: const TextStyle(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Customer phone',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  ' - ${bookingReport.customerId?.phoneNumber}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Vehicle No',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  ' - ${bookingReport.vehicleId?.plateNumber}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (bookingReport.package!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Packages',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bookingReport.package?.length,
                    itemBuilder: (context, packageIndex) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${packageIndex + 1}. ${bookingReport.package?[packageIndex].packageId?.title}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '     Price: ${bookingReport.package?[packageIndex].packageId?.price} AED',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            if (bookingReport.package!.isNotEmpty) const SizedBox(height: 10),

            //Service
            if (bookingReport.service!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Services',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bookingReport.service?.length,
                    itemBuilder: (context, serviceIndex) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${serviceIndex + 1}. ${bookingReport.service?[serviceIndex].serviceId?.title}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '     Service Period: ${bookingReport.service?[serviceIndex].serviceId?.servicePeriod}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '     Price: ${bookingReport.service?[serviceIndex].serviceId?.price} AED',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            if (bookingReport.service!.isNotEmpty) const SizedBox(height: 10),

            //Spare
            if (bookingReport.spare!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Spares',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bookingReport.spare?.length,
                    itemBuilder: (context, spareIndex) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            " ${spareIndex + 1}. ${'${bookingReport.spare?[spareIndex].spareId?.title}'.capitalize}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '     Price: ${bookingReport.spare?[spareIndex].spareId?.price} AED',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            if (bookingReport.spare!.isNotEmpty) const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Approval Status',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  ' - ${bookingReport.approvalStatus}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Booking Type',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  ' - ${bookingReport.bookingType}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Discount amount',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  ' - ${bookingReport.discountAmount} AED',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Total amount',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  ' - ${bookingReport.totalAmount} AED',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
