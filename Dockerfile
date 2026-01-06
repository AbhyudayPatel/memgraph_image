FROM memgraph/memgraph:latest

EXPOSE 7687

# Essential for Railway Persistence
ENV MEMGRAPH_STORAGE_SNAPSHOT_ON_EXIT=true
ENV MEMGRAPH_STORAGE_RECOVER_ON_STARTUP=true

CMD ["memgraph", \
     "--bolt-address=::", \
     "--memory-limit=8192", \
     "--data-directory=/var/lib/memgraph", \
     "--storage-mode=IN_MEMORY_ANALYTICAL", \
     "--storage-snapshot-interval-sec=300", \
     "--storage-snapshot-on-exit=true", \
     "--storage-wal-enabled=true"]