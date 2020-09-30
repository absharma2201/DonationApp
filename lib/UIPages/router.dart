
import 'package:flutter/material.dart';
import 'package:iwish_app/CloudDatabase/email_password_sign_in_ui.dart';
import 'package:iwish_app/app/landing_page.dart';

import 'package:iwish_app/jobs/new_donation_page.dart';
import 'package:iwish_app/jobs/new_enquiry.dart';
import 'package:iwish_app/jobs/new_event.dart';
import 'package:iwish_app/jobs/new_post_page.dart';
import 'package:iwish_app/jobs/new_request_page.dart';

class Routes {
  static const emailPasswordSignInPage = '/email-password-sign-in-page';
  static const newDonationPage = '/new-donation-page';
  static const newRequestPage = '/new-request-page';

  static const newPostPage = '/new-post-page';
  static const newEnquiryPage = '/new-enquiry-page';
  static const newEventPage = '/new-event-page';

  //landingPage
  static const landingPage = '/landing-page';


}

class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.emailPasswordSignInPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => EmailPasswordSignInPage(onSignedIn: args),
          settings: settings,
          fullscreenDialog: true,
        );

      case Routes.newDonationPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => NewDonationPage(donation: args),
          settings: settings,
          fullscreenDialog: true,
        );

      case Routes.newRequestPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => NewRequestPage(request: args),
          settings: settings,
          fullscreenDialog: true,
        );

      case Routes.newPostPage:
      return MaterialPageRoute<dynamic>(
        builder: (_) => NewPostPage(post: args),
        settings: settings,
        fullscreenDialog: true,
      );

      case Routes.newEventPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => NewEventPage(event: args),
          settings: settings,
          fullscreenDialog: true,
        );

      case Routes.newEnquiryPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => NewEnquiryPage(enquiry: args),
          settings: settings,
          fullscreenDialog: true,
        );

      case Routes.landingPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => LandingPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      default:
      // TODO: Throw
        return null;
    }
  }
}