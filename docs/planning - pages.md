Customer-facing Pages

This document outlines the key customer-facing pages for SmartTax, including their purpose, key elements, and user experience considerations.

- Keep language simple and customer-focused (avoid jargon). Each page should present one primary action up-front (e.g., "Calculate your estimate", "Add an expense").
- For tax-related pages include contextual help links or short explanations next to inputs (tooltip or small help text) to reduce confusion.

## Sign In

Purpose: allow returning customers to securely access their account and dashboard.

- Key elements:
- Email or username field
- Password field
- "Remember me" checkbox
- "Sign in" button
- "Forgot password" link (password reset flow)
- Link to Sign Up (if applicable)

Behaviour and UX:
- Inline validation for required fields and basic format
- Clear, friendly error messages (invalid credentials, locked account)
- Optional two-factor / MFA prompt when enabled
- After successful sign-in: redirect to user Dashboard

Benefits
- See your dashboard and filings
- Track payments and deadlines
- Save estimates securely

## FAQ

Purpose: answer common customer questions quickly and reduce support requests.

- Key elements:
- Search box for quick lookup
- Categorised questions (Account, Tax Estimates, Payments, Security)
- Expand/collapse answers (accordion)
- Link to contact form for unanswered questions
- Date / version note for tax-related answers (to show currency)

## Contact

Purpose: let customers get direct help or submit enquiries.

- Key elements:
- Short contact form: name, email, subject, message
- Optional file attachment (receipts, screenshots)
- Support email and phone number (if available)
- Business hours and response-time expectation
- Privacy note: how submitted data will be used
- Spam protection (reCAPTCHA or honeypot)

## About

Purpose: build trust and explain who runs SmartTax and why.

- Key elements:
- Brief mission statement and value proposition
- Author / team credentials (course, university, contact)
- High-level tech stack and security reassurance (data handling, backups)
- Links to terms, privacy policy, and HMRC integration notes

## Terms & Conditions

Purpose: outline the legal terms for using SmartTax.

- Key elements:
- Clear sections: User responsibilities, Data usage, Liability disclaimer
- Last updated date 
- Link to privacy policy

## Privacy Policy

Purpose: inform customers how their data is collected, used, and protected.

- Key elements:
- Data collection details (what data, how collected)
- Data usage purposes (service provision, improvements)
- Data sharing (third parties, HMRC)  
- User rights (access, deletion, corrections)
- Contact info for privacy concerns

## News / Updates

Purpose: publish product updates, tax-rule changes, and announcements.

- Key elements:
- Chronological list of posts with title, date, short excerpt
- Tags or categories (e.g., "Tax changes", "Feature updates")
- Read-more pages for each post
- Subscribe link or newsletter signup

## Tax Dashboard

Purpose: one-page summary of tax position and next actions. These pages help customers 
understand and manage their taxes — each page should be written in plain English and focus on actions the customer can take.

- Displays: estimated tax due, next filing deadline, recent payments, quick actions (add income, add expense, run calculator)

## Income & Expenses

Purpose: let customers record and review their financial transactions

- Features: add/edit/delete entries, categories, upload CSV or receipts, automatic totals and net profit
- Clear CTA: "Add income / Add expense"

## Tax Calculator (Estimator)

Purpose: let customers estimate tax and National Insurance owed for a selected tax year

- Inputs: tax year, total income, allowable expenses, personal allowance options, student loan / pension toggles
- Outputs: breakdown (income tax bands, NI, estimated payment on account), "Save estimate" option

## Self-Assessment / Filing

Purpose: guide customers through preparing and submitting their self-assessment

- Features: checklist of required information, draft submission preview, export PDF, instructions for HMRC submission (if manual)
- Status indicators: Draft, Ready, Submitted (with timestamp/reference)

## Payments & Records

Purpose: show outstanding liabilities and payment history

- Displays: scheduled payments, recent transactions, downloadable receipts, links to make payments (external or guidance)

## Tax History & Reports

Purpose: provide archived year-by-year summaries and downloadable reports

- Features: filter by year, export CSV/PDF, visual summaries (simple charts for income/expenses/tax)

## HMRC Integration / Accounts

Purpose: let customers connect (or view status of) HMRC Making Tax Digital / other integrations.

- Displays: connection status, last sync time, errors and fixes, connect/disconnect actions

