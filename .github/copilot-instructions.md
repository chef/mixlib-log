# Copilot Instructions for mixlib-log Repository

## Repository Overview

The mixlib-log repository provides a Ruby mixin for enabling a class-based logger object. This is a Ruby gem project that follows Chef's development standards and practices.

### Repository Structure

```
mixlib-log/
├── .github/                    # GitHub configuration and workflows
│   ├── CODEOWNERS             # Code ownership configuration
│   ├── ISSUE_TEMPLATE/        # Issue templates
│   ├── dependabot.yml         # Dependabot configuration
│   └── workflows/             # GitHub Actions workflows
├── features/                   # Cucumber features for behavior testing
│   ├── log.feature           # Main logging feature tests
│   ├── steps/                # Step definitions
│   └── support/              # Test support files
├── lib/                       # Main library code
│   └── mixlib/
│       ├── log.rb            # Main logging module
│       └── log/              # Supporting logging classes
│           ├── child.rb      # Child logger implementation
│           ├── formatter.rb  # Log formatting
│           ├── logger.rb     # Logger class
│           ├── logging.rb    # Logging utilities
│           └── version.rb    # Version information
├── spec/                      # RSpec unit tests
│   ├── spec_helper.rb        # Test configuration
│   └── mixlib/               # Test files mirroring lib structure
├── vendor/                    # Bundled dependencies
├── Gemfile                    # Gem dependencies
├── Gemfile.lock              # Locked dependency versions
├── Rakefile                   # Build tasks
├── mixlib-log.gemspec        # Gem specification
├── README.md                 # Project documentation
├── CHANGELOG.md              # Change history
├── VERSION                   # Version file
└── LICENSE                   # Apache 2.0 license
```

## Jira Integration with MCP Server

When a Jira ID is provided:

1. **Use the atlassian-mcp-server** to fetch Jira issue details
2. **Read the story requirements** thoroughly from the Jira issue
3. **Implement the task** according to the specifications
4. **Reference the Jira ID** in commits and PR descriptions

### Jira Workflow Commands
```bash
# Example MCP server usage for Jira integration
# The atlassian-mcp-server should be configured to access your Jira instance
# Use the following pattern when Jira ID is provided:
# 1. Fetch issue: mcp_atlassian-mcp_getJiraIssue with cloudId and issueIdOrKey
# 2. Read requirements from the issue description and acceptance criteria
# 3. Implement according to the story requirements
```

## Testing Requirements

### Unit Test Coverage
- **Maintain >80% test coverage** for all new and modified code
- Use RSpec for unit tests (located in `spec/` directory)
- Use Cucumber for integration/behavior tests (located in `features/` directory)
- Run tests with: `bundle exec rake spec` and `bundle exec rake features`

### Test Commands
```bash
# Run all tests
bundle exec rake

# Run only unit tests
bundle exec rake spec

# Run only integration tests  
bundle exec rake features

# Run style checks
bundle exec rake style

# Check coverage
bundle exec rspec --format html --out coverage/index.html
```

## Pull Request and Branch Management

### Branch Creation and PR Workflow

When prompted to create a PR for changes:

1. **Create a branch** using the Jira ID as the branch name
2. **Push changes** to the new branch
3. **Create a PR** using GitHub CLI
4. **Include HTML-formatted description** with summary of changes

### GitHub CLI Commands
```bash
# Create and switch to new branch (use Jira ID as branch name)
git checkout -b JIRA-123

# Stage and commit changes with DCO sign-off
git add .
git commit -s -m "feat: implement feature for JIRA-123

Detailed description of changes made.

Signed-off-by: Your Name <your.email@example.com>"

# Push branch
git push origin JIRA-123

# Create PR with HTML description
gh pr create --title "feat: implement feature for JIRA-123" \
  --body "<h2>Summary</h2>
<p>Brief description of changes</p>
<h2>Changes Made</h2>
<ul>
<li>Change 1</li>
<li>Change 2</li>
</ul>
<h2>Testing</h2>
<p>Description of testing performed</p>
<h2>Jira Issue</h2>
<p>Resolves: JIRA-123</p>"
```

**Important**: All tasks are performed on the local repository. Do not reference `~/.profile` for GitHub authentication steps.

## DCO Compliance Requirements

All commits **MUST** be signed off to comply with the Developer Certificate of Origin (DCO):

### DCO Sign-off Requirements
- **Every commit** must include a `Signed-off-by` line
- Use `git commit -s` to automatically add sign-off
- Sign-off certifies you have the right to submit the code under the project's license
- Format: `Signed-off-by: Your Name <your.email@example.com>`

### DCO Commands
```bash
# Commit with automatic DCO sign-off
git commit -s -m "your commit message"

# Add DCO sign-off to existing commit
git commit --amend -s

# Check if commits are signed
git log --show-signature
```

## Build System Integration

### GitHub Actions Workflows
The repository uses GitHub Actions for CI/CD with the following workflow:
- **File**: `.github/workflows/ci-main-pull-request-checks.yml`
- **Triggers**: Pull requests and pushes to `main` and `release/**` branches
- **Common Actions**: Uses `chef/common-github-actions` for standardized CI pipeline

### Expeditor Build System
The repository integrates with Chef's Expeditor build system for:
- Automated version bumping
- Changelog updates  
- Package building and publishing
- Release management

