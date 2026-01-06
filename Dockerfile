FROM memgraph/memgraph:latest

LABEL maintainer="timeline-kg"
LABEL description="Memgraph image for Railway with automatic IPv6/IPv4 binding and 8GB memory limit"

# Expose Bolt port
EXPOSE 7687

# Set memory limit to 8GB for handling 200+ documents per day per user
# This is significantly increased from the default 512 MiB to prevent OOM errors
ENV MEMGRAPH_MEMORY_LIMIT_MIB=8192

# Enable storage snapshots for persistence and recovery
ENV MEMGRAPH_STORAGE_SNAPSHOT_ON_EXIT=true
ENV MEMGRAPH_STORAGE_RECOVER_ON_STARTUP=true
ENV MEMGRAPH_LOG_LEVEL=WARNING

# NOTE: Railway manages volumes via their API, not Docker VOLUME declarations
# The data directory will be mounted at /var/lib/memgraph via Railway volumes

# Override the default command to include:
# - IPv6 binding (::) for Railway compatibility
# - Memory limit (8GB hardcoded)
# - Data directory for persistent storage (Railway will mount volume here)
CMD ["memgraph", "--bolt-address=::", "--memory-limit=8192", "--data-directory=/var/lib/memgraph", "--storage-properties-on-edges=true", "--storage-snapshot-interval-sec=300", "--storage-wal-enabled=true", "--storage-snapshot-on-exit=true", "--storage-recover-on-startup=true"]
