# Production-Ready CI Pipeline for Node.js Application

## 1. Project Overview

This project demonstrates a production-style Continuous Integration (CI) workflow using GitHub Actions.

The pipeline enforces automated validation before artifact creation using a gated multi-job workflow. It simulates how modern DevOps teams ensure that only tested and verified code is packaged into deployable artifacts.

The focus of this repository is pipeline architecture, validation strategy, and artifact lifecycle control — not application complexity.

## 2. Why This Project Was Built

This project was built to deepen practical understanding of CI pipeline design beyond simply using tools.

It focuses on:

- Validation gating mechanisms
- Artifact creation control
- Separation of responsibilities in CI
- Production-oriented container build strategies
- Fail-fast pipeline behavior

The goal is to simulate real-world DevOps pipeline discipline.

## 3. Problem Statement

In real-world software development, manual testing and deployment increase risk and reduce reliability.

A properly designed CI system must:

- Automatically validate code changes
- Prevent unstable code from progressing
- Separate validation from artifact creation
- Ensure reproducibility across environments
- Control artifact lifecycle strictly

This project implements those principles using GitHub Actions and Docker.

## 4. Architecture Design

The CI workflow is structured into two distinct layers:

Validation Layer  
↓  
Artifact Creation Layer  

### Pipeline Execution Flow

```

Developer Push
↓
GitHub Actions Trigger
↓
Test Job (Validation)
↓
Build Job (Artifact Creation)
↓
Docker Image Ready

```

The build job is gated using the `needs:` dependency keyword, ensuring that Docker images are only created when all tests pass successfully.

This enforces strict artifact lifecycle control.

## 5. CI Pipeline Design

The GitHub Actions workflow consists of two independent jobs:

### Test Job (Validation Layer)

- Runs on Ubuntu runner
- Installs project dependencies
- Executes unit tests using Jest
- Fails immediately if any test does not pass

Purpose:
Acts as the quality gate for the pipeline.

### Build Job (Artifact Layer)

- Depends on successful completion of the test job
- Builds a Docker image
- Simulates artifact creation for production deployment

Purpose:
Separates validation from packaging responsibilities and ensures controlled artifact creation.

This structure mirrors real-world CI/CD design patterns used in production systems.

## 6. Artifact Lifecycle Control

Artifact lifecycle control ensures that deployable artifacts are only created under validated conditions.

In this project:

- Unit tests must pass before Docker image creation
- The build job depends on the test job (`needs:`)
- If validation fails → artifact is not created
- If Docker build fails → artifact is not produced

This prevents unstable or unverified code from being packaged or promoted downstream.

## 7. Multi-Stage Docker Strategy

The Dockerfile follows a multi-stage build approach to simulate production-grade container practices.

Stages:

- Dependency Installation
- Test Execution (environment validation)
- Production Image Creation

Benefits:

- Ensures environment consistency
- Prevents devDependencies from leaking into production image
- Produces minimal and clean runtime images
- Reinforces fail-fast behavior during build

This reflects containerization best practices used in modern DevOps workflows.

## 8. Project Structure

```

ci-cd-nodejs-pipeline/
│
├── src/
│   └── calculator.js
│
├── tests/
│   └── calculator.test.js
│
├── Dockerfile
├── package.json
├── .github/
│   └── workflows/
│       └── ci.yml
└── README.md

```

The structure clearly separates:

- Application logic
- Test logic
- Pipeline configuration
- Container build configuration

## 9. Local Development Setup

Clone the repository:

```
git clone https://github.com/Holuphilix/CI-CD-Nodejs-Pipeline.git
```
Install dependencies:
```
npm install
```
Run tests locally:
```
npm test
```
Build Docker image:
```
docker build -t ci-cd-nodejs-pipeline .
```

## 10. Failure Simulation

To validate the fail-fast mechanism:

1. Intentionally modify a unit test to fail.
2. Push changes to the main branch.
3. Observe that:
   - Test job fails.
   - Build job does not execute.
   - No Docker image is created.

This demonstrates controlled artifact gating within the pipeline.

## 11. Future Improvements

- Push Docker image to container registry
- Add semantic version tagging strategy
- Implement branch protection rules
- Add code coverage reporting
- Introduce staging deployment simulation
- Add linting stage for code quality enforcement
- Add manual approval gate for production promotion

## 12. Key DevOps Concepts Demonstrated

- Continuous Integration (CI)
- Job dependency gating (`needs:`)
- Artifact lifecycle control
- Multi-stage Docker builds
- Fail-fast pipeline behavior
- Environment reproducibility
- Separation of validation and packaging stages

## 13. Dual-Layer Validation Strategy

This project implements validation at two independent layers:

1. CI-Level Validation  
   - Unit tests executed directly in GitHub Actions runner.

2. Container-Level Validation  
   - Unit tests executed again inside Docker test stage.

Why?

This ensures:
- Code correctness
- Environment consistency
- Container reproducibility
- Artifact reliability

If tests fail at either layer, artifact creation is blocked.

This simulates production-grade artifact lifecycle enforcement.

