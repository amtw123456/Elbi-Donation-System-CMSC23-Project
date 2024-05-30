import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_app/models/donation_drive_model.dart';
import 'package:firebase_core/firebase_core.dart';

class fireBaseOrganizationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  final Stream<QuerySnapshot> _donationDriveStreams =
      db.collection('donationDriveModels').snapshots();
  Stream<QuerySnapshot> get donationDriveStream => _donationDriveStreams;

  // make sure that the id is already present
  // (the id should be the same as the auth id)
  Future<Map<String, dynamic>> addDonationDriveModel(
      Map<String, dynamic> donationDriveModel) async {
    try {
      await db
          .collection("donationDriveModels")
          .doc(donationDriveModel['id'])
          .set(donationDriveModel);

      return {'success': true, 'message': "Successfully added!"};
    } on FirebaseException catch (e) {
      return {
        'success': false,
        'error': 'Firebase Error: ${e.code} : ${e.message}'
      };
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> deleteDonationDriveModel(String id) async {
    try {
      await db.collection("donationDriveModels").doc(id).delete();

      return {'success': true, 'message': "Successfully deleted!"};
    } on FirebaseException catch (e) {
      return {
        'success': false,
        'error': 'Firebase Error: ${e.code} : ${e.message}'
      };
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> getDonationDriveModel(String id) async {
    try {
      final doc = await db.collection("donationDriveModels").doc(id).get();
      DonationDriveModel donationDriveModel =
          DonationDriveModel.fromJson(doc.data() as Map<String, dynamic>);
      return {'success': true, 'donationDriveModel': donationDriveModel};
    } on FirebaseException catch (e) {
      return {
        'success': false,
        'error': 'Firebase Error: ${e.code} : ${e.message}'
      };
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  // view all organizations
  Future<Map<String, dynamic>> getOrganizationDonationDrives() async {
    try {
      List<DonationDriveModel> orgs = [];
      final snapshots = await db
          .collection("donationDriveModels")
          .where("type", isEqualTo: "org")
          .get();
      for (var snapshot in snapshots.docs) {
        orgs.add(DonationDriveModel.fromJson(snapshot.data()));
      }
      return {'success': true, 'orgs': orgs};
    } on FirebaseException catch (e) {
      return {
        'success': false,
        'error': 'Firebase Error: ${e.code} : ${e.message}'
      };
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  // The reason why i commented it out is because that portion of the code
  // can cause problems, because not all operations involve adding something
  // in the list of donations, eg, delete

  Future<Map<String, dynamic>> updateDonationDrives(
      String id, Map<String, dynamic> updates) async {
    try {
      // Update the document with the given id

      // if (updates['listOfDonationsId'] != null) {
      //   // Use FieldValue.arrayUnion for organizationDriveList
      //   updates['listOfDonationsId'] = FieldValue.arrayUnion(
      //       updates['listOfDonationsId'] is List
      //           ? updates['listOfDonationsId']
      //           : [updates['listOfDonationsId']]);
      // }

      await FirebaseFirestore.instance
          .collection("donationDriveModels")
          .doc(id)
          .update(updates);

      return {'success': true, 'message': "Successfully updated!"};
    } on FirebaseException catch (e) {
      return {
        'success': false,
        'error': 'Firebase Error: ${e.code} : ${e.message}'
      };
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  // dereference the donation from donation drives
  Future<Map<String, dynamic>> dereferenceDonation(String donationId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("donationDriveModels")
          .where('listOfDonationsId', arrayContains: donationId)
          .get();

      // because it's a delicate operation
      WriteBatch batch = FirebaseFirestore.instance.batch();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        DocumentReference docRef = FirebaseFirestore.instance
            .collection("donationDriveModels")
            .doc(doc.id);
        batch.update(docRef, {
          'listOfDonationsId': FieldValue.arrayRemove([donationId])
        });
      }

      // finally commit
      await batch.commit();

      return {'success': true, 'message': "Successfully updated!"};
    } on FirebaseException catch (e) {
      return {
        'success': false,
        'error': 'Firebase Error: ${e.code} : ${e.message}'
      };
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }
}
