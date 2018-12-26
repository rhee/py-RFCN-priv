#
IMAGE=py-rfcn-priv
IMAGEVER=0.3

bulid:	.FORCE
	docker build -t $(IMAGE):$(IMAGEVER) -f docker/Dockerfile .

flatten:	.FORCE
	(set -e && \
        docker run -d --name $(IMAGE)_temp $(IMAGE):$(IMAGVER) tail -F /- && \
	docker export $(IMAGE)_temp | gzip -9 -c - > $(TEMPDIR)/docker-$(IMAGE)_0.2a.tar.gz && \
	docker import $(TEMPDIR)/docker-$(IMAGE)_0.2a.tar.gz $(IMAGE):$(IMAGEVER)a  && \
	docker rm -f $(IMAGE)_temp )

.FORCE:
.PHONY: .FORCE build save

# vim: set sw=4 sts=8 ts=8 noet :
