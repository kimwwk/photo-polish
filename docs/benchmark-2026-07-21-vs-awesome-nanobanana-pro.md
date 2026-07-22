> Benchmark record — run 2026-07-21 with @felores/kie-cli against Kie.ai nano-banana-2 (1K, edit mode). Image artifacts were kept outside the repo; sources/licenses below. The template grafts recommended here were applied to prompts/ in the same commit.

# Photo-Polish vs awesome-nanobanana-pro — A/B Prompt Test

Date: 2026-07-21
Model (identical across all 4 runs): Kie.ai `nano_banana_image` = Google Nano Banana 2 (Gemini 3.1 Flash Image), edit mode, resolution 1K, aspect_ratio auto, output png, via `@felores/kie-cli`.

## Input photos (sources + licenses)

| File | Source | Author | License |
|---|---|---|---|
| `food-input.jpg` | [Wikimedia Commons: Liat Portal for Foodie Disorder - Homemade Israeli dinner plate.jpg](https://commons.wikimedia.org/wiki/File:Liat_Portal_for_Foodie_Disorder_-_Homemade_Israeli_dinner_plate.jpg) (1280px thumb) | User:HaJunkiyada | [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0) |
| `jewelry-input.jpg` | [Wikimedia Commons: Rings on paper.jpg](https://commons.wikimedia.org/wiki/File:Rings_on_paper.jpg) (1280px thumb) | User:Oganguly | [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0) |

Input character (why they qualify as amateur):

- **Food**: top-down phone shot of a homemade platter (cottage cheese, quartered hard-boiled eggs, sliced tomatoes, yellow bell pepper strips, chopped cucumber) on a white floral-embossed plate, dark wooden table with harsh overhead ceiling-light reflections and visible scratches, flat lighting, dull warm cast.
- **Jewelry**: four yellow-gold rings (oval carnelian cabochon, engraved square signet, plain band, round pink-red stone) piled on a printed geology worksheet, strong yellow indoor cast, shallow focus, cluttered text background.

## Competitor prompt selection (ZeroLu/awesome-nanobanana-pro)

Repo cloned at commit HEAD of 2026-07-21 into `awesome-nanobanana-pro/`.

**Coverage gap (important):** the library contains **no food-photo enhancement/editing prompt at all** and **no jewelry-specific prompt**. Its "Photo Editing & Restoration" section (§6) only covers outpainting, crowd removal, and a CCTV effect. The only true image-EDITING prompt aimed at making an uploaded product photo look professional is **§4.2 "Professional Product Photography"** (README.md lines 1446–1455). §1.17 "Luxury Product Photography" was considered for jewelry but rejected — it is a text-to-image template built around a bottle floating on dark water, not an edit of an input photo. Therefore §4.2 was used verbatim for BOTH scenarios; that in itself is a finding about the library's coverage.

### Prompt B (used for food-awesome AND jewelry-awesome) — §4.2, verbatim

> Identify the main product in the uploaded photo (automatically removing any hands holding it or messy background details). Recreate it as a premium e-commerce product shot . Subject Isolation : Cleanly extract the product, completely removing any fingers, hands, or clutter . Background : Place the product on a pure white studio background (RGB 255, 255, 255) with a subtle, natural contact shadow at the base to ground it. Lighting : Use soft, commercial studio lighting to highlight the product's texture and material. Ensure even illumination with no harsh glare. Retouching : Automatically fix any lens distortion, improve sharpness, and color-correct to make the product look brand new and professional .

Source path: `awesome-nanobanana-pro/README.md` §4.2 (lines 1446–1455); repo credits the prompt to a WeChat article.

## Prompt A (photo-polish templates, slots filled)

### food-ours (from `/home/kimmm/photo-polish/prompts/food.md`)

> Professional food photography retouch of this exact photo. The dish is a top-down shot of a fresh vegetable and egg platter with a scoop of cottage cheese, quartered hard-boiled eggs, sliced red tomatoes, yellow bell pepper strips and chopped cucumbers arranged on a white plate with an embossed floral pattern. Keep the exact same dish, plating, portion size and ingredients — do not add, remove, reshape or "improve" any food item. Re-light as a professional studio food shot: soft directional key light from the upper left, gentle fill light, appetizing natural highlights that bring out the texture of the glistening tomato slices, the crisp pepper strips and the curds of the cottage cheese. Place the dish on a clean rustic wooden table with a neutral softly blurred background. Correct the white balance so the food's colors look natural and appetizing, fix the harsh overhead ceiling-light reflections and scratches on the dark tabletop, the dull yellowish indoor color cast and the flat overhead phone lighting, add subtle micro-contrast and sharpness on the food only. Photorealistic, magazine-quality, gallery-grade food photography. No cartoon or illustration look, no added text, no watermark, no fake steam or garnish that isn't in the original.

Slot choices: subject described from the actual photo; "top-down" folded into {SUBJECT} per the template's keep-the-angle note; {BACKGROUND} = rustic wooden table option (warm default, and the original is already on wood); {FLAWS} = ceiling-light reflections, scratched tabletop, yellow cast, flat phone lighting.

### jewelry-ours (from `/home/kimmm/photo-polish/prompts/jewelry.md`)

> Professional jewelry product photography retouch of this exact photo. The piece is a group of four yellow-gold rings: one ring with a large oval reddish-brown carnelian cabochon, one square-topped signet ring with engraved geometric patterns, one plain polished yellow-gold band, and one ring with a round bezel-set deep pink-red stone. Keep the piece completely unchanged — same metal color and finish, same stones (same count, cut, color and clarity as visible), same engravings and hallmarks, including any visible wear or patina (this is a truthful listing photo). Isolate it from the surroundings and place it on a seamless white studio background. Light it like a professional jewelry lightbox: fully diffused illumination with controlled specular highlights, crisp clean sparkle on the facets without blown-out hotspots, and no photographer, phone or window reflected in the metal or stones. Fix the warm yellow indoor color cast, the distracting printed-paper background and the shallow focus that leaves parts of the rings soft. Macro-level sharpness across the whole piece, true-to-life metal tone — do not shift gold, rose gold or silver toward each other. Photorealistic, luxury catalog quality. No added text, no watermark, no artificial sparkle effects or lens flares that misrepresent the stones.

Slot choices: metal stated explicitly (yellow gold) per template notes; {BACKGROUND} = seamless white (selling/listing default); {FLAWS} = yellow cast, printed-paper clutter, shallow focus.

## Runs

4 edit calls total, zero retries. All via `kie-cli nano_banana_image` (model reported back by the API: `nano-banana-2`), image_input = uploaded copy of the respective input, resolution 1K, aspect_ratio auto, png.

| Run | Task ID | Output | Size |
|---|---|---|---|
| food × ours | 5029af2c39acf1a07a462cd54a0df40c | `food-ours.png` | 896×1200 |
| food × awesome | 8ade867acb82480365e404ddb7b23d15 | `food-awesome.png` | 896×1200 |
| jewelry × ours | 1092f57c3cb86a827556e9adc288ebcd | `jewelry-ours.png` | 1024×1024 |
| jewelry × awesome | 3d5306ed8d685f963c76a3726b01e07e | `jewelry-awesome.png` | 1195×896 |

Note: despite `aspect_ratio auto`, jewelry-ours came back 1:1 (input is 4:3); the other three kept the input's aspect. Model quirk, not prompt-driven.

## Scores (judged by viewing all inputs and outputs at full size, plus detail crops of the input rings)

Scale 1–10. "Subject fidelity" = did the dish / stones / metal stay unchanged (unchanged = good).

| Output | Subject fidelity | Lighting | Background | Realism / artifacts | Overall "passes as professional" |
|---|---|---|---|---|---|
| food-ours | 9 | 9 | 9 | 8 | **9** |
| food-awesome | 8 | 7 | 5 | 7 | **6** |
| jewelry-ours | 9 | 9 | 9 | 9 | **9** |
| jewelry-awesome | 7 | 8 | 9 | 8 | **8** |

### Observations behind the scores

**food-ours** — Every component preserved (4 egg quarters, two tomato fans, cottage-cheese scoop, pepper pile, cucumber pile, floral plate pattern). Warm rustic-wood table with a softly blurred kitchen behind, soft upper-left key light, corrected white balance; genuinely looks like an editorial food shot. Deductions: the camera drifted from strict top-down to a slight high-angle tilt (the blurred-background slot invites this), and pepper/cucumber pieces are re-rendered rather than pixel-identical.

**food-awesome** — Components also preserved, colors punchy. But §4.2 treats the dish as a product: pure-white void + contact shadow reads as a floating catalog cutout, not gallery-ready food photography. Even lighting is sterile for food (no appetizing directional highlights). Usable as a delivery-app asset; fails the "gallery-ready" bar. Its "make the product look brand new" instruction is meaningless-to-hazardous for food.

**jewelry-ours** — All four rings with correct identities and arrangement; carnelian cabochon keeps its deep brown-red; the pink stone keeps its true crackled, semi-opaque surface; the cut/gap in the pink ring's adjustable band is preserved; hallmarks legible and close to the input ("KOM", "10,92"); wear and scratches retained per the "truthful listing" clause. Diffuse lightbox lighting, no hotspots, seamless white. Very close to a real luxury-catalog shot.

**jewelry-awesome** — Glossy, well-lit, clean white background — superficially impressive. But it "improved" the product: the crackled opaque pink stone became a clean transparent faceted gem, the metal was polished toward brand-new (scratches largely erased, per its literal "look brand new" instruction), the band's cut/gap is gone, and the "KOM" hallmark rendered mirrored. For a truthful listing these are misrepresentations, and hallmark mangling is an instant tell.

## Verdicts

- **Food: photo-polish wins (9 vs 6).** The library has no food prompt; its generic product-isolation prompt produces a sterile cutout. Our template's food-specific constraints (keep plating/portions, appetizing directional light, warm table option, no fake steam/garnish) are exactly what the scenario needs.
- **Jewelry: photo-polish wins (9 vs 8).** On pure looks it's close — §4.2 produces a competent e-comm shot. Ours wins on what matters for jewelry: stone truthfulness, wear/patina retention, hallmark integrity, no metal-tone drift. §4.2's "brand new" language actively fights truthful listings.
- **Overall: photo-polish (A) wins both scenarios.** Root cause is specificity: our templates bake in per-category "do not change the subject" contracts and name the actual flaws of the input; the library's sole editing prompt is category-agnostic and optimizes for "looks new" over "is the same object".

## Worth grafting from awesome-nanobanana-pro §4.2

1. **"with a subtle, natural contact shadow at the base to ground it"** — our jewelry white-background option doesn't ask for a grounding shadow; both §4.2 outputs got a natural one and it clearly helps the object sit in the frame. Graft into jewelry.md's seamless-white option.
2. **"a pure white studio background (RGB 255, 255, 255)"** — the explicit RGB spec is a marketplace-compliance trick (Amazon-style pure white). Worth adding to the seamless-white option as "(pure RGB 255,255,255)".
3. **"Automatically fix any lens distortion"** — neither of our templates mentions lens/perspective distortion, a common phone-shot flaw. Cheap one-clause graft into both templates' fix list.

Anti-graft (do NOT copy): "color-correct to make the product look brand new" — directly caused the stone clarification / wear erasure failure; opposite of our truthful-listing stance.

## Failures / caveats (honest list)

- The library had **no true food-enhancement prompt and no jewelry-specific prompt**; §4.2 (generic product photography) was the nearest transferable image-editing prompt and was used verbatim for both scenarios. The comparison is therefore "our specialized templates vs their best generic editing prompt" — which is also the realistic user experience of that library.
- Model naming: Kie.ai's CLI exposes a single nano banana tool, reported by the API as `nano-banana-2` (Gemini 3.1 Flash Image); no separate "pro edit" variant was exposed. Same model used for all 4 runs, so the A/B is internally consistent.
- jewelry-ours returned 1:1 instead of the input's 4:3 despite `aspect_ratio auto` (see Runs).
- food-ours drifted slightly off strict top-down; the template note says keep the angle, and "top-down" was folded into {SUBJECT}, but the blurred-background clause still pulled a slight tilt.
- Detail crops used for judging: `crop-input-pinkring.png`, `crop-input-band.png` (from the jewelry input).

