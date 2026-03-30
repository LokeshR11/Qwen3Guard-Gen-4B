# ---------- Stage 1: Download model ----------
FROM python:3.10-slim as builder

WORKDIR /builder

RUN pip install --no-cache-dir huggingface_hub

ENV HF_HOME=/model
ENV TRANSFORMERS_CACHE=/model


RUN python3 -c "from huggingface_hub import snapshot_download; \
snapshot_download(repo_id='Qwen/Qwen3-Guard-4B', \
local_dir='/model', local_dir_use_symlinks=False)"

# Cleanup
RUN rm -rf /root/.cache /tmp/*


# ---------- Stage 2: Runtime ----------
FROM vllm/vllm-openai:latest

WORKDIR /app

COPY --from=builder /model /app/model

RUN rm -rf /root/.cache /tmp/*

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 8080

CMD ["/app/start.sh"]
