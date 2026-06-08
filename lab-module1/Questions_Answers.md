# Module 1 Lab — The Whistleblower's Mistake
## Questions & Answer Key

---

### Briefing

You are an analyst assisting an independent cybersecurity journalist. Earlier today they received
an unusual email from someone claiming to be a systems administrator at a government contractor
called **Arcturus Systems**. The sender alleges that a significant data breach occurred three
months ago and was deliberately concealed from regulators and the public.

The journalist has forwarded you the email and wants answers before deciding whether to pursue
the story. They are not asking you to identify the sender — only to assess the email's technical
credibility and determine what its metadata actually reveals.

**You have been told that email metadata may be important.** Start there.

---

### Access

| | |
|---|---|
| **URL** | `http://localhost:8080` |
| **User** | `journalist@arcturus-news.com` |
| **Password** | `osint2025` |

---

### Questions

---

**F1 — Claimed sending provider**

> What email provider does the `From` address claim to be from?

- **Expected answer:** `protonmail`
- **Format:** Lowercase
- **Hint:** Look at the `From` header field in the downloaded `.eml` file.

---

**F2 — Actual sending server**

> What is the actual domain of the sending mail server?

- **Expected answer:** `mail.tutanota.com`
- **Format:** Exact string, lowercase
- **Hint:** The `Received` headers show the path the email took. Start from the bottom and read upward — the first hop is where the email originated.

---

**F3 — Identity mismatch**

> Does the `From` address domain match the actual sending server domain?

- **Expected answer:** `no`
- **Format:** `yes` or `no`, lowercase
- **Hint:** Compare your answers from F1 and F2.

---

**F4 — Timezone offset**

> What is the timezone offset found in the `Date` header?

- **Expected answer:** `+0530`
- **Format:** Exact format `+0000` — include the plus or minus sign and all four digits
- **Hint:** The `Date` header contains a timestamp followed by a timezone offset.

---

**F5 — Email client**

> What email client was used to compose and send this message?

- **Expected answer:** `Tutanota Web 3.118`
- **Format:** Exact string, case sensitive, include version number
- **Hint:** Look for the `X-Mailer` header field — it is not always visible in email clients and may require inspecting the raw file.

---

**F6 — Approximate sender region**

> Based on the timezone offset in the `Date` header, which country is the sender most likely located in?

- **Expected answer:** `india`
- **Format:** Lowercase
- **Hint:** UTC+0530 is used by a single country exclusively. Cross-reference the offset against a timezone reference list.

---