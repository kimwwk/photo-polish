---
name: photo-polish
description: Turn an ordinary phone photo of FOOD or JEWELRY into a gallery-ready shot via Kie.ai — the user never writes an image prompt. Use whenever the user shares a photo path and wants it polished, enhanced, cleaned up, or made professional/post-ready.
---

# photo-polish

You are the photographer. The user brings a photo; you bring the prompt craft. Never ask the user to write or approve an image prompt — composing it is your job.

Supported scenarios right now: **food** and **jewelry**. That focus is deliberate.

## Inputs

- A local image path (required). If the user gave none, ask for one — that's the only question you should need.
- Optional free-form wishes ("warmer", "white background", "for Instagram"). Fold them into the composed prompt.

## Workflow

1. **Check the key.** Run `test -n "$KIE_AI_API_KEY" && echo set || echo missing`. If missing, stop and tell the user to `export KIE_AI_API_KEY=...` (from https://kie.ai/api-key) and restart Claude Code. Don't continue without it.

2. **Look at the photo.** Read the image file so you actually see it. Classify:
   - `food` — dishes, drinks, baked goods
   - `jewelry` — rings, necklaces, earrings, watches, loose stones
   - anything else → tell the user this repo currently supports food and jewelry photos only, and stop. If they explicitly want to proceed anyway, use the closer of the two templates and say the result is best-effort.
   Note 3–6 concrete observations while you look: the subject, what's wrong with the shot (dim, cluttered background, color cast, harsh flash…), and anything that must not change (stone count, metal tone, portion size, visible wear).

3. **Compose the prompt.** Open `prompts/food.md` or `prompts/jewelry.md`. Fill the template with your observations: what the subject is, which flaws to fix, which background treatment fits. Append the user's wishes. Keep the template's fidelity constraints verbatim — they are non-negotiable.

4. **Upload the photo.** Run `bash scripts/kie_upload.sh <path>`. Parse the JSON for `fileUrl` (or `downloadUrl`). If the upload fails, show the error and stop.

5. **Edit via Kie.** Call the `kie` MCP server's `nano_banana_image` tool in edit mode: pass the uploaded image URL and your composed prompt. Read the tool's schema for exact parameter names before calling — don't guess. Set the aspect-ratio parameter explicitly to match the input — "auto" has been seen drifting a 4:3 input to a 1:1 output. If the task is async, poll with `get_task_status` / `wait_for_task`. If nano banana errors or is unavailable, retry once on the Flux editing tool (`flux_kontext` or `flux_2`), same prompt.

6. **Deliver.** Download the result to `output/<original-stem>-polished.png` (curl the result URL). Show the user the original and the polished version side by side (read both images). One or two sentences on what you changed — no prompt dumps.

7. **One refinement pass, on request.** If the user wants adjustments, revise the composed prompt (start from the *original* uploaded photo again, not the output, unless they explicitly want to iterate on the output) and produce `-polished-v2`. More than two passes: keep going only if the user keeps asking.

## Hard rules

- **Never alter what's being sold.** Same dish and portion; same stones, metal tone, engravings and visible wear. Lighting, background, color, clarity only. If the user asks you to change the subject itself, flag that it stops being a truthful listing photo and confirm before doing it.
- Blur or remove any faces or personal info visible in the background or reflections by default.
- Keep the original aspect ratio unless the user asks otherwise.
- One model call per pass — don't fan out across models racking up API cost without being asked.
- Costs are the user's Kie.ai credits: mention cost only if a call fails for quota/billing reasons.
