FROM minio/minio:RELEASE.2024-06-13T22-53-53Z-cpuv1

COPY create-buckets.sh /usr/local/bin/create-buckets.sh
RUN chmod +x /usr/local/bin/create-buckets.sh

COPY read_secrets.sh /read_secrets.sh
RUN chmod +x /read_secrets.sh

ENTRYPOINT ["/read_secrets.sh", "/usr/local/bin/create-buckets.sh"]
