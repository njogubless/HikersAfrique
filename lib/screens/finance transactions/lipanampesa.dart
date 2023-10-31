// // daraja_service.dart

// import 'package:safaricom_daraja/safaricom_daraja.dart';

// class DarajaService {
//   static Future<LipaNaMpesaApiResponse> initiateLipaNaMpesaPayment(double totalAmount, String phoneNumber) async {
//     final lipaNaMpesa = LipaNaMpesaOnline(
//       phoneNumber: phoneNumber,
//       passKey: 'YOUR_LIPA_NA_MPESA_ONLINE_PASSKEY',
//       shortCode: 'YOUR_LIPA_NA_MPESA_ONLINE_SHORTCODE',
//     );

//     // Generate a unique reference ID for this transaction
//     String referenceId = 'ORDER_${DateTime.now().millisecondsSinceEpoch}';

//     LipaNaMpesaApiResponse response = await lipaNaMpesa.initializePayment(
//       businessShortCode: lipaNaMpesa.shortCode,
//       amount: totalAmount.toString(),
//       phoneNumber: lipaNaMpesa.phoneNumber,
//       callbackUrl: 'YOUR_CALLBACK_URL', // Provide a callback URL to handle responses from Safaricom
//       accountReference: 'Ticket Purchase',
//       transactionDesc: 'Purchase of $numberOfTickets ticket(s)',
//       passKey: lipaNaMpesa.passKey,
//       reference: referenceId,
//     );

//     return response;
//   }
// }
