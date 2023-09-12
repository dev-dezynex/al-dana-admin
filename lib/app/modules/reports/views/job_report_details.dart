import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/modules/reports/models/job_report.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobReportDetailScreen extends StatelessWidget {
  const JobReportDetailScreen({super.key, required this.jobReport});

  final Data jobReport;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Job Report Details',
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
                  ' - ${jobReport.bookingId?.bookingId}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
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
                  ' - ${jobReport.bookingId?.branchId?.name}'
                      .capitalize
                      .toString(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Customer Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  ' - ${jobReport.bookingId?.customerId?.name}'
                      .capitalize
                      .toString(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Customer Email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  ' - ${jobReport.bookingId?.customerId?.email}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Customer Phone',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  ' - ${jobReport.bookingId?.customerId?.phoneNumber}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Address Type',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  ' - ${jobReport.bookingId?.addressId?.addressType}'
                      .capitalize
                      .toString(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Address - ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Flexible(
                  child: Text(
                    '${jobReport.bookingId?.addressId?.location}',
                    style: const TextStyle(
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 6,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Vehicle No  - ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${jobReport.bookingId?.vehicleId?.plateNumber}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            if (jobReport.packageId != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Package  - ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '${jobReport.packageId?.title}',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            if (jobReport.packageId != null) const SizedBox(height: 10),
            if (jobReport.serviceId != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Service  - ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '${jobReport.serviceId?.title}',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            if (jobReport.serviceId != null) const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tracking Status  - ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${jobReport.trackingStatus}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Approval Status  - ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${jobReport.bookingId?.approvalStatus}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Time Slot  - ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${jobReport.bookingId?.timeSlotId?.startTime} : ${jobReport.bookingId?.timeSlotId?.endTime}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Max Booking  - ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${jobReport.bookingId?.timeSlotId?.maxBooking}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Discount amount  - ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${jobReport.bookingId?.discountAmount} AED',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total amount  - ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${jobReport.bookingId?.totalAmount} AED',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
