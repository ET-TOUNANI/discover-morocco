import 'package:discover_morocco/business_logic/models/models/destination.dart';

import '../models/models/place_category.dart';

class Constant {
  static const String baseUrl = "https://beta.purgpt.xyz/openai";
  static const String fcmBaseUrl = "https://fcm.googleapis.com";
  static const String currentModel = "gpt-3.5-turbo-16k";
  static const String adminId = "gE9TkSESqWVpWDnn4vMOb0CjWbJ3";
}

List<CategoryModel> categories = [
  {
    "id": "1",
    "title": "Mountain",
    "image": "filter_mountain.jpg",
  },
  {
    "id": "2",
    "title": "Beach",
    "image": "filter_beach.jpg",
  },
  {
    "id": "3",
    "title": "Desert",
    "image": "filter_desert.jpg",
  },
  {
    "id": "4",
    "title": "Forest",
    "image": "filter_forest.jpg",
  },
  {
    "id": "5",
    "title": "Sea",
    "image": "filter_sea.jpg",
  },
  {
    "id": "6",
    "title": "Religious",
    "image": "filter_religious.jpeg",
  }
].map((e) => CategoryModel.fromJson(e)).toList();
List<DestinationModel> destinations = [
  {
    'id': '1',
    'city': 'Casablanca',
    'categories': [
      {
        'id': categories.first.id,
        'image': categories.first.image,
        'title': categories.first.title,
      },
      {
        'id': categories.last.id,
        'image': categories.last.image,
        'title': categories.last.title,
      },
      {
        'id': categories[2].id,
        'image': categories[2].image,
        'title': categories[2].title,
      }
    ]
  },
  {
    'id': '2',
    'city': 'Agadir',
    'categories': [
      {
        'id': categories.last.id,
        'image': categories.last.image,
        'title': categories.last.title,
      }
    ]
  }
].map((e) => DestinationModel.fromJson(e)).toList();

const fails = {
  "failureUnknown": "An unknown exception occurred.",
  "failureSignInWithEmailLink":
      "Passwordless signing is not available for this email. Make sure you provided a valid email address and you have been verified it, to verify your email address please login with your password first.",
  "failureAuthentication": "Authentication Failure",
  "failureTooManyRequests":
      "We have blocked all requests from this device due to unusual activity. Try again later.",
  "failureAnonymousNotEnabled": "Anonymous accounts are not enabled",
  "failureQuotaExceeded":
      "Sorry but the sign-up quota of our service is exceeded. Please try again tomorrow, or you can contact our support.",
  "failureEmailBadlyFormatted": "Email is not valid or badly formatted.",
  "failureUserDisabled":
      "This user has been disabled. Please contact support for help.",
  "failureEmailNotFound": "Email is not found, please create an account.",
  "failureIncorrectPassword": "Incorrect password, please try again.",
  "failureOtpExpired": "OTP in email link expired",
  "failureEmailNotValid": "Email address is not valid",
  "failureUserOfEmailDisabled":
      "User corresponding to the given email has been disabled",
  "failureDifferentCredentials": "Account exists with different credentials",
  "failureExpiredMalformedCredential":
      "The credential received is malformed or has expired",
  "failureOperationNotAllowed":
      "Operation is not allowed.  Please contact support",
  "failureInvalidVerificationCode":
      "The credential verification code received is invalid.",
  "failureInvalidVerificationId":
      "The credential verification ID received is invalid.",
  "failureEmailAccountExists": "An account already exists for that email",
  "failureStrongerPassword": "Please enter a stronger password."
};
