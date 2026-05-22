#!/usr/bin/env bash
set -euo pipefail

track="${1:-51}"
model="${OPENAI_TRANSCRIBE_MODEL:-gpt-4o-mini-transcribe}"
base_url="${OPENAI_BASE_URL:-https://api.openai.com/v1}"
audio_base="https://listeningdata.knsh.com.tw/e/learnbook/cd/KWW4"

if [ -z "${OPENAI_API_KEY:-}" ]; then
  echo "Missing OPENAI_API_KEY." >&2
  echo "Usage: OPENAI_API_KEY=... $0 51" >&2
  exit 2
fi

case "$track" in
  38|39|40|41|42|43|44|45|46|47|48|49|50)
    unit="U3"
    ;;
  51|52|53|54|55|56|57|58|59|60|61|62|63)
    unit="U4"
    ;;
  *)
    echo "Unsupported track: ${track}. Use 38-50 for Unit 3 or 51-63 for Unit 4." >&2
    exit 2
    ;;
esac

file_name="$(printf "%02dKWW4_%s_Track%s.mp3" "$track" "$unit" "$track")"
audio_dir="media-cache/kww4"
out_dir="private/transcripts/kww4"
audio_path="${audio_dir}/${file_name}"
out_path="${out_dir}/track-${track}.txt"

mkdir -p "$audio_dir" "$out_dir"

if [ ! -s "$audio_path" ]; then
  curl -fL --retry 3 --output "$audio_path" "${audio_base}/${file_name}"
fi

curl -fsS "${base_url}/audio/transcriptions" \
  -H "Authorization: Bearer ${OPENAI_API_KEY}" \
  -F "model=${model}" \
  -F "file=@${audio_path}" \
  -F "response_format=text" \
  -F "language=en" \
  -o "$out_path"

echo "$out_path"
