# Module 1 — Email Metadata & Header Analysis

## What Is an Email Header?

Every email you receive contains two distinct parts: the **body** (the message you read) and the **headers** (metadata that describes how the message was created, routed, and delivered). Email clients almost always hide the headers from the user by default, but they are always there and they contain a significant amount of information.

Headers are plain text fields added by email clients, servers, and relay systems at various points in the email's journey. They record things like who sent the message, which servers it passed through, when it was sent, and what software was used to compose it.

---

## Why Headers Matter for OSINT

Unlike the body of an email, headers are difficult to fake completely. While certain fields like `From` can be set to any arbitrary value, the routing information stamped by mail servers along the delivery path is much harder to manipulate — each server adds its own record independently.

This makes email headers a reliable source of technical intelligence. Even when a sender takes steps to hide their identity, the headers often preserve traces of the real origin.

---

## Key Header Fields

**`From`**
The display address of the sender. This field is entirely user-controlled and can be set to anything. It is the least trustworthy header in the message.

**`Received`**
The most valuable header for tracing email origin. Each mail server that handles the message prepends a `Received` header as the email passes through it. Because they are prepended (added to the top), the headers appear in reverse chronological order — the topmost `Received` entry is the last server the email touched before delivery, and the bottommost is the first server to handle it, closest to the original sender.

**`Date`**
The timestamp of when the email was composed or sent, as reported by the sending client or server. This usually includes a timezone offset, which can indicate the sender's local time settings.

**`Message-ID`**
A unique identifier assigned to the message. The domain portion (after the `@`) often reflects the actual sending server, not the `From` domain.

**`X-Mailer` / `User-Agent`**
An optional field added by the email client used to compose the message. Not all clients include it, and some privacy-focused services strip it, but when present it identifies the software and sometimes the version used to write the email.

**`Reply-To`**
A different address where replies should be directed. Discrepancies between `From` and `Reply-To` can indicate redirection or spoofing.

---

## From Spoofing

Email's original design did not include authentication — the `From` field was simply a label, never verified. This means anyone can set `From: anyaddress@anydomain.com` without owning that address or domain.

This technique, known as **From spoofing**, is used both in phishing attacks and by individuals trying to hide which platform they actually sent from. When you receive a suspicious email, never rely on the `From` field alone to determine origin. Cross-reference it against:

- The `Received` headers (which servers actually handled the message)
- The `Message-ID` domain
- The `X-Mailer` field
- Any `Authentication-Results` or `DKIM-Signature` headers

When multiple independent fields contradict the `From` address, the contradiction itself is a finding.

---

## Reading the Received Chain

The `Received` headers form a chain that traces the email's path from sender to inbox. Reading them correctly requires going **bottom to top**:

1. The **bottommost** `Received` entry shows the first server that handled the email — typically the sender's own mail server or the service they used to send it.
2. Each subsequent entry upward shows the next relay in the chain.
3. The **topmost** `Received` entry shows the last server before delivery to your inbox.

Each `Received` header typically contains the hostname and IP address of the sending server, the receiving server, and a timestamp. The IP addresses in particular can be useful — they are harder to falsify than hostnames.

---

## Timezone Offsets as Location Indicators

The `Date` header contains a timezone offset in the format `+HHMM` or `-HHMM` (e.g., `+0530`, `-0500`). This offset reflects the local time configuration of the device or server that generated the timestamp.

It is not definitive proof of location — a technically aware sender can change their system timezone — but it is a useful corroborating indicator, especially when unusual offsets narrow the field significantly. Some timezone offsets are shared by many countries; others are used by only one.

---

## Downloading and Inspecting Raw Email

Most webmail clients and desktop email apps do not show full headers in the normal view. To access them you typically need to:

- **Export or download** the email as a `.eml` file (the raw format)
- Open it in a plain text editor
- Or paste the content into an online header analysis tool

The `.eml` format is a plain text representation of the full email, including all headers, the message body, and any attachments encoded in the file. Everything above the first blank line is headers; everything below is the message body.

---

## Practical Mindset

When analyzing email metadata, treat each header field as one piece of evidence among many. A single anomaly could be a misconfiguration or coincidence. Multiple independent fields pointing to the same conclusion — a different sending platform than claimed, a specific timezone, a revealing `Message-ID` — form a much stronger finding.

The goal of email header analysis is not to make a definitive identification from a single data point, but to build a picture from the full set of technical evidence the message contains.
