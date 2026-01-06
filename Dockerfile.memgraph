FROM memgraph/memgraph:latest

LABEL maintainer="timeline-kg"
LABEL description="Memgraph image with automatic IPv6/IPv4 binding, persistent storage, and 8GB memory limit"

# Expose Bolt port
EXPOSE 7687

# Set memory limit to 8GB for handling 200+ documents per day per user
# This is significantly increased from the default 512 MiB to prevent OOM errors
# Can be overridden by setting MEMGRAPH_MEMORY_LIMIT_MIB environment variable in Railway
ENV MEMGRAPH_MEMORY_LIMIT_MIB=8192

# Enable storage snapshots for persistence and recovery
ENV MEMGRAPH_STORAGE_SNAPSHOT_ON_EXIT=true
ENV MEMGRAPH_STORAGE_RECOVER_ON_STARTUP=true
ENV MEMGRAPH_LOG_LEVEL=WARNING

# Create volume mount point for persistent storage
# Data will persist across container restarts and redeployments
VOLUME ["/var/lib/memgraph"]

# Override the default command to include:
# - IPv6 binding (::) for Railway compatibility
# - Memory limit from environment variable
# - Data directory for persistent storage
CMD memgraph \
    --bolt-address=:: \
    --memory-limit=${MEMGRAPH_MEMORY_LIMIT_MIB} \
    --data-directory=/var/lib/memgraph \
    --storage-properties-on-edges=true \
    --storage-snapshot-interval-sec=300 \
    --storage-wal-enabled=true \
    --storage-snapshot-on-exit=true \
    --storage-recover-on-startup=true