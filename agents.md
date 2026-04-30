# AGENTS.md

## Project Name
SIM Renewal Manager

## Mission
Build a production-grade cross-platform mobile app for Android and iOS that helps users manage multiple SIM-based accounts and never miss package renewals through smart tracking, reminders, offline support, and cloud sync.

---

# MASTER AGENT ROLE

You are an elite senior software delivery agent acting as:

- Product Manager
- Senior Flutter Architect
- UI/UX Designer
- Firebase Engineer
- QA Lead
- DevOps Engineer
- Security Reviewer
- Performance Optimizer

You own this project end-to-end.

Your objective is to deliver a polished, scalable, store-ready mobile application.

---

# PRIMARY STACK (MANDATORY)

## Frontend
- Flutter (latest stable)
- Dart

## State Management
- Riverpod (preferred)

## Backend
- Firebase Auth
- Cloud Firestore
- Firebase Cloud Messaging
- Firebase Crashlytics
- Firebase Analytics

## Offline Storage
- Isar (preferred) or Hive

## Navigation
- go_router

---

# APP PURPOSE

Users often manage many accounts tied to separate SIM cards (example: Fiverr accounts, freelance accounts, business SIMs, data packages, reseller numbers).

They need to know:

- Which package expires when
- Which account needs recharge
- Which SIM belongs to which device
- What expires this week
- How to recharge multiple accounts quickly

The app solves this professionally.

---

# CORE FEATURES TO BUILD

# 1. ACCOUNT MANAGEMENT

Support complete CRUD.

## Fields

- id
- accountName
- simNumber
- deviceName
- packageType
- activationDate
- expiryDate
- customDurationDays
- notes
- createdAt
- updatedAt
- isArchived
- lastRechargeDate

## Package Types

- Weekly
- Monthly
- Custom

## Actions

- Add account
- Edit account
- Delete account
- Archive account
- Restore account
- Duplicate account

---

# 2. SMART EXPIRY SYSTEM

## Rules

Weekly = activationDate + 7 days

Monthly = activationDate + 30 days

Custom = activationDate + customDurationDays

## Show

- Days left
- Exact expiry date
- Expired label
- Status color

## Colors

Green = Safe

Yellow = 2 to 3 days left

Red = Today or expired

---

# 3. NOTIFICATION SYSTEM

Implement reliable reminders.

## Default Alerts

- 1 day before expiry
- On expiry day

## Custom Options

- 3 days before
- 2 days before
- 1 day before
- Same day
- Disable

## Must Support

- Local notifications offline
- Push notifications online
- Timezone safe scheduling
- Reschedule after edits

---

# 4. DASHBOARD

Build premium dashboard.

## Summary Cards

- Total Accounts
- Expiring Today
- Expiring This Week
- Expired

## List Items

Each account row shows:

- Account Name
- SIM Number
- Device Name
- Days Left
- Status
- Quick Recharge Button

## Filters

- All
- Active
- Expiring Soon
- Expired
- Weekly
- Monthly
- Custom

## Sorting

- Nearest expiry
- Newest
- Oldest
- Alphabetical

---

# 5. BULK ACTIONS

Multi-select accounts.

## Actions

- Mark Recharged
- Update activation date to today
- Archive selected
- Delete selected
- Export selected

When Recharged:

- activationDate = chosen date
- recalculate expiryDate
- reschedule reminders

---

# 6. AUTH + CLOUD SYNC

Optional but production ready.

## Login Methods

- Google Sign-In
- Apple Sign-In
- Email/Password

## Sync Rules

- Offline-first
- Queue local changes
- Sync when internet returns
- latest updatedAt wins

---

# 7. OFFLINE FIRST

App must work without internet.

## Offline Support

- Add/Edit/Delete
- Dashboard
- Filters
- Search
- Notifications
- Bulk recharge

---

# 8. UI/UX REQUIREMENTS

## Design Style

- Clean
- Fast
- Minimal
- Professional
- Modern

## Themes

- Light mode
- Dark mode
- System mode

## UX Expectations

- Fast taps
- No lag
- Smooth scrolling
- Swipe actions
- Empty states
- Loading skeletons

---

# 9. FUTURE READY ARCHITECTURE

Must support future features:

- Google Sheets sync
- CSV export
- API integrations
- Auto renew purchase
- Web admin panel
- Shared team accounts
- Subscription plans

---

# CLEAN ARCHITECTURE (MANDATORY)

Use structure:

```text
lib/
 ├── core/
 ├── shared/
 ├── features/
 │    ├── auth/
 │    ├── dashboard/
 │    ├── accounts/
 │    ├── notifications/
 │    ├── settings/
 │    └── sync/
 └── main.dart