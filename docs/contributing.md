---
path: "/docs/contributing-guide"
title: "Contributing Guide"
---

Thanks for taking interest in contributing to Chatwoot source code. Before submitting your contribution, please make sure to take a moment and read through the following guidelines:

- [Code of Conduct](https://www.chatwoot.com/docs/code-of-conduct)
- [Development Setup](https://www.chatwoot.com/docs/installation-guide-ubuntu)
- [Environment Setup](https://www.chatwoot.com/docs/quick-setup)

## Pull Request Guidelines

- Assign the corresponding issue to you whenever you start working on it. This helps in resolving collision (mutliple people working on the same item)

- Please raise the PR against master branch

- It's OK to have multiple small commits as you work on the PR - We will squash the commits before merging.

- If adding a new feature:
  - Add accompanying test case.
  - Provide a convincing reason to add this feature. Ideally, you should open a suggestion issue first and have it approved before working on it.

- If fixing bug:
  - If you are resolving a special issue, add `(fix #xxxx[,#xxxx])` (#xxxx is the issue id) in your PR title.
  - Provide a detailed description of the bug in the PR.
  - Add appropriate test coverage if applicable.
