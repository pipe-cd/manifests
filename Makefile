.PHONY: pipecd-iap
pipecd-iap:
	kubectl -n default create secret generic pipecd-iap --from-literal=client_id=${CLIENT_ID_KEY} --from-literal=client_secret=${CLIENT_SECRET_KEY}

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
