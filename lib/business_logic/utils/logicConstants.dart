class Constant {
  static const String BASE_URL = "https://beta.purgpt.xyz/openai";
  static const String currentModel = "gpt-3.5-turbo-16k";
}

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
