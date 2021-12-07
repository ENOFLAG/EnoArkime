# EnoArkime

```yaml
version: '3'
services:
  arkime:
    image: ghcr.io/enoflag/enoarkime:nightly
    ports:
      - 8005:8005
    volumes:
      - "./pcaps:/opt/arkime/raw"
  elasticsearch:
    image: elasticsearch:7.14.2
    environment:
      - discovery.type=single-node
```
