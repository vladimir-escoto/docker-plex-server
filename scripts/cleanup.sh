#!/usr/bin/env bash
set -euo pipefail

MEDIA_ROOT=${MEDIA_ROOT:-/data/media}
DOWNLOADS_ROOT=${DOWNLOADS_ROOT:-"$MEDIA_ROOT/downloads"}
COMPLETED_DIR=${COMPLETED_DIR:-"$DOWNLOADS_ROOT/completed"}
INCOMPLETE_DIR=${INCOMPLETE_DIR:-"$DOWNLOADS_ROOT/incomplete"}

log() {
  printf '%s\n' "$1"
}

prune_directory() {
  local target_dir="$1"
  local max_age_days="$2"

  if [[ -d "$target_dir" ]]; then
    find "$target_dir" -type f -mtime "+$max_age_days" -print -delete
  else
    log "Directorio no encontrado: $target_dir"
  fi
}

log "Limpiando descargas antiguas..."
prune_directory "$COMPLETED_DIR" 30
prune_directory "$INCOMPLETE_DIR" 7
log "Limpieza completada."
