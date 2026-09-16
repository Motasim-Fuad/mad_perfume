# MAD Perfume API integration

The app uses the staging API documented in
`docs/MadPerfume-App-API.postman_collection.json`.

## Implemented

- Email or phone login, registration, rotating JWT refresh, and logout
- Three-step password reset
- Profile, notification preferences, and password change
- Categories, banners, products, product details, search, reviews, and saved products
- Branch listing and branch details
- Server-side cart and order checkout with an idempotency key
- Orders and backend order status tracking
- Loyalty summary, points history, rewards, redemptions, and notifications
- Backend-aligned 8% checkout tax preview, free shipping, and `card` or `cod`

GetX remains responsible for routing and localization. Feature and server state use
`flutter_bloc`, dependencies use `get_it`, and HTTP traffic uses Dio.

## Backend or configuration gaps

- Card checkout can return a Stripe `client_secret`, but the repository does not
  contain Stripe publishable keys or PaymentSheet configuration. The app does not
  collect raw card details or fake a successful payment.
- Google and Apple authentication endpoints are not included in the supplied
  Postman collection. Their buttons report that the feature is unavailable.
- Push device endpoints exist, but Firebase Cloud Messaging configuration and
  platform credentials are not present, so device registration is not enabled.

These flows should be enabled only after their backend contracts and platform
credentials are supplied.
