#!/bin/bash
python3 -m vllm.entrypoints.openai.api_server \
  --model /app/model \
  --host 0.0.0.0 \
  --port 8080 \
  --gpu-memory-utilization 0.75 \
  --max-model-len 1024 \
  --dtype auto \
  --enforce-eager
