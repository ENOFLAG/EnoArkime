# EnoArkime

```yaml
services:
  arkime:
    image: ghcr.io/enoflag/enoarkime:nightly
    ports:
      - 8005:8005
    volumes:
      - "./pcaps:/opt/arkime/raw"
    environment:
      - OPENSEARCH_INITIAL_ADMIN_PASSWORD=Enoflag123!
  opensearch:
    image: public.ecr.aws/opensearchproject/opensearch:3
    environment:
      - discovery.type=single-node
      - OPENSEARCH_INITIAL_ADMIN_PASSWORD=Enoflag123!

```
