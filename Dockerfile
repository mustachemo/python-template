# Multi-stage Dockerfile for Python project template
# Follows security best practices with non-root user and minimal final image

# =============================================================================
# Builder stage: Install dependencies and build the application
# =============================================================================
FROM python:3.11-slim as builder

# Set environment variables for Python
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Install system dependencies needed for building
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install uv for fast dependency management
RUN pip install uv

# Create and set working directory
WORKDIR /app

# Copy dependency files
COPY pyproject.toml ./

# Copy source code first
COPY src/ ./src/

# Install Python dependencies and the package
RUN uv add --dev .

# =============================================================================
# Development stage: Include development dependencies and tools
# =============================================================================
FROM builder as development

# Development dependencies are already installed from builder stage

# Copy test files and other development resources
COPY tests/ ./tests/
COPY Makefile ./

# Set the default command for development
CMD ["python", "-m", "project_template.cli", "--help"]

# =============================================================================
# Production stage: Minimal runtime image with only necessary components
# =============================================================================
FROM python:3.11-slim as production

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PATH="/home/appuser/.local/bin:$PATH"

# Install runtime system dependencies
RUN apt-get update && apt-get install -y \
    --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user for security
RUN groupadd --gid 1000 appuser && \
    useradd --uid 1000 --gid appuser --shell /bin/bash --create-home appuser

# Set working directory
WORKDIR /app

# Copy Python environment from builder
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# Copy application source code
COPY --from=builder /app/src ./src
COPY --from=builder /app/pyproject.toml ./

# Create necessary directories and set permissions
RUN mkdir -p /app/logs /app/input /app/output && \
    chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

# Create logs directory in user home if needed
RUN mkdir -p /home/appuser/logs

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import project_template; print('OK')" || exit 1

# Default command
CMD ["python", "-m", "project_template.cli", "--help"]

# =============================================================================
# Labels for metadata
# =============================================================================
LABEL maintainer="your.email@example.com" \
      description="Project template demonstrating modern Python practices" \
      version="0.1.0" \
      org.opencontainers.image.source="https://github.com/yourusername/project-template"
