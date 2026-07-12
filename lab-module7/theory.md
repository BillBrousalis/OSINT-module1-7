# Module 7 — Digital Footprints & Cross-Platform Correlation

## The Problem of the Digital Trail

Every action taken online leaves a trace somewhere. Viewing a profile, watching a repository, clicking a link, loading a webpage — each of these generates a record. Individually, most of these records are unremarkable. But when a person performs multiple actions across multiple platforms within a related timeframe, those traces can be correlated to reveal far more than any single platform would show on its own.

This is the core challenge of digital footprint analysis: identifying and connecting signals that are scattered across different systems, none of which was designed to be read together with the others.

---

## What Is a Digital Footprint?

A digital footprint is the collection of data that a person leaves behind as a result of their activity online. There are two broad categories:

**Active footprint** — information the person deliberately chose to publish: profile details, posts, repository descriptions, public contributions, listed contact information.

**Passive footprint** — information generated as a side effect of activity, often without the person realizing it: page view logs, referrer headers, watch notifications, connection requests, timestamps on interactions.

OSINT investigations frequently combine both. The active footprint tells you who someone wants to appear to be; the passive footprint reveals what they actually did.

---

## Cross-Platform Correlation

Most people maintain a presence across multiple platforms — professional networks, code hosting services, personal websites, forums, social media. They often use consistent details across them: the same name, the same profile photo, the same username, the same location, the same email address.

Cross-platform correlation is the process of linking accounts or activity across these platforms to build a more complete picture of a person. A name found on one platform becomes a search term on another. A username on one service narrows the search on the next. A location narrows it further. Each new piece of data either confirms or contradicts what was found before.

The key discipline is triangulation — not concluding anything from a single match, but looking for the same identifying detail to appear independently across multiple sources.

---

## Referrer Headers

When a user clicks a link on one website to navigate to another, most browsers automatically include an `HTTP Referer` header in the request sent to the destination. This header contains the URL of the page where the user clicked the link.

Website analytics systems routinely log this referrer value alongside the timestamp, the visited page, and sometimes approximate location information (derived from the visitor's IP address, usually at the country level).

This creates a situation where a person's navigation path is partially visible to site owners — not because they did anything wrong, but because this is how the web works by default. If a visitor arrives at a personal website via a link on their LinkedIn profile while logged in, the analytics log will show exactly which LinkedIn URL they came from.

The referrer is particularly significant in investigations because it is a **passive record** — the visitor almost certainly did not know it was being logged, and did not take any action to generate it deliberately.

---

## Platform Visibility Features

Many platforms include features that notify users when someone has taken an interest in their content:

- **Profile view notifications** (professional networks) — tells you who viewed your public profile
- **Repository watchers** (code hosting) — shows who has opted to follow updates to a specific project
- **Page analytics** (personal sites, blogs) — shows visit timestamps, referrers, and approximate visitor locations

These features exist to serve the platform's users. As a side effect, they also expose information about observers to the people being observed. Someone conducting research without awareness of these visibility systems may not realize they are leaving a record behind on each platform they visit.

---

## OPSEC (Operational Security) for Online Investigators

Operational security (OPSEC) refers to the practice of controlling what information you expose about yourself while conducting an investigation or sensitive activity. Poor OPSEC while conducting online research is common, and the mistakes it produces are predictable:

**Viewing profiles while logged in** — most professional networks log and display profile views to the person being viewed. Viewing while logged in creates a record tied to your real identity.

**Interacting with public content** — following, watching, starring, or liking content on platforms notifies the content owner and creates a visible record.

**Clicking external links from a logged-in session** — following a link from a platform while logged in passes that platform's URL as a referrer to the destination site. This ties your external visit back to your account on the originating platform.

**Consistent usernames and details** — using the same username, photo, or biographical details across platforms makes it straightforward to link accounts together.

Understanding these failure modes serves two purposes: it explains how investigators get identified, and it informs how to conduct research more carefully.

---

## Building a Picture from Incomplete Evidence

Real investigations rarely produce clean, direct confirmation. More often you work with overlapping partial signals:

- Multiple suspects may share some characteristics
- A single platform may not be enough to distinguish between them
- The confirming detail may come from an unexpected source

The method is to collect what each platform offers, identify what is unique or distinctive about each piece of data, and look for the intersection. When you have two candidates who both appear on platform A and platform B, the tiebreaker usually comes from a third source — one that narrows the field in a way the first two could not.

Correlation is strongest when the confirming evidence is **independent** — when two pieces of data were generated by separate systems and neither could have been manipulated by the same action that generated the other.

---

## Privacy and Ethical Considerations

The techniques in this module rely entirely on information that is publicly visible or passively logged on systems the investigator legitimately accesses. No account compromise, data interception, or unauthorized access is involved.

This distinction matters. OSINT — open-source intelligence — is defined by the use of publicly available information. The same techniques used in legitimate security research, journalism, and law enforcement investigations can also be misused. Understanding how digital traces are generated and correlated is essential both for conducting ethical investigations and for protecting yourself and others from unwanted surveillance.
