# Projects — Detail

## YoutubeTrends
- Path: `/Users/oussamabenbila/OZ/YoutubeTrends/`
- Reports: `Reports/report_YYYY-MM-DD.md` (raw per-source data)
- Synthesis: `Synthesis/synthesis_YYYY-MM-DD.md` (trend map, opportunities, ideas log)
- GrowthBlueprints: `GrowthBlueprints/blueprint_YYYY-MM-DD_[niche].md`
- Session 1 (2026-02-23): `report_2026-02-23.md` + `synthesis_2026-02-23.md` exist
- Session 2 (2026-02-23): `youtube-growth` skill created; `blueprint_2026-02-23_product-designer.md` produced
- Permissions: `support.google.com` + `creatoracademy.youtube.com` added in settings.local.json
- Key constraint: `youtube.com` and `trends.google.com` block direct crawling — use WebSearch fallback restricted to `blog.youtube` or official whitepapers

## AmazonKDP
- Path: `/Users/oussamabenbila/OZ/AmazonKDP/`
- Publisher Stage: 0 (0 reviews) — survive, no spend increases, let algorithm learn
- Last session: 2026-03-07 — ad strategy correction: Aggressive Learning diagnosed as overspend at Stage 0
- Next checkpoint: March 15 — pull Search Term + Targeting reports, evaluate ACOS under Down Only config
- Book 0: $9.99, 60% royalty, $3.15/sale, break-even ACOS 31.5% | ASIN: B0GKP671W5
- Book 1: $12.99, 60% royalty, $2.69/sale, break-even ACOS 20.7% | ASIN: B0GDYH7Y2D
- Active campaigns: `US | Auto | Discovery` (Book 1, $10/day, Down Only) + `US | Manual | Exact | Core Intent` (Book 1, $10/day, Down Only)
- Book 0 Auto campaign: paused — resume at 1 review
- Review request page: designed (pending KDP interior upload for Book 1)
- Campaign fixes applied 2026-02-28: negatives added (spaghetti), Manual Top-of-Search +20%, complements/substitutes bid → $0.10, bid corrections on 2 keywords
- Niche research output: `NicheResearch/niche_YYYY-MM-DD.md`
- Workbook blueprint output: `NicheResearch/blueprint_YYYY-MM-DD_[niche-slug].md`
- Permissions: `WebFetch(amazon.com)` + `WebSearch` in settings.local.json
- Workflow: `/niche-finder` → `/workbook-builder` → `/kdp-advisor`

## MobileApps
- Path: `/Users/oussamabenbila/OZ/MobileApps/`
- Reports: `Reports/report_YYYY-MM-DD.md`
- Synthesis: `Synthesis/synthesis_YYYY-MM-DD.md`
- OpportunityResearch: `OpportunityResearch/opportunity_YYYY-MM-DD_[niche].md`
- Permissions: 7 WebFetch domains + WebSearch in settings.local.json
- No-arg guard: `ios-opportunity-finder` with no args prompts user, does not run
- Phase: Research (no apps live yet)

## DataMoatResearch
- Path: `/Users/oussamabenbila/OZ/DataMoatResearch/`
- Single file: `data-moat-project.md` (thesis, business model, session log, API docs)
- Phase: Pre-validation (no emails sent, no code written yet)
- Core idea: hyperlocal Ontario government permit intelligence → sold to contractors/developers
- Confirmed data source: Mississauga Building Permits via ArcGIS REST API
  - Endpoint: `https://services2.arcgis.com/CyVvlIiUfRBmMQuu/arcgis/rest/services/Building_Permits_Applications_view/FeatureServer/0/query`
  - Key fields: PermitNumber, PermitType, ConstructionType, ApplicationDate, IssueDate, Status, WorkDesc, StreetAddress
  - Gap: no construction dollar value in API — only in monthly PDF reports
- Flagged for future: open.canada.ca (federal open data portal — opportunity scouting)
- Next actions: Python pull script → contractor lead list (HomeStars + OGCA) → Variant 3 email → send 50 emails

## ProductDesigner
- Path: `/Users/oussamabenbila/OZ/ProductDesigner/`
- Merged: CareerPosition content merged into this project
- Phase: Active — Execution

## WFA
- Path: `/Users/oussamabenbila/OZ/WFA/`
- Phase: Active — Monitoring federal WFA process at ECCC

## ConsultationTracker
- Path: `/Users/oussamabenbila/OZ/ConsultationTracker/`
- Phase: Active — Build (Power Apps + SharePoint)

## ECP
- Path: `/Users/oussamabenbila/OZ/ECP/`
- Phase: Active — Build (Dynamics 365)

## CopyrightIssue
- Path: `/Users/oussamabenbila/OZ/CopyrightIssue/`
- Phase: Pending

## EtsyShop
- Path: `/Users/oussamabenbila/OZ/EtsyShop/`
- Phase: Active — Setup (Phase 1: POD research + shop prep)
- **Strategy pivot (2026-03-04):** POD open-edition prints FIRST (traction), Attitudes limited edition SECOND (Phase 2)
- Phase 1 product: Open edition photography prints — mixed genres (wildlife, landscape, street) via POD (Printify / Printful / Gelato — TBD)
- Phase 2 product: Attitudes series (10 rooster portraits, limited edition 7, physical, hand-shipped flat) — ON HOLD
- Research reports: `Reports/report_YYYY-MM-DD_[genre].md` (3 reports exist: wildlife, landscape, street — all 2026-03-04)
- Listings: `Listings/listing_YYYY-MM-DD_[slug].md`
- Photo shot list: `ListingPhotos/photo_shot_list.md`
- Shop name candidates: `ShopSetup/shop_name_candidates.md` — updated with mixed-genre candidates; rooster-centric ones deprioritized
- Policies template: `ShopSetup/shop_policies.md` — updated with POD section (Phase 1) + physical section (Phase 2)
- Permissions: `WebSearch` + `WebFetch:etsy.com`
- Mockup flow (paused): `ListingPhotos/weavy_mockup_flow.md` — deprioritized; revisit for Phase 2 Attitudes mockups
- **Research findings (2026-03-04):**
  - Wildlife: species-specificity is key SEO lever; moderate competition; healthy margin at 16×20+
  - Landscape: most saturated category; geographic + mood specificity required; sets outperform singles
  - Street/travel: NYC-dominated but non-NYC destinations (Morocco, Japan, Europe) = low competition niche
- **Recommended Phase 1 genres:** wildlife (species-specific) + street/travel (non-NYC destinations)
- **Next actions:**
  1. Select POD service (compare Printify/Printful/Gelato for paper fine art prints + margin)
  2. Confirm shop name from mixed-genre candidates
  3. Upload first listings (wildlife species + destination travel photos from portfolio)
