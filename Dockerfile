FROM memgraph/memgraph:latest

LABEL maintainer="timeline-kg"
LABEL description="Memgraph for Railway - Bypassing vm.max_map_count check"

# 1. Port for Bolt connections
EXPOSE 7687

# 2. CRITICAL: Skip the system check that is causing the crash
ENV MEMGRAPH_SKIP_SYSTEM_CHECKS=true

# 3. Persistence & Memory Settings
ENV MEMGRAPH_STORAGE_SNAPSHOT_ON_EXIT=true
ENV MEMGRAPH_STORAGE_RECOVER_ON_STARTUP=true
ENV MEMGRAPH_LOG_LEVEL=WARNING

# 4. Optimized Command
CMD ["memgraph", \
     "--bolt-address=::", \
     "--memory-limit=8192", \
     "--data-directory=/var/lib/memgraph", \
     "--storage-mode=IN_MEMORY_ANALYTICAL", \
     "--storage-snapshot-interval-sec=300", \
     "--storage-wal-enabled=true", \
     "--storage-snapshot-on-exit=true", \
     "--storage-parallel-schema-recovery=true"]