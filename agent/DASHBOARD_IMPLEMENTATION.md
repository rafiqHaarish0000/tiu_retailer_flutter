# Dashboard Implementation Guide

## Current structure

The dashboard is implemented in `lib/screens/dashboard.dart`.

- `DashboardScreen` owns the shared dashboard shell.
- The header remains visible across dashboard content.
- The bottom navigation remains visible across dashboard content.
- The Home tab displays the responsive two-column service grid.
- Each service card currently displays a shared `Coming Soon` view inside the dashboard shell.
- Bottom navigation tabs also display their Coming Soon content inside the same shell.

This is the Flutter equivalent of keeping a shared activity layout while replacing the content area. Flutter does this with widgets and navigation state rather than Android fragments.

## Service list

The 18 services are declared in the `_services` list in `lib/screens/dashboard.dart`:

1. Transfer to Wallet
2. Transfer to Stores
3. Top It Up Voucher
4. Pay Suppliers
5. Wholesaler Payments
6. Account Payments
7. My Sales Transactions
8. Commissions & Invoices
9. Financial Transactions
10. Sales & Shift Reports
11. Deposit History
12. Money Transfers
13. POS Users
14. Website Users
15. My Devices
16. View OTP
17. Supplier Orders
18. Top It Up Banking Details

## Adding a service screen

1. Create a new widget in `lib/screens/`, for example `transfer_to_wallet.dart`.
2. Replace the service card callback in `_buildServiceGrid()` with the new widget or a service key.
3. Replace the `_activeService` Coming Soon content with the service widget.
4. Keep the service title, icon, and subtitle in the `_Service` model.

For a service that should keep the dashboard header and bottom navigation, render its widget in the dashboard content area. Use a separate `Navigator.push` route only when the feature needs a full-screen flow.

## Adding bottom navigation screens

Bottom navigation state is stored in `_selectedTab`.

1. Add or update the tab title in `_tabTitle()`.
2. Create the tab widget in `lib/screens/`.
3. Replace `_buildTabComingSoon()` for that tab with the new widget.
4. Keep the widget inside `DashboardScreen` so the header and bottom navigation stay persistent.

## Login flow

After validation succeeds, `LoginScreen.onLoginButtonPressed()` replaces the login route with `DashboardScreen`.

