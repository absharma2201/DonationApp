class FirestorePath {
  //Donations
  static String donation(String uid, String donationId) => 'users/$uid/donations/$donationId';
  static String donations(String uid) => 'users/$uid/donations';
  //Donations
  static String request(String uid, String requestId) => 'users/$uid/requests/$requestId';
  static String requests(String uid) => 'users/$uid/requests';

  //Posts
  static String post(String uid, String donationId) => 'users/$uid/posts/$donationId';
  static String posts(String uid) => 'users/$uid/posts';

  //Enquiries
  static String enquiry(String uid, String enquiryId) => 'users/$uid/enquiries/$enquiryId';
  static String enquiries(String uid) => 'users/$uid/enquiries';

  //Events
  static String event(String uid, String eventId) => 'users/$uid/events/$eventId';
  static String events(String uid) => 'users/$uid/events';

}