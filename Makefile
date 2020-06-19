.PHONY: upgrade-pipecd
upgrade-pipecd:
	helm upgrade pipecd --install -n default --debug -f manifests/pipecd/override-values.yaml manifests/pipecd/

.PHONY: upgrade-site
upgrade-site:
	helm upgrade site --install -n default --debug -f manifests/site/override-values.yaml manifests/site/

.PHONY: pipecd-iap
pipecd-iap:
	kubectl -n default create secret generic pipecd-iap --from-literal=client_id=${PIPECD_CLIENT_ID_KEY} --from-literal=client_secret=${PIPECD_CLIENT_SECRET_KEY}

.PHONY: site-iap
pipecd-iap:
	kubectl -n default create secret generic site-iap --from-literal=client_id=${SITE_CLIENT_ID_KEY} --from-literal=client_secret=${SITE_CLIENT_SECRET_KEY}

.PHONY: generate-tls
generate-tls:
	openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
		-keyout tls.key \
		-out tls.crt \
		-subj "/CN=pipecd.dev" \
		-config tls.config
	mv tls.key secrets/
	mv tls.crt secrets/

.PHONY: apply-tls
apply-tls:
	kubectl -n default create secret tls internal-tls --cert=secrets/tls.crt --key=secrets/tls.key
