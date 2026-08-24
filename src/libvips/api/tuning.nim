import ../bindings/vips

proc setCache*(maxImages: int = 0, maxMemory: int = 0, maxFiles: int = 0) =
  if maxImages > 0:
    vips_cache_set_max(maxImages.cint)
  if maxMemory > 0:
    vips_cache_set_max_mem(maxMemory.csize_t)
  if maxFiles > 0:
    vips_cache_set_max_files(maxFiles.cint)

proc setConcurrency*(workers: int) =
  vips_concurrency_set(workers.cint)

proc getConcurrency*(): int =
  vips_concurrency_get().int

proc cacheSetMax*(max: int) =
  vips_cache_set_max(max.cint)

proc cacheSetMaxMemory*(maxMem: int) =
  vips_cache_set_max_mem(maxMem.csize_t)

proc cacheSetMaxFiles*(maxFiles: int) =
  vips_cache_set_max_files(maxFiles.cint)

proc cacheGetMax*(): int =
  vips_cache_get_max().int

proc cacheGetSize*(): int =
  vips_cache_get_size().int

proc vectorSetEnabled*(enabled: bool) =
  vips_vector_set_enabled(enabled.cint)

proc vectorIsEnabled*(): bool =
  vips_vector_isenabled() != 0
