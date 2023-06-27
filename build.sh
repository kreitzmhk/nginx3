docker build -t kreitzmhk/$(jq -r ".name" package.json):$(jq -r ".version" package.json) .
docker push kreitzmhk/$(jq -r ".name" package.json):$(jq -r ".version" package.json)

docker tag kreitzmhk/$(jq -r ".name" package.json):$(jq -r ".version" package.json) kreitzmhk/$(jq -r ".name" package.json):latest
docker push kreitzmhk/$(jq -r ".name" package.json):latest

az containerapp up \
--name $(jq -r ".name" package.json) \
--resource-group rg-learn-sbx-ckreitz \
--location westeurope \
--environment ce-learn-sbx-ckreitz \
--image docker.io/kreitzmhk/$(jq -r ".name" package.json):latest \
--target-port 80 \
--ingress external \
--query properties.configuration.ingress.fqdn
