import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

import '../models/booking_report.dart';

class BookingReportPdfApi {
  static Future<File> generateBookingReport(Data bookingReport) async {
    final pdf = Document();
    pdf.addPage(
      MultiPage(
        build: (context) => [
          basicDetails(bookingReport),
          if (bookingReport.package!.isNotEmpty) heading('Packages'),
          if (bookingReport.package!.isNotEmpty) packageDetails(bookingReport),
          if (bookingReport.service!.isNotEmpty) heading('Services'),
          if (bookingReport.service!.isNotEmpty) servicesDetails(bookingReport),
          if (bookingReport.spare!.isNotEmpty) heading('Spares'),
          if (bookingReport.spare!.isNotEmpty) spareDetails(bookingReport),
          priceDetails(bookingReport),
        ],
      ),
    );
    return saveDocument(name: '${bookingReport.bookingId}.pdf', pdf: pdf);
  }

  static Text heading(String heading) {
    return Text(
      heading,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }

  static Widget packageDetails(Data bookingReport) {
    final package = bookingReport.package;
    return Column(
        children: List.generate(package?.length ?? 0, (packageIndex) {
      final index = packageIndex + 1;
      final title = package?[packageIndex].packageId?.title;
      final price = package?[packageIndex].packageAmount;
      return unitBox(index.toString(), title ?? '', price.toString());
    }));
  }

  static Widget servicesDetails(Data bookingReport) {
    final service = bookingReport.service;
    return Column(
        children: List.generate(service?.length ?? 0, (serviceIndex) {
      final index = serviceIndex + 1;
      final title = service?[serviceIndex].serviceId?.title;
      final price = service?[serviceIndex].serviceAmount;
      return unitBox(index.toString(), title ?? '', price.toString());
    }));
  }

  static Widget spareDetails(Data bookingReport) {
    final spare = bookingReport.spare;
    return Column(
        children: List.generate(spare?.length ?? 0, (spareIndex) {
      final index = spareIndex + 1;
      final title = spare?[spareIndex].spareId?.title;
      final price = spare?[spareIndex].spareAmount;
      return unitBox(index.toString(), title ?? '', price.toString());
    }));
  }

  static Widget unitBox(
    String index,
    String title,
    String price,
  ) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        '$index. $title',
        style: const TextStyle(fontSize: 18),
      ),
      SizedBox(height: 5),
      Text(
        '     Price: $price AED',
        style: const TextStyle(fontSize: 18),
      ),
    ]);
  }

  static Column priceDetails(Data bookingReport) {
    return Column(children: [
      SizedBox(height: 10),
      Row(
        children: [
          Text(
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
      SizedBox(height: 10),
      Row(
        children: [
          Text(
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
    ]);
  }

  static Column basicDetails(Data bookingReport) {
    return Column(
      children: [
        Row(
          children: [
            Text(
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
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              'Branch Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              ' - ${bookingReport.branchId?.name}',
              style: const TextStyle(fontSize: 18),
              overflow: TextOverflow.visible,
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              'Customer name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              ' - ${bookingReport.customerId?.name}',
              style: const TextStyle(fontSize: 18),
              overflow: TextOverflow.visible,
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              'Customer email',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              ' - ${bookingReport.customerId?.email}',
              style: const TextStyle(fontSize: 18),
              overflow: TextOverflow.visible,
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
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
        SizedBox(height: 10),
        Row(
          children: [
            Text(
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
        SizedBox(height: 10),
        Row(
          children: [
            Text(
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
        SizedBox(height: 10),
        Row(
          children: [
            Text(
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
        SizedBox(height: 10),
      ],
    );
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}
