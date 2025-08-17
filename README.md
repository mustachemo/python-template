# Project Template

A modern Python project template demonstrating best practices for development, testing, deployment, and maintenance. This template follows the style guide principles of clarity, systematic approach, and production-ready code.

## 🚀 Quick Start

### Prerequisites

- Python 3.11+
- [uv](https://github.com/astral-sh/uv) for dependency management
- Docker (optional, for containerization)
- Git

### Setup

```bash
# Clone or download this template
git clone <repository-url> my-project
cd my-project

# Initialize the development environment
python scripts/setup.py init

# Or manually:
uv add --dev .
make install
```

### Verify Installation

```bash
# Run tests to verify everything works
make test

# Check code quality
make check-all

# Run the example CLI
make run
```

## 📁 Project Structure

```
project-template/
├── src/                    # Source code
│   └── project_template/   # Main package
│       ├── __init__.py
│       ├── core.py         # Core business logic
│       └── cli.py          # Command-line interface
├── tests/                  # Test suite mirroring src/
│   ├── conftest.py         # Pytest configuration
│   ├── test_core.py        # Core module tests
│   └── test_cli.py         # CLI tests
├── configs/                # Configuration files
│   ├── settings.py         # Application settings
│   └── logging.yaml        # Logging configuration
├── scripts/                # Utility scripts
│   ├── setup.py            # Project setup script
│   ├── build.sh            # Docker build script
│   └── sql/                # Database scripts
├── docs/                   # Documentation
├── examples/               # Usage examples
│   ├── basic_usage.py      # Basic functionality examples
│   └── ml_workflow.py      # ML workflow with MLflow
├── logs/                   # Application logs (created at runtime)
├── data/                   # Data files (created at runtime)
├── input/                  # Input files for processing
├── output/                 # Output files from processing
├── notebooks/              # Jupyter notebooks
├── pyproject.toml          # Project metadata and dependencies
├── Makefile                # Development automation
├── Dockerfile              # Multi-stage container build
├── docker-compose.yml      # Development environment
├── .gitignore              # Git ignore patterns
└── README.md               # This file
```

## 🛠️ Development

### Available Make Targets

```bash
make help           # Show all available targets
make install        # Install development dependencies
make test           # Run test suite
make test-cov       # Run tests with coverage
make lint           # Check code style and errors
make format         # Format code
make type-check     # Run type checking
make check-all      # Run all quality checks
make clean          # Remove temporary files
make build          # Build Docker image
make run            # Run CLI application
```

### Code Quality

This project enforces high code quality standards:

- **Linting**: `ruff` for fast Python linting
- **Formatting**: `ruff format` (Black-compatible)
- **Type Checking**: `mypy` with strict settings
- **Testing**: `pytest` with coverage reporting
- **Pre-commit Hooks**: Automated quality checks

### Configuration Management

The project uses a sophisticated configuration system:

- Environment-based settings in `configs/settings.py`
- YAML-based logging configuration
- Environment variable overrides
- Type-safe configuration with validation

### Testing Strategy

Comprehensive testing approach:

- **Unit Tests**: Individual component testing
- **Integration Tests**: Component interaction testing
- **CLI Tests**: Command-line interface testing
- **Fixtures**: Reusable test utilities in `conftest.py`
- **Coverage**: Aim for >90% code coverage

## 🐳 Docker & Deployment

### Multi-Stage Docker Build

The `Dockerfile` implements multi-stage builds:

- **Builder Stage**: Dependency installation and compilation
- **Development Stage**: Full development environment with tools
- **Production Stage**: Minimal runtime image with security hardening

### Docker Compose Services

The `docker-compose.yml` provides a complete development environment:

- **app-dev**: Development application with hot-reload
- **app-prod**: Production application container
- **postgres**: PostgreSQL database
- **redis**: Redis for caching and queues
- **mlflow**: MLflow tracking server
- **jupyter**: Jupyter Lab for experimentation

### Building and Running

```bash
# Build development image
make build-dev

# Build production image
make build

# Run with Docker Compose
docker-compose up app-dev

# Run production environment
docker-compose up app-prod postgres redis mlflow
```

## 📊 ML Workflow Integration

The template includes MLflow integration for machine learning projects:

- Experiment tracking and management
- Parameter and metric logging
- Model registry and versioning
- Artifact storage and management

See `examples/ml_workflow.py` for complete examples.

## 🔧 Customization

### Adapting the Template

1. **Rename the Package**: Update `src/project_template/` to your package name
2. **Update Metadata**: Modify `pyproject.toml` with your project details
3. **Configure Services**: Adjust `docker-compose.yml` for your needs
4. **Set Dependencies**: Add your specific dependencies to `pyproject.toml`
5. **Initialize Project**: Run `make init-project` for interactive setup

### Environment Variables

Key environment variables for configuration:

```bash
ENVIRONMENT=development|staging|production
DEBUG=true|false
LOG_LEVEL=DEBUG|INFO|WARNING|ERROR
MAX_WORKERS=<number>
DB_HOST=localhost
DB_PORT=5432
MLFLOW_TRACKING_URI=http://localhost:5000
```

## 📚 Documentation

Comprehensive documentation is available in the `docs/` directory:

- Architecture decisions and design patterns
- API reference and usage guides
- Deployment procedures and best practices
- Tutorial and how-to guides

## 🧪 Examples

The `examples/` directory contains practical usage examples:

- **basic_usage.py**: Core functionality demonstration
- **ml_workflow.py**: Machine learning workflow with MLflow
- **notebooks/**: Jupyter notebooks for experimentation

## 🔐 Security

Security best practices implemented:

- Non-root user in Docker containers
- Dependency vulnerability scanning with safety
- Secret management via environment variables
- Input validation and sanitization
- Comprehensive logging for audit trails

## 📈 Monitoring and Observability

Built-in observability features:

- Structured logging with `loguru`
- Performance metrics collection
- Health checks in Docker containers
- MLflow experiment tracking
- Error tracking and alerting

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes following the style guide
4. Run quality checks (`make check-all`)
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Code Style Guidelines

- Follow PEP 8 and the project style guide
- Use type hints for all function signatures
- Write comprehensive docstrings (Google style)
- Maintain test coverage above 90%
- Keep functions focused and single-purpose

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

This template incorporates best practices from:

- Python packaging community standards
- Modern DevOps and MLOps practices
- Security-first development principles
- Production-ready code patterns

## 📞 Support

For questions, issues, or contributions:

- Open an issue on GitHub
- Check the documentation in `docs/`
- Review examples in `examples/`
- Run diagnostics with `python scripts/setup.py doctor`

---

**Note**: This template is designed to be a starting point. Adapt it to your specific needs while maintaining the core principles of clarity, maintainability, and production readiness.
