# ----------- Stage 1: Download model -----------
FROM python:3.10-slim as builder

WORKDIR /builder

RUN pip install --no-cache-dir huggingface_hub

ENV HF_HOME=/model
ENV TRANSFORMERS_CACHE=/model

RUN python3 -c "from huggingface_hub import snapshot_download; \
snapshot_download(repo_id='Qwen/Qwen3Guard-Gen-4B', \
local_dir='/model', local_dir_use_symlinks=False)"

# Cleanup
RUN rm -rf /root/.cache /tmp/*

# ----------- Stage 2: Runtime -----------
FROM vllm/vllm-openai:v0.8.2

WORKDIR /app


RUN pip install --no-cache-dir \
    "transformers==4.51.3" \
    "tokenizers==0.21.1"

# Copy model from builder
COPY --from=builder /model /app/model

# Cleanup
RUN rm -rf /root/.cache /tmp/*

# Copy startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh


ENV VLLM_USE_V1=0

EXPOSE 8080

# Override base image ENTRYPOINT (vllm/vllm-openai sets its own)
# Without this, /app/start.sh gets passed as an argument to vLLM itself
ENTRYPOINT []
CMD ["/bin/bash", "/app/start.sh"]
