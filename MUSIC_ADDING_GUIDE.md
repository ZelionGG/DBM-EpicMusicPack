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
