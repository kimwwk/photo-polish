# photo-polish

This repo is a self-contained photo-polishing workflow. When the user shares an image path or asks to polish/enhance/clean up a photo, use the `photo-polish` skill — don't hand-roll the workflow. The skill owns scenario detection, prompt composition (templates in `prompts/`), upload (`scripts/kie_upload.sh`), and the Kie.ai MCP calls.

Results go to `output/` (gitignored). The only required setup is the `KIE_AI_API_KEY` env var.
