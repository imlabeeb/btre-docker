#!/bin/bash
kubectl patch deployment btre-deployment -p "$(cat patch-file.yaml)"
