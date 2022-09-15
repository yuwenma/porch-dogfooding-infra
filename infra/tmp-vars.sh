#!/bin/bash
PROJECT_ID=$(gcloud config get core/project)
FOLDER_ID=$(gcloud projects describe ${PROJECT_ID} "--format=get(parent.id)")
SA_EMAIL="$(kubectl get ConfigConnectorContext -n config-control -o jsonpath='{.items[0].spec.googleServiceAccount}' 2> /dev/null)"
BILLINGACCOUNT=GET_VALUE_FROM_INTERNAL_DOC

cat > package-context.yaml << EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: kptfile.kpt.dev
  annotations:
    config.kubernetes.io/local-config: "true"
data:
  projectID: ${PROJECT_ID}
  folderID: "${FOLDER_ID}"
  saEmail: ${SA_EMAIL}
  billingAccount: ${BILLINGACCOUNT}
EOF
