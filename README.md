# photo-polish

Turn an ordinary phone photo into a gallery-ready shot — **without writing a single prompt**.

You drop a photo in, the built-in Claude Code skill figures out what it's looking at (food / product / vehicle / anything else), composes a battle-tested editing prompt from the templates in [`prompts/`](prompts/), sends it to an image model on [Kie.ai](https://kie.ai), and hands you back a polished version next to the original.

The only thing you need to bring is a **Kie.ai API key**.

## Quick start

Requirements: [Claude Code](https://claude.com/claude-code), Node.js 18+, `curl`.

```bash
git clone https://github.com/kimwwk/photo-polish.git
cd photo-polish

export KIE_AI_API_KEY=your-key-here   # get one at https://kie.ai/api-key

claude
```

On first launch Claude Code will ask to approve the `kie` MCP server defined in [`.mcp.json`](.mcp.json) — approve it. Then:

```
/photo-polish path/to/your-photo.jpg
```

That's it. The polished image lands in `output/`, and Claude shows you a before/after. Tell it what you'd change ("warmer", "cleaner background", "less dramatic") and it makes one refinement pass — still no prompt writing on your side.

> Tip: to avoid exporting the key every session, add the `export` line to your `~/.bashrc` / `~/.zshrc`.

## How it works

```
your photo ──► skill looks at it & picks a scenario ──► prompt template (prompts/*.md)
                                                              │
output/…-polished.png ◄── downloads result ◄── Kie.ai model ◄─┘
                                                (nano_banana_image,
                                                 flux fallback)
```

1. **Look** — Claude reads the image itself and classifies it: `food`, `product`, `vehicle`, or `general`.
2. **Compose** — the matching template in `prompts/` is filled with what Claude actually sees. The templates encode the photography know-how (lighting, background, fidelity constraints) so you don't have to.
3. **Upload** — `scripts/kie_upload.sh` pushes the local file to Kie.ai's temporary file storage (auto-deleted after ~3 days) and returns a URL.
4. **Edit** — the skill calls the Kie.ai MCP server (`nano_banana_image` first, Flux as fallback) with the image URL + composed prompt.
5. **Deliver** — result is downloaded to `output/`, shown next to the original.

**Fidelity rule baked into every template:** the subject is never altered — same dish, same product condition, same car. Only lighting, background, color and clarity change. What you're selling stays what it is.

## Repo layout

| Path | What it is |
|---|---|
| `.claude/skills/photo-polish/SKILL.md` | The skill — the whole workflow Claude follows |
| `.mcp.json` | Wires up the [`@felores/kie-ai-mcp-server`](https://github.com/felores/kie-cli-mcp) (runs via `npx`, nothing to install) |
| `prompts/*.md` | Scenario prompt templates — edit these to change the house style |
| `scripts/kie_upload.sh` | Local file → temporary Kie.ai URL |
| `output/` | Polished results (gitignored) |

## Customizing

- **Change the look**: edit the template in `prompts/` for your scenario. Each file is plain markdown — a base prompt plus slot notes.
- **Add a scenario**: copy `prompts/general.md` to `prompts/<name>.md`, describe when it applies in the header line, and the skill will pick it up.
- **Different models**: the MCP server exposes more Kie.ai models than the ones enabled in `.mcp.json` (`KIE_AI_ENABLED_TOOLS`). Remove that env line to see everything.

## Troubleshooting

- **"KIE_AI_API_KEY not set"** — export it in the same shell where you run `claude`, then restart `claude`.
- **kie tools not showing** — check the MCP server was approved: run `/mcp` inside Claude Code.
- **Upload URL expired** — Kie.ai temp files live ~3 days; just run the skill again, it re-uploads.
- **Cost** — each edit is a metered Kie.ai API call (typically a few cents per image). Nano Banana is the cheap default; the skill won't fan out to multiple models without asking.

## License

[MIT](LICENSE)
