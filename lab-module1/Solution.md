# Module 1 Lab — Solution Walkthrough
## The Whistleblower's Mistake

---

### Overview

This lab is built around a single crafted email. The goal is to analyze its metadata — specifically
its headers — to determine the true origin of the message. The sender attempted to disguise their
identity by spoofing the `From` field, but made technical mistakes that expose their real sending
platform, email client, and approximate location.

All answers are contained within the raw email headers. The webmail interface intentionally does
not expose headers — students must download the `.eml` file and inspect it manually.

---

### Step 1 — Log into the webmail

Open a browser and navigate to:

```
http://localhost:8080
```

Log in with the provided credentials:

- **User:** `journalist@arcturus-news.com`
- **Password:** `osint2025`

You will land in the inbox where one email is waiting — the anonymous tip from the alleged
Arcturus Systems sysadmin.

---

### Step 2 — Download the .eml file

The webmail interface does not show full email headers. You need to download the raw email file.

1. Open the email by clicking on it
2. Look for the **More options** menu — typically a three-dot icon or a dropdown in the message toolbar
3. Select **Export**
4. Save the file locally — for example as `whistleblower.eml`

> **Why .eml?**
> An `.eml` file is the raw format of an email message. It contains the full message including
> all headers, body, and attachments in plain text. Email clients typically hide most headers
> from the user interface — the `.eml` file is the only way to see everything.

---

### Step 3 — Open and inspect the raw headers

Open the `.eml` file in a plain text editor (Notepad, VSCode, nano, etc.) or paste its contents
into an online header analyzer such as:

- [MXToolbox Email Header Analyzer](https://mxtoolbox.com/EmailHeaders.aspx)
- [Google Admin Toolbox](https://toolbox.googleapps.com/apps/messageheader/)

The file will look something like this at the top:

```
Received: from mail.tutanota.com (mail.tutanota.com [81.3.3.101])
        by mx.arcturus-news.com (Postfix) with ESMTPS
        id A1B2C3D4E5; Tue, 14 Jan 2025 11:22:10 +0530
Received: from webmail.tutanota.com ...
Received: from [127.0.0.1] ...
From: anonymous.source@protonmail.com
To: journalist@arcturus-news.com
Date: Tue, 14 Jan 2025 11:22:06 +0530
Message-ID: <xk39vq82ls@tutanota.com>
X-Mailer: Tutanota Web 3.118
Subject: Arcturus Systems — They buried it
```

Everything above the blank line is a **header**. Everything below it is the **body**.

> **How to read Received headers:**
> Emails pass through multiple servers before reaching their destination. Each server stamps a
> `Received` header as the email passes through it. They are written in reverse chronological
> order — the **bottom-most** `Received` block is where the email originated, and the
> **top-most** is the last server it passed through before delivery.

---

### F1 — Claimed sending provider

**Question:** What email provider does the `From` address claim to be from?

Look at the `From` header:

```
From: anonymous.source@protonmail.com
```

The domain is `protonmail.com` — a well-known privacy-focused email provider. The sender wants
you to believe they are writing from ProtonMail.

**Answer:** `protonmail`

---

### F2 — Actual sending server

**Question:** What is the actual domain of the sending mail server?

Read the `Received` headers from the **bottom up**. The lowest one shows:

```
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by webmail.tutanota.com (Postfix) with ESMTP
```

This tells us the email was processed by `webmail.tutanota.com` — a server belonging to
**Tutanota**, a completely different email provider to what the `From` field claimed.

Moving up one hop confirms it:

```
Received: from webmail.tutanota.com (webmail.tutanota.com [81.3.3.102])
        by mail.tutanota.com (Postfix) with ESMTP
```

The originating domain is `mail.tutanota.com`.

**Answer:** `mail.tutanota.com`

---

### F3 — Identity mismatch

**Question:** Does the `From` address domain match the actual sending server domain?

- `From` claims: `protonmail.com`
- Actual sending server: `mail.tutanota.com`

These are different providers entirely. The `From` field was **spoofed** — manually set to a
false address to mislead the recipient.

> **What is From spoofing?**
> The `From` header in an email is not verified by default. Anyone can set it to any value they
> want. This is why you should never trust the `From` field alone — always cross-reference it
> against the `Received` headers, `Message-ID`, and `X-Mailer` fields to determine the true
> origin of an email.

**Answer:** `no`

---

### F4 — Timezone offset

**Question:** What is the timezone offset found in the `Date` header?

Look at the `Date` header:

```
Date: Tue, 14 Jan 2025 11:22:06 +0530
```

The offset is the value at the end of the timestamp — `+0530`.

> **What does the timezone offset tell us?**
> The timezone offset reflects the local time settings of the device or server that sent the
> email. It does not definitively prove the sender's location — a technically aware sender could
> change their system timezone — but it is a useful indicator, especially when corroborated by
> other evidence.

**Answer:** `+0530`

---

### F5 — Email client

**Question:** What email client was used to compose and send this message?

Look for the `X-Mailer` header:

```
X-Mailer: Tutanota Web 3.118
```

The `X-Mailer` header is added automatically by the email client used to compose the message.
Here it reveals that the sender used the **Tutanota web client**, version `3.118` — directly
contradicting the ProtonMail claim in the `From` field. This is the third piece of evidence
confirming Tutanota as the real sending platform.

> **Note:** Not all email clients include an `X-Mailer` header, and some privacy-focused
> providers strip it. When present, it is a valuable fingerprint.

**Answer:** `Tutanota Web 3.118`

---

### F6 — Approximate sender region

**Question:** Based on the timezone offset in the `Date` header, which country is the sender
most likely located in?

The offset `+0530` corresponds to **Indian Standard Time (IST)**. This offset is used
exclusively by India — no other country in the world uses UTC+0530 as its standard timezone.

You can verify this by searching for `UTC+0530` or `+0530 timezone` in any search engine or
timezone reference such as [timeanddate.com](https://www.timeanddate.com).

**Answer:** `india`

---

### Summary of Findings

| Flag | Header | Finding |
|------|--------|---------|
| F1 | `From` | Sender claimed to use ProtonMail |
| F2 | `Received` | Actual sending server was Tutanota |
| F3 | `From` vs `Received` | From address was spoofed — domains do not match |
| F4 | `Date` | Timezone offset is +0530 |
| F5 | `X-Mailer` | Email composed using Tutanota Web 3.118 |
| F6 | `Date` | UTC+0530 is exclusive to India |

The sender made three independent mistakes that all point to the same conclusion — they used
Tutanota, not ProtonMail, and they did so from a device set to Indian Standard Time. A single
header field might be manipulated, but three independent fields telling the same story makes the
finding reliable.