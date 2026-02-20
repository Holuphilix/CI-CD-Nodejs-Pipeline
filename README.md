# Production-Ready CI Pipeline for Node.js Application

## 1. Project Overview

This project demonstrates a production-style Continuous Integration (CI) workflow using GitHub Actions.

The pipeline enforces automated validation before artifact creation using a gated multi-job workflow. It simulates how modern DevOps teams ensure that only tested and verified code is packaged into deployable artifacts.

This repository focuses on pipeline design, validation strategy, and artifact control rather than application complexity.

---

## 2. Problem Statement

In real-world software development, manually testing and deploying code increases risk and reduces reliability.

A proper CI system must:

- Automatically validate code changes
- Prevent broken code from progressing
- Separate validation from artifact creation
- Ensure reproducibility across environments

This project implements those principles using GitHub Actions and Docker.

---

## 3. Architecture Design

The CI workflow is structured into two distinct layers:

Validation Layer  
↓  
Artifact Creation Layer  

Pipeline Flow:

Developer Push  
        ↓  
GitHub Actions Trigger  
        ↓  
Test Job (Unit Testing with Jest)  
        ↓  
Build Job (Docker Image Creation)  
        ↓  
Artifact Ready for Deployment  

The build job is gated using the `needs:` dependency keyword, ensuring that Docker images are only created when all tests pass successfully.

---

## 4. CI Pipeline Design

The GitHub Actions workflow consists of two jobs:

### Test Job

- Runs on Ubuntu runner
- Installs project dependencies
- Executes unit tests
- Fails immediately if any test does not pass

Purpose:
Acts as the quality gate for the pipeline.

---

### Build Job

- Depends on successful completion of the test job
- Builds a Docker image using a multi-stage Dockerfile
- Simulates artifact creation for production deployment

Purpose:
Separates validation from packaging responsibilities.

This structure mirrors real-world CI/CD design patterns.

---

## 5. Multi-Stage Docker Strategy

The Dockerfile uses a multi-stage build approach:

Stage 1 – Dependency Installation  
Stage 2 – Test Execution  
Stage 3 – Production Image Creation  

Benefits:

- Ensures tests pass inside containerized environment
- Prevents devDependencies from being included in production image
- Produces a minimal and clean runtime image
- Simulates production-grade container practices

---

## 6. Project Structure

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

The structure separates application logic, test logic, and pipeline configuration clearly.

---

## 7. Local Development Setup

Clone the repository:

```

git clone <repository-url>
cd ci-cd-nodejs-pipeline

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

---

## 8. Fail-Fast Mechanism

The pipeline enforces a fail-fast mechanism:

- If unit tests fail → Build job does not execute
- If Docker build fails → Artifact is not created

This prevents unstable or unverified code from being packaged.

---

## 9. Future Improvements

- Add Docker image push to container registry
- Add branch protection rules
- Add code coverage reporting
- Introduce staging deployment simulation
- Add linting stage for code quality enforcement

---

## 10. Key DevOps Concepts Demonstrated

- Continuous Integration (CI)
- Job dependency gating (`needs:`)
- Multi-stage Docker builds
- Artifact generation control
- Fail-fast pipeline behavior
- Environment reproducibility
```

# STILL WORKING ON THIS PROJECT
