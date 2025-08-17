# Makefile for Python project template
# Provides a common interface for development and automation tasks

.PHONY: help install test build clean lint format type-check pre-commit-install run

# Default target
help: ## Show this help message
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Development environment setup
install: ## Install development dependencies using uv
	uv add --dev .
	@echo "✅ Development environment installed"

install-ml: ## Install with ML dependencies
	uv add --optional ml --dev .
	@echo "✅ Development environment with ML dependencies installed"

# Testing
test: ## Run the test suite with pytest
	pytest
	@echo "✅ Tests completed"

test-cov: ## Run tests with coverage report
	pytest --cov-report=html --cov-report=term
	@echo "✅ Tests with coverage completed"

test-fast: ## Run tests in parallel (faster)
	pytest -n auto
	@echo "✅ Fast tests completed"

# Code quality
lint: ## Run linter to check code style and errors
	uv run ruff check src/ tests/
	@echo "✅ Linting completed"

format: ## Format code using ruff
	uv run ruff format src/ tests/
	@echo "✅ Code formatting completed"

format-check: ## Check if code is properly formatted
	uv run ruff format --check src/ tests/
	@echo "✅ Format check completed"

type-check: ## Run type checking with mypy
	uv run mypy src/
	@echo "✅ Type checking completed"

check-all: lint format-check type-check ## Run all code quality checks
	@echo "✅ All quality checks completed"

# Pre-commit hooks
pre-commit-install: ## Install pre-commit hooks
	uv run pre-commit install
	@echo "✅ Pre-commit hooks installed"

pre-commit-run: ## Run pre-commit hooks on all files
	uv run pre-commit run --all-files
	@echo "✅ Pre-commit hooks executed"

# Docker
build: ## Build the Docker container
	docker build -t project-template:latest .
	@echo "✅ Docker image built"

build-dev: ## Build Docker container for development
	docker build -t project-template:dev --target development .
	@echo "✅ Development Docker image built"

# Cleanup
clean: ## Remove temporary files and build artifacts
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	rm -rf build/
	rm -rf dist/
	rm -rf .pytest_cache/
	rm -rf .coverage
	rm -rf htmlcov/
	rm -rf .mypy_cache/
	rm -rf .ruff_cache/
	@echo "✅ Cleanup completed"

# Application commands
run: ## Run the CLI application (example command)
	uv run python -m project_template.cli --help

run-process: ## Run the process command with example arguments
	mkdir -p input output
	echo "sample data" > input/sample.txt
	uv run python -m project_template.cli process --input-dir input --output-dir output
	@echo "✅ Example processing completed"

# Development utilities
logs: ## View recent log files
	@find logs/ -name "*.log" -type f -exec ls -la {} \; 2>/dev/null || echo "No log files found"

logs-tail: ## Tail the most recent log file
	@tail -f $$(find logs/ -name "*.log" -type f -printf '%T@ %p\n' 2>/dev/null | sort -n | tail -1 | cut -d' ' -f2) 2>/dev/null || echo "No log files found"

# Project initialization (for new projects)
init-project: ## Initialize a new project from this template
	@read -p "Enter project name: " name; \
	read -p "Enter your name: " author; \
	read -p "Enter your email: " email; \
	sed -i "s/project-template/$$name/g" pyproject.toml; \
	sed -i "s/project_template/$${name//-/_}/g" pyproject.toml src/project_template/*.py; \
	sed -i "s/Your Name/$$author/g" pyproject.toml; \
	sed -i "s/your.email@example.com/$$email/g" pyproject.toml; \
	mv src/project_template src/$${name//-/_}; \
	echo "✅ Project initialized as $$name"
