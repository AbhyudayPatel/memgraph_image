FROM memgraph/memgraph:latest

LABEL maintainer="timeline-kg"
LABEL description="Memgraph image for Railway with IN_MEMORY_ANALYTICAL mode and 8GB memory limit"

# 1. Expose the Bolt port for database connections
EXPOSE 7687

# 2. Environment Variables
# These ensure Memgraph knows how to handle the Railway ephemeral filesystem
ENV MEMGRAPH_STORAGE_SNAPSHOT_ON_EXIT=true
ENV MEMGRAPH_STORAGE_RECOVER_ON_STARTUP=true
ENV MEMGRAPH_LOG_LEVEL=WARNING

# 3. Optimized Command for Railway
# - Use :: to bind to IPv6 (required by Railway)
# - Set storage-mode to IN_MEMORY_ANALYTICAL to bypass the vm.max_map_count crash
# - Set memory limit to 8GB (8192 MiB)
# - Point data directory to the path where you will mount your Railway Volume
CMD ["memgraph", \
     "--bolt-address=::", \
     "--memory-limit=8192", \
     "--data-directory=/var/lib/memgraph", \
     "--storage-mode=IN_MEMORY_ANALYTICAL", \
     "--storage-snapshot-interval-sec=300", \
     "--storage-wal-enabled=true", \
     "--storage-snapshot-on-exit=true", \
     "--storage-parallel-schema-recovery=true"]