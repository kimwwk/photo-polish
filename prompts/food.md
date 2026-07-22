# food — dishes, drinks, baked goods

Use when the subject is something to eat or drink, shot for a menu, delivery app, or social post.

## Template

> Transform this exact photo into a mouth-watering commercial hero shot of the same meal. The dish is {SUBJECT — e.g. "a bowl of beef noodle soup with bok choy"}. Absolute rules: same components, same portion size, nothing added or removed{CONTAINER — if served in takeout packaging: ", keep the takeout container exactly as it is"}, and keep the exact original camera angle and framing — a top-down shot stays strictly top-down. Within those rules, push the presentation to food-commercial level: {BEAUTIFY — e.g. "the fried crust deeply caramelized golden-brown and glistening fresh-from-the-fryer with visible crispy texture, every rice grain glossy, separated and defined, the gravy rich and glistening, the greens ice-crisp and vivid"}; appetizing steam rising clearly if the dish is served hot. Cinematic food-commercial lighting: strong warm directional key light raking from the upper left to sculpt the food's texture, deep soft shadows. {BACKGROUND — pick one: "dark moody rustic wooden table, softly blurred around the dish" / "bright clean airy surface, delivery-app style"}. Correct the white balance so the food's colors look natural and appetizing, correct any lens or perspective distortion, fix {FLAWS — e.g. "the yellow indoor color cast and the harsh phone flash reflection"}, rich warm color grade with bold micro-contrast and tack-sharp detail on the food. Photorealistic, high-end food commercial quality. No cartoon or illustration look, no added text, no watermark, no garnish or ingredient that isn't in the original.

## Notes

- If the shot is top-down, keep it top-down — don't let the model reinvent the angle.
- Delivery-app style = brighter, whiter background; dine-in social style = warmer, moodier. Ask nothing; infer from the user's wording, default to warm.
- If the user asks for something subtler ("natural", "not too dramatic"), swap the cinematic lighting sentence for "soft directional key light from the upper left, gentle fill light, natural appetizing highlights" and drop the color-grade clause.
- **Truthful mode** (only when the user says the photo must show the food as-is): replace the {BEAUTIFY} clause with "do not add, remove, reshape or improve any food item" and drop the steam allowance.
- Calibration receipt: the gentle "studio retouch" phrasing and this hero phrasing were tested on the same input — the gentle version's delta over a plain relight was invisible; the hero version is the one that visibly upgrades the product. Hence hero is the default.
