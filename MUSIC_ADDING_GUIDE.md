# Music Adding Guide (DBM-EpicMusicPack)

This guide explains how to easily add music tracks and automatically generate their list for DBM.

## Important files

- `Music/custom/` — Put your `.mp3` files here (the script scans only this folder and creates it if missing).
- `GenerateMusicAutoList.bat` — Windows script that scans `Music/` and generates `MusicAutoList.lua`.
- `MusicAutoList.lua` — Auto-generated Lua file (do not edit manually).
- `music_overrides.csv` (optional) — Force the label for specific tracks.
- `artist_map.csv` (optional) — Map artist codes to full names.

## Quick steps

1. Place your `.mp3` files in `DBM-EpicMusicPack/Music/custom/`.
2. Double-click `GenerateMusicAutoList.bat`.
3. At the prompt, answer the question:
   - `Y` = Enable auto-guess (derive `Artist - Title` from the filename)
   - `N` = Disable auto-guess (basic label from the filename)
4. The script creates/overwrites `MusicAutoList.lua`.
5. Launch the game (or `/reload`) and find your tracks in DBM’s music menus (prefix `EMP -`).

## Recommended file naming format

```
EMP_<ArtistCodeOrName>_<Title_With_Underscores>.mp3
```

Examples:
- `EMP_RSM_ThunderFist.mp3` → Auto-guess: `Really Slow Motion - Thunder Fist` (if `artist_map.csv` contains `RSM,Really Slow Motion`).
- `EMP_MyName_SuperTheme.mp3` → Auto-guess: `MyName - Super Theme`.

## Auto-guess (Y/N)

- `Y`: The script tries to split artist and title at the first underscore `_`.
  - Replaces `_` with spaces in the title.
  - Maps the artist code via `artist_map.csv` if present (e.g., `RSM,Really Slow Motion`).
- `N`: The label is derived from the filename (without extension), with `_` → space.

## Precise overrides (`music_overrides.csv`)

- Format: `KEY,Artist - Title`
- `KEY` = filename without extension (e.g., `EMP_ES_JuggernautMarch`).
- If present, the override has the highest priority.

Example `music_overrides.csv`:
```
EMP_ES_JuggernautMarch,FormantX - Juggernaut March
EMP_Oblivion,Baptiste Thiry - Oblivion
```

## Artist mapping (`artist_map.csv`)

- Format: `CODE,Artist Full Name`
- Replaces the abbreviation detected at the beginning of the name (after `EMP_`).

Example `artist_map.csv`:
```
RSM,Really Slow Motion
HSM,Hypersonic Music
ES,Epic Score
```

<!-- The generator now scans only Music/custom, so no need to exclude official tracks. -->

## Sorting and display in DBM

- Official pack tracks are sorted by name.
- Auto-generated tracks are added afterwards, sorted among themselves by label.

## Troubleshooting

- No tracks detected: verify your files are `.mp3` inside `Music/`.
- Special characters: avoid quotes in labels; the script replaces `"` with `'` for Lua.
- Need an exact label: use `music_overrides.csv`.

## Notes

- `MusicAutoList.lua` is regenerated each time you run the script.
- You do not need to edit `MusicLoadList.lua`.
- The `.toc` files automatically load `MusicAutoList.lua` and apply the additions via `MusicAutoMerge.lua`.

## Interactive prompts (overview)

- **[Auto guess Artist and Song name?]**
  - Y: tries to produce `Artist - Title` from the filename (`EMP_<ArtistCode>_<Title>`), with `artist_map.csv` applied.
  - N: basic label from filename (underscores become spaces), unless manual mode is enabled.
- **[Manually declare each song?]** (shown if Auto guess = N)
  - Y: prompts for `Artist` and `Title` for each file.
  - Defaults are derived from the filename and `artist_map.csv` when possible.
- **[Overwrite existing overrides?]** (shown if manual mode is enabled)
  - Y: even if a key exists in `music_overrides.csv`, you can edit it; the current value pre-fills the prompts.
  - N: existing overrides are kept as-is, no prompt for those keys.
- **[Restore from an existing backup?]** (before generation)
  - Can select from a list in `Documents/DBM-EpicMusicPack_Backups/` or provide a custom folder/ZIP path.
- **[Create a backup of the current state now?]** (after generation)
  - Choose destination folder (default in Documents) and optional ZIP compression.
  - Optional pruning: keep only the latest backup.

## Manual per-song entry

- Enable by answering No to Auto guess, then Yes to manual mode.
- For each track, the script asks:
  - `Artist for 'KEY'` with a default suggestion.
  - `Title for 'KEY'` with a default suggestion.
- The final label becomes:
  - `Artist - Title` if both provided.
  - `Artist` only, or `Title` only, otherwise.

## Overwrite existing overrides

- If `music_overrides.csv` already contains a label for a key, enabling overwrite will let you edit it.
- The current value is split as `Artist - Title` to pre-fill the prompts.

## CSV persistence (`music_overrides.csv`)

- Any manual entries or edits are merged into `music_overrides.csv` and saved (UTF-8, no BOM, keys sorted).
- On the next run, these overrides are applied automatically with highest priority.

## Backups and restore

- Backups contain:
  - `Music/custom/` content
  - `music_overrides.csv`
  - `artist_map.csv`
  - `MusicAutoList.lua`
- Restore (pre-generation):
  - Choose from a list or specify a path to a folder or `.zip`. The script restores files into the addon.
- Backup (post-generation):
  - Pick destination (default `Documents/DBM-EpicMusicPack_Backups/`) and choose ZIP or plain folder.
  - Optionally keep only the latest backup (automatic pruning).

## Recommended workflow

1. Put `.mp3` files into `Music/custom/`.
2. Run `GenerateMusicAutoList.bat`.
3. Optionally restore a previous backup (if you need to recover labels or files).
4. Choose Auto guess or Manual per song; use Overwrite to edit existing labels.
5. Let the script generate `MusicAutoList.lua` and persist overrides.
6. Create a backup of the final state; optionally prune to keep only the latest.
7. Launch the game or `/reload`.
