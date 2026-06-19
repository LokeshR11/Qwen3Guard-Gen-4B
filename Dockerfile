FROM python:3.10-slim AS builder

WORKDIR /builder

RUN pip install --no-cache-dir huggingface_hub

RUN python3 -c "from huggingface_hub import snapshot_download; snapshot_download(repo_id='Qwen/Qwen3Guard-Gen-4B', local_dir='/model', local_dir_use_symlinks=False)"

FROM vllm/vllm-openai:v0.8.2

WORKDIR /app

COPY --from=builder /model /app/model

ENV HF_HOME=/app/model
ENV TRANSFORMERS_CACHE=/app/model
ENV VLLM_USE_V1=0

COPY start.sh /app/start.sh

RUN chmod +x /app/start.sh

EXPOSE 8080

ENTRYPOINT []



CMD ["/bin/bash", "/app/start.sh"]

#v1