### Available Expeditor Labels
Use these labels to control Expeditor behavior:
- `Expeditor: Bump Version Major` - Bump major version number
- `Expeditor: Bump Version Minor` - Bump minor version number
- `Expeditor: Skip All` - Skip all merge actions
- `Expeditor: Skip Changelog` - Skip changelog updates
- `Expeditor: Skip Habitat` - Skip Habitat package builds
- `Expeditor: Skip Omnibus` - Skip Omnibus builds
- `Expeditor: Skip Version Bump` - Skip version bumping

## Repository-Specific GitHub Labels

### Aspect Labels (for categorizing issues/PRs)
- `Aspect: Documentation` - Documentation improvements
- `Aspect: Integration` - Integration with other systems
- `Aspect: Packaging` - Distribution and packaging
- `Aspect: Performance` - Performance improvements
- `Aspect: Portability` - Cross-platform compatibility
- `Aspect: Security` - Security-related changes
- `Aspect: Stability` - Reliability improvements
- `Aspect: Testing` - Test coverage and CI improvements
- `Aspect: UI` - User interface changes
- `Aspect: UX` - User experience improvements

### Platform Labels
- `Platform: AWS`, `Platform: Azure`, `Platform: GCP` - Cloud platforms
- `Platform: Linux`, `Platform: macOS` - Operating systems
- `Platform: Debian-like`, `Platform: RHEL-like`, `Platform: SLES-like` - Linux distributions
- `Platform: Docker` - Container platform
- `Platform: Unix-like` - Unix-like systems

### Special Labels
- `dependencies` - Dependency updates
- `hacktoberfest-accepted` - Hacktoberfest contributions
- `oss-standards` - OSS repository standardization

## Prompt-Based Task Execution

### Workflow Execution
All tasks should be **prompt-based** with the following pattern:

1. **After each step**: Provide a summary of what was completed
2. **Next step prompt**: Clearly state what the next step will be
3. **Remaining steps**: List what steps are still remaining
4. **Confirmation request**: Ask if you want to continue with the next step

### Example Prompt Pattern
```
✅ **Step Completed**: [Description of what was just done]

📋 **Next Step**: [What will be done next]

📝 **Remaining Steps**:
- Step A
- Step B  
- Step C

❓ **Continue?**: Would you like me to proceed with the next step?
```

## Complete Implementation Workflow

When implementing a task, follow this comprehensive workflow:

### Phase 1: Analysis and Planning
1. **Jira Integration** (if Jira ID provided):
   - Use atlassian-mcp-server to fetch issue details
   - Read and understand story requirements
   - Identify acceptance criteria
   - **Prompt**: Summarize understanding and ask to continue

2. **Code Analysis**:
   - Review existing codebase structure
   - Identify files that need modification
   - Check for similar existing implementations
   - **Prompt**: Present analysis and implementation plan

### Phase 2: Implementation
3. **Branch Creation**:
   - Create branch with Jira ID name (if applicable)
   - **Prompt**: Confirm branch creation and next steps

4. **Code Implementation**:
   - Implement required functionality
   - Follow Ruby and Chef coding standards
   - Ensure backward compatibility
   - **Prompt**: Present implemented code and ask to continue

5. **Unit Test Creation**:
   - Write comprehensive unit tests in `spec/` directory
   - Ensure >80% code coverage requirement
   - Include edge cases and error scenarios
   - **Prompt**: Show test coverage and ask to continue

### Phase 3: Testing and Validation
6. **Test Execution**:
   - Run unit tests: `bundle exec rake spec`
   - Run integration tests: `bundle exec rake features`
   - Run style checks: `bundle exec rake style`
   - **Prompt**: Report test results and any issues

7. **Coverage Verification**:
   - Verify >80% test coverage requirement
   - Generate coverage reports if needed
   - **Prompt**: Confirm coverage meets requirements

### Phase 4: Commit and PR
8. **DCO Compliant Commits**:
   - Stage changes with meaningful commit messages
   - Ensure all commits are DCO signed (`git commit -s`)
   - Reference Jira ID in commit messages
   - **Prompt**: Show commit summary and ask to continue

9. **PR Creation**:
   - Push branch to origin
   - Create PR with GitHub CLI
   - Use HTML-formatted description with:
     - Summary of changes
     - Testing performed
     - Jira issue reference
   - Apply appropriate labels
   - **Prompt**: Show PR details and completion summary

### Prohibited File Modifications
Do **NOT** modify the following files without explicit instruction:
- `.github/CODEOWNERS` - Code ownership rules
- `LICENSE` - License file
- `VERSION` - Version is managed by Expeditor
- `.github/dependabot.yml` - Dependency management configuration
- Core CI workflow files (unless specifically requested)

### Quality Gates
Before completing any task, ensure:
- [ ] All tests pass (`bundle exec rake`)
- [ ] Code coverage >80%
- [ ] Style checks pass (`bundle exec rake style`)
- [ ] DCO sign-off on all commits
- [ ] Jira ID referenced (if applicable)
- [ ] PR has proper HTML description
- [ ] Appropriate labels applied

## Additional Notes

- **Ruby Version**: Follow the Ruby version specified in `.ruby-version` or Gemfile
- **Dependencies**: Use Bundler for dependency management
- **Documentation**: Update README.md if adding new features
- **Changelog**: Expeditor will handle changelog updates automatically
- **Version Bumping**: Handled automatically by Expeditor based on PR labels

This instruction file ensures consistent, high-quality contributions to the mixlib-log repository while maintaining compliance with Chef's development standards and practices.
