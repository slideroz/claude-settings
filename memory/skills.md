# Skills — Inventory & Dependencies

## Skill Convention
- Location: `.claude/skills/<skill-name>/SKILL.md` per project
- Frontmatter fields: `name`, `description`, `allowed-tools`
- Invoked via slash command: `/<skill-name> [args]`

## Skill Inventory

| Project | Skill | Invocation | Depends On |
|---------|-------|-----------|------------|
| YoutubeTrends | youtube-trends | `/youtube-trends [category/region/format/YYYY-MM]` | None |
| YoutubeTrends | youtube-growth | `/youtube-growth [niche] [goal]` | Latest `Synthesis/synthesis_YYYY-MM-DD.md`; fallback to WebSearch if > 7 days old |
| AmazonKDP | kdp-niche-finder | `/kdp-niche-finder [keyword/category/"adjacent"/"new"]` | None |
| AmazonKDP | kdp-workbook-builder | `/kdp-workbook-builder [niche or "latest"]` | Requires `NicheResearch/niche_*.md` — run `/kdp-niche-finder` first |
| AmazonKDP | kdp-advisor | `/kdp-advisor` | None |
| MobileApps | ios-market-pulse | `/ios-market-pulse [category] [region] [YYYY-MM]` | None |
| MobileApps | ios-opportunity-finder | `/ios-opportunity-finder [category/keyword]` | Latest `Synthesis/synthesis_YYYY-MM-DD.md`; staleness threshold 14 days → WebSearch refresh |
| MobileApps | ios-prd-builder | `/ios-prd-builder [app-slug] [opportunity-date?]` | Requires `OpportunityResearch/opportunity_*.md` — run `/ios-opportunity-finder` first |
| Global | naming-lab | `/naming-lab [brief context or product description]` | None |
| ProductDesigner | hiring-manager | `/hiring-manager` | None |
| WFA | wfa-status | `/wfa-status` | CLAUDE.md + WFA documents in folder |
| EtsyShop | etsy-advisor | `/etsy-advisor [action] [argument]` | `EtsyShop/CLAUDE.md` + latest `Reports/report_*.md` |
| EtsyShop | art-curator | `/art-curator [describe/critique/statement]` | `Portraits/portrait_catalog.md` + `CuratorialNotes/curatorial_intent.md` + hero JPGs |

## Cross-Project Dependency Notes
- `youtube-growth` reads `YoutubeTrends/Synthesis/` for Niche Viability Score
- `ios-opportunity-finder` reads `MobileApps/Synthesis/` as market baseline — do not run without a synthesis < 14 days old
- `workbook-builder` reads `AmazonKDP/NicheResearch/niche_*.md` — do not run without a validated niche report from `/niche-finder`

## AmazonKDP Workflow
`/kdp-niche-finder` (discover) → `/kdp-workbook-builder` (create) → `/kdp-advisor` (scale)

## EtsyShop Workflow
`/etsy-advisor research [keyword]` (market data) → `/art-curator describe [slug]` (curatorial prose) → `/art-curator statement` (series statement) → `/etsy-advisor listing [slug]` (per portrait) → `/etsy-advisor photos` (shot list) → `/etsy-advisor` (assessment)

**art-curator** is independent of etsy-advisor: does not write titles, tags, or SEO copy. Output goes to `CuratorialNotes/`. Requires `curatorial_intent.md` to exist before first run.
