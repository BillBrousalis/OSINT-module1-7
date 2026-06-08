# Module 7 Lab — You Are Being Watched
## Questions & Answer Key

---

### Briefing

> Last week you published a detailed writeup on your personal site about a malware sample
> you had been analysing. The post documented the C2 infrastructure of an active loader
> campaign — domain, IP, beacon pattern, YARA rule. Within 48 hours the infrastructure
> was on every major blocklist. Whoever was running it lost months of access overnight.
>
> Since then, someone has been quietly investigating you across multiple platforms.
> They visited your **LinkedOut profile**, your **GitHub repository**, and
> your **personal website** — all within a short window of time.
>
> They were not careful. They left traces on each platform.
>
> You are **Sara Reeves**, malware analyst at CipherWatch Security. Your job is to
> correlate the evidence across all three platforms, identify who has been investigating
> you, and find out everything they exposed about themselves in the process.
>
> Start at your LinkedOut profile. Follow the trail.

---

### Access

| | |
|---|---|
| **URL** | `http://localhost:8080` |

---

### Questions

---

**F1 — Identity**

> What is the full name of the person who appears across all three platforms?

- **Expected answer:** `alex hartmann`
- **Format:** All lowercase, space separated first and last name.
- **Hint:** Check who viewed your LinkedOut profile, who is watching your GitHub repository, and who visited your personal website. One person appears in all three.

---

**F2 — GitHub username**

> What is their GitHub username?

- **Expected answer:** `alex-h`
- **Format:** Exact string, lowercase
- **Hint:** Check the watchers list on your GitHub repository.

---

**F3 — LinkedOut job title**

> What job title do they list on LinkedOut?

- **Expected answer:** `it contractor`
- **Format:** All lowercase, space separated words
- **Hint:** Click through to their LinkedOut profile from the who viewed your profile page.

---

**F4 — Location**

> What city are they based in?

- **Expected answer:** `amsterdam`
- **Format:** All lowercase
- **Hint:** Their location is visible on both their LinkedOut profile and their GitHub profile.

---

**F5 — Email address**

> What email address did they expose on their GitHub profile?

- **Expected answer:** `a.hartmann@proton.me`
- **Format:** Exact string, lowercase
- **Hint:** Visit their GitHub profile page. The email address is listed in the sidebar.

---

**F6 — The OPSEC mistake**

> What referrer URL was logged when they visited your personal website?

- **Expected answer:** `https://www.linkedout.com/in/sara-reeves-cipherwatch`
- **Format:** Exact string
- **Hint:** Visit your personal website and check the analytics page.

---

**F7 — Location corroboration**

> What country code does the analytics log show for that visit?

- **Expected answer:** `NL`
- **Format:** Two letters, uppercase
- **Hint:** The country code is in the same row as the suspicious referrer in the analytics table.

---

### Grading Notes

| Flag | Answer | Auto-gradeable |
|------|--------|----------------|
| F1 | `alex hartmann` | Yes |
| F2 | `alex-h` | Yes |
| F3 | `it contractor` | Yes |
| F4 | `amsterdam` | Yes |
| F5 | `a.hartmann@proton.me` | Yes |
| F6 | `https://www.linkedout.com/in/sara-reeves-cipherwatch` | Yes |
| F7 | `NL` | Yes |

F1 is the anchor flag — the student cannot answer it without completing the correlation
across all three platforms. F5, F6, and F7 reward students who go beyond the obvious
LinkedOut trail and investigate the GitHub and personal website evidence thoroughly.