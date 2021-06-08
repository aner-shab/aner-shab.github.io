#!/bin/bash
echo "[---- Starting init.sh ----]"
ENV_NAME=$1

if [ "$ENV_NAME" = "" ]; then
    ENV_NAME=$ENV
fi

echo "[---- Environment: $ENV_NAME... ----]"
cd ~/git-repos/helm-assembly
git pull
rm -f charts/bizzabo/charts/*.tgz
helm dep update charts/bizzabo
helm upgrade --install --namespace $ENV_NAME $ENV_NAME charts/bizzabo --values=charts/bizzabo/values.yaml --timeout 900s --wait --create-namespace --history-max 2 --set webdashboard.service.host=$ENV_NAME-accounts.ext.dev.bizzabo.com --set realtimenotifications.service.host=$ENV_NAME-realtimenotifications.ext.dev.bizzabo.com --set webring.service.host=$ENV_NAME-attendees.ext.dev.bizzabo.com --set seismo.service.host=$ENV_NAME-seismo.ext.dev.bizzabo.com
echo "[---- Finished upgrading your env! ----]"