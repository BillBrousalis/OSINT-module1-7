# Module 7 Lab — Solution Walkthrough
## You Are Being Watched

---

### Overview

Someone investigated you across three platforms — LinkedOut, GitHub, and your personal
website. No single platform reveals who they are. The answer comes from correlating
evidence across all three and finding the one person who appears in all of them.

The final confirmation is the analytics page on your personal site, where a visit from
the Netherlands — matching the location of one specific person on your LinkedOut viewer
list — confirms their identity.

---

### Step 1 — LinkedOut: Who viewed your profile

Navigate to your LinkedOut profile at `http://localhost:8080`.

You can see that 5 people have viewed your profile in the last 7 days. Click **View all →**
in the sidebar to open the full viewer list.

The five viewers are:

| Name | Title | Location |
|------|-------|----------|
| Emma Clarke | Technical Recruiter at TalentBridge | London |
| James Okafor | Security Engineer at Cloudrise | London |
| Alex Hartmann | Security Researcher | Amsterdam |
| Nina Scholz | SOC Analyst at DataShield | Berlin |
| LinkedIn Member | Anonymous | — |

Three of these have obvious reasons to view a malware analyst's profile — a recruiter,
a security engineer, and a SOC analyst. One stands out: **Alex Hartmann**, listed only
as a Security Researcher from Amsterdam with no company name. Vague, minimal.

Click his name to view his LinkedOut profile. You find:

- **Name:** Alex Hartmann
- **Title:** IT Contractor
- **Location:** Amsterdam, Netherlands
- **About:** One line — IT contractor available for infrastructure and systems work
- **Experience:** Self-employed since 2019, no detail

The profile is deliberately sparse. Nothing here confirms he is the person investigating
you — he could simply have stumbled across your profile. Keep investigating.

**Collected so far:** full name, job title, location.

---

### Step 2 — GitHub: Who is watching your repository

Navigate to your GitHub notifications at `http://localhost:8080/github/notifications`.

You have one unread notification: **alex-h** started watching your
**pulseloader-analysis** repository.

This is the same repository you linked in your LinkedOut post about the PulseLoader
writeup. Someone found the post, followed the link, and chose to watch the repo —
meaning they want to be notified of any future updates.

Click **alex-h** to view their GitHub profile. You find:

- **Username:** alex-h
- **Display name:** Alex Hartmann — the same person from LinkedOut
- **Bio:** IT contractor. Amsterdam.
- **Location:** Amsterdam, Netherlands
- **Email:** a.hartmann@proton.me
- **Public repositories:** 0
- **Contributions:** 8 in the last year — almost nothing

A ProtonMail address and zero public repos on a GitHub account that is actively watching
a malware analysis repository. The account exists purely to monitor — not to contribute.

Navigate to your repo's **watchers list** by clicking the watching count in the sidebar.
The watchers are:

- sara-reeves — yourself
- sec-bot-42 — an automated aggregator
- nina-scholz — Nina Scholz, SOC analyst at DataShield
- alex-h — Alex Hartmann

Nina also appears here. At this point you have two people who have both viewed your
LinkedOut profile and watched your GitHub repo — Alex and Nina. You cannot yet rule
Nina out from the GitHub evidence alone.

**Collected so far:** GitHub username, email address. Two suspects remain.

---

### Step 3 — Personal website: The OPSEC mistake

Navigate to your personal site at `http://localhost:8080/sara-reeves.io`.

Your site lists your blog posts, including the PulseLoader writeup that started all of
this. In the topbar, click **Analytics** to open the private dashboard at
`http://localhost:8080/sara-reeves.io/analytics`.

The visit log shows four entries:

| Timestamp | Page | Referrer | Country |
|-----------|------|----------|---------|
| 2025-01-13 10:22:41 | / | direct | GB |
| 2025-01-14 09:44:17 | / | `https://www.linkedout.com/in/sara-reeves-cipherwatch` | NL |
| 2025-01-14 14:30:05 | / | direct | GB |
| 2025-01-15 09:11:28 | / | direct | FR |

One visit is immediately suspicious. On 14 January at 09:44, someone arrived at your
site directly from your LinkedOut profile — and they were **logged into LinkedOut when
they did it**. A logged-in LinkedOut session passes a referrer header containing your
profile URL when the user clicks an external link. An anonymous or logged-out visitor
would show no referrer at all.

The visitor came from **the Netherlands** — country code `NL`.

Now cross-reference:

- **Alex Hartmann** — Amsterdam, Netherlands ✓
- **Nina Scholz** — Berlin, Germany ✗

Nina is in Germany. The NL visit rules her out. Only Alex is based in the Netherlands.

This is the confirmation. Alex Hartmann visited your personal site while logged into
LinkedOut, clicked the link from your profile, and his country code matches his listed
location. He is the person who has been investigating you across all three platforms.

---

### Flag Answers

| Flag | Question | Answer |
|------|----------|--------|
| F1 | Full name of the investigator | `alex hartmann` |
| F2 | Their GitHub username | `alex-h` |
| F3 | Their LinkedOut job title | `it contractor` |
| F4 | City they are based in | `amsterdam` |
| F5 | Email address on their GitHub profile | `a.hartmann@proton.me` |
| F6 | Referrer URL logged on your personal website | `https://www.linkedout.com/in/sara-reeves-cipherwatch` |
| F7 | Country code from the analytics log | `NL` |

---

### What Alex's OPSEC mistakes were

| Mistake | Where it was logged | What it revealed |
|---------|---------------------|------------------|
| Viewed LinkedOut profile while logged in | LinkedOut — who viewed your profile | His real name, title, and location |
| Watched a public GitHub repository | GitHub — watchers list | His username, email, and activity |
| Clicked your personal site link from LinkedOut while logged in | sara-reeves.io analytics | His country (NL), confirming Amsterdam location |

Each mistake alone would not have been enough. The recruiter viewed your LinkedOut.
Nina watched your GitHub. A French visitor hit your site directly. But only one person
left a trace on all three — and the NL country code on the analytics page is what
locks it in.