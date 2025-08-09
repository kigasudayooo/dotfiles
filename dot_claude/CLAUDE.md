# CLAUDE.md - Claude Code Global Configuration

This file provides guidance to Claude Code (claude.ai/code) when working across all projects.

## AI Processing Guidelines

### Language Processing Protocol
- **Input Translation**: Always translate input to English first and think in English
- **Response Protocol**: Translate English thoughts back to Japanese for responses  
- **Emoji Policy**: Never use emojis under any circumstances

## Overview

This is my global Claude Code configuration directory (`~/.claude`) that sets up:
- Professional development standards and workflows
- Language-specific best practices (Python, Go, Kotlin, Bash)
- AI-driven development core principles
- Permission rules for tool usage
- Environment variables for development
- Session history and todo management


## Core Principles for AI-Driven Development

### Why These Principles Matter
AI-generated code cannot understand "implicit agreements" that humans take for granted. Clear structure and contracts enable predictable, maintainable code generation.

### 1. Interface-First Design
**Clear boundary definitions that AI can understand**

#### Core Rules
- **Define interfaces before implementation** - Clarify what goes in, what comes out
- **Enforce type safety** - Catch problems at compile time
- **Document API contracts** - Strictly define input/output formats
- **Explicit module boundaries** - Minimize dependencies

#### Implementation Guidelines
```python
# Python: Clear data contracts with Pydantic models
from pydantic import BaseModel
from typing import Protocol

class UserRepository(Protocol):
    def find_by_id(self, user_id: int) -> User | None: ...
    def save(self, user: User) -> User: ...

class User(BaseModel):
    id: int
    name: str
    email: str
```

```go
// Go: Interface segregation principle
type UserReader interface {
    FindByID(ctx context.Context, id int) (*User, error)
}

type UserWriter interface {
    Save(ctx context.Context, user *User) error
}
```

```kotlin
// Kotlin: Sealed classes for type-safe domain modeling
sealed class Result<out T> {
    data class Success<T>(val data: T) : Result<T>()
    data class Error(val message: String) : Result<Nothing>()
}

interface UserRepository {
    suspend fun findById(id: Int): Result<User>
}
```

### 2. Modular Design Strategy
**Independence and reusability-focused structure**

#### Core Rules
- **Single Responsibility Principle** - Each module has one clear purpose
- **Loose coupling, high cohesion** - Minimize inter-module dependencies
- **Dependency injection patterns** - Enable testing and flexibility
- **Testable design first** - Design for easy testing

#### Implementation Guidelines
```python
# Python: Dependency injection with protocols
class UserService:
    def __init__(self, 
                 user_repo: UserRepository,
                 email_service: EmailService) -> None:
        self._user_repo = user_repo
        self._email_service = email_service
    
    def register_user(self, user_data: UserRegistration) -> User:
        # Single responsibility: user registration logic only
        pass
```

```go
// Go: Interface-based dependency injection
type UserService struct {
    userRepo    UserRepository
    emailSender EmailSender
}

func NewUserService(userRepo UserRepository, emailSender EmailSender) *UserService {
    return &UserService{
        userRepo:    userRepo,
        emailSender: emailSender,
    }
}
```

```kotlin
// Kotlin: Constructor injection with interfaces
class UserService(
    private val userRepository: UserRepository,
    private val emailService: EmailService
) {
    suspend fun registerUser(userData: UserRegistration): Result<User> {
        // Implementation
    }
}
```

### 3. Design by Contract
**Explicit preconditions, postconditions, and invariants**

#### Core Rules
- **Preconditions** - What must be true when function is called
- **Postconditions** - What is guaranteed after function executes
- **Invariants** - What always remains true
- **Fail fast** - Validate assumptions early and explicitly

#### Implementation Guidelines
```python
# Python: Explicit contract documentation and validation
def transfer_funds(from_account: Account, to_account: Account, amount: Money) -> TransferResult:
    """Transfer funds between accounts.
    
    Preconditions:
        - from_account.balance >= amount
        - amount > 0
        - from_account != to_account
    
    Postconditions:
        - from_account.balance' = from_account.balance - amount
        - to_account.balance' = to_account.balance + amount
        - total_balance remains constant
    
    Invariants:
        - Account balances never go negative
        - Total system balance is preserved
    """
    # Validate preconditions
    if from_account.balance < amount:
        raise InsufficientFundsError("Insufficient balance")
    if amount <= 0:
        raise InvalidAmountError("Amount must be positive")
    if from_account.id == to_account.id:
        raise SameAccountError("Cannot transfer to same account")
    
    # Implementation with postcondition guarantees
    pass
```

```go
// Go: Explicit validation and error handling
func TransferFunds(ctx context.Context, fromID, toID int, amount Money) error {
    // Precondition validation
    if amount <= 0 {
        return errors.New("amount must be positive")
    }
    if fromID == toID {
        return errors.New("cannot transfer to same account")
    }
    
    // Implementation ensuring postconditions
    return nil
}
```

```kotlin
// Kotlin: Contract validation with sealed classes
fun transferFunds(fromAccount: Account, toAccount: Account, amount: Money): TransferResult {
    // Precondition checks
    require(amount > Money.ZERO) { "Amount must be positive" }
    require(fromAccount.id != toAccount.id) { "Cannot transfer to same account" }
    
    return when {
        fromAccount.balance < amount -> TransferResult.Error("Insufficient funds")
        else -> {
            // Implementation ensuring postconditions
            TransferResult.Success(/* ... */)
        }
    }
}
```

## Proactive AI Assistance

### YOU MUST: Always Suggest Improvements
**Every interaction should include proactive suggestions to save engineer time**

1. **Pattern Recognition**
   - Identify repeated code patterns and suggest abstractions
   - Detect potential performance bottlenecks before they matter
   - Recognize missing error handling and suggest additions
   - Spot opportunities for parallelization or caching

2. **Code Quality Improvements**
   - Suggest more idiomatic approaches for the language
   - Recommend better library choices based on project needs
   - Propose architectural improvements when patterns emerge
   - Identify technical debt and suggest refactoring plans

3. **Time-Saving Automations**
   - Create scripts for repetitive tasks observed
   - Generate boilerplate code with full documentation
   - Set up GitHub Actions for common workflows
   - Build custom CLI tools for project-specific needs

4. **Documentation Generation**
   - Auto-generate comprehensive documentation
   - Create API documentation from code
   - Generate README sections automatically
   - Maintain architecture decision records (ADRs)

### Proactive Suggestion Format
```
**Improvement Suggestion**: [Brief title]
**Time saved**: ~X minutes per occurrence
**Implementation**: [Quick command or code snippet]
**Benefits**: [Why this improves the codebase]
```

## Development Philosophy

### Core Principles
- **Engineer time is precious** - Automate everything possible
- **Quality without bureaucracy** - Smart defaults over process
- **Proactive assistance** - Suggest improvements before asked
- **Self-documenting code** - Generate docs automatically
- **Continuous improvement** - Learn from patterns and optimize

## AI Assistant Guidelines

### Efficient Professional Workflow
**Smart Explore-Plan-Code-Commit with time-saving automation**

#### 1. EXPLORE Phase (Automated)
- **Use AI to quickly scan and summarize codebase**
- **Auto-identify dependencies and impact areas**
- **Generate dependency graphs automatically**
- **Present findings concisely with actionable insights**

#### 2. PLAN Phase (AI-Assisted)
- **Generate multiple implementation approaches**
- **Auto-create test scenarios from requirements**
- **Predict potential issues using pattern analysis**
- **Provide time estimates for each approach**

#### 3. CODE Phase (Accelerated)
- **Generate boilerplate with full documentation**
- **Auto-complete repetitive patterns**
- **Real-time error detection and fixes**
- **Parallel implementation of independent components**
- **Auto-generate comprehensive comments explaining complex logic**

#### 4. COMMIT Phase (Automated)
```bash
# Language-specific quality checks
uv run --frozen ruff format . && uv run --frozen ruff check . && uv run --frozen pytest  # Python
go fmt ./... && golangci-lint run && go test ./...  # Go
./gradlew ktlintFormat && ./gradlew test  # Kotlin
shellcheck *.sh && bats test/  # Bash
```

### Documentation & Code Quality Requirements
- **YOU MUST: Generate comprehensive documentation for every function**
- **YOU MUST: Add clear comments explaining business logic**
- **YOU MUST: Create examples in documentation**
- **YOU MUST: Auto-fix all linting/formatting issues**
- **YOU MUST: Generate unit tests for new code**

## 🐍 Python Development (Primary Language)

### Core Rules
- **Package Manager**: ONLY use `uv`, NEVER `pip`
- **Type Hints**: Required for all functions
- **Async**: Use `anyio` for testing, not `asyncio`
- **Line Length**: 88 characters maximum
- **Contract Design**: Use Pydantic models for data validation
- **Interface Design**: Use Protocol classes for dependency injection

### Code Quality Tools
```bash
# Format code
uv run --frozen ruff format .

# Lint code
uv run --frozen ruff check . --fix

# Type check
uv run --frozen pyright

# Run tests
uv run --frozen pytest --cov

# Security check
uv run --frozen bandit -r .
```

### Documentation Template (Python)
```python
def function_name(param: ParamType) -> ReturnType:
    """Brief description of the function.
    
    Detailed explanation of what the function does and why.
    
    Preconditions:
        - param must satisfy condition X
        - state Y must be true before calling
    
    Postconditions:
        - result has property Z
        - system state is modified as described
    
    Args:
        param: Description of the parameter and its purpose.
        
    Returns:
        Description of what is returned and its structure.
        
    Raises:
        ErrorType: When this specific error condition occurs.
        
    Example:
        >>> result = function_name("input")
        >>> print(result)
        'expected output'
        
    Note:
        Any important notes about usage or limitations.
    """
    # Implementation
```

### Best Practices
- **Virtual Environments**: Always use uv
- **Dependencies**: Pin versions in pyproject.toml
- **Testing**: Use pytest with fixtures
- **Type Narrowing**: Explicit None checks for Optional
- **Data Validation**: Use Pydantic for all data models
- **Interface Segregation**: Use Protocol classes for clean abstractions

### Contract Design Pattern (Python)
```python
from pydantic import BaseModel, Field, validator
from typing import Protocol, runtime_checkable

# Data contracts with validation
class CreateUserRequest(BaseModel):
    name: str = Field(..., min_length=1, max_length=100)
    email: str = Field(..., regex=r'^[^@]+@[^@]+\.[^@]+$')
    age: int = Field(..., ge=13, le=120)
    
    @validator('name')
    def name_must_not_be_empty(cls, v):
        if not v.strip():
            raise ValueError('Name cannot be empty')
        return v.strip()

# Interface contracts
@runtime_checkable
class UserRepository(Protocol):
    def create_user(self, user_data: CreateUserRequest) -> User: ...
    def find_by_email(self, email: str) -> User | None: ...

# Service with explicit contracts
class UserService:
    def __init__(self, user_repo: UserRepository) -> None:
        self._user_repo = user_repo
    
    def register_user(self, request: CreateUserRequest) -> User:
        """Register a new user with contract validation.
        
        Preconditions:
            - request.email must not exist in system
            - request data must pass validation
        
        Postconditions:
            - User is created and persisted
            - User has valid ID assigned
        """
        # Contract validation
        existing_user = self._user_repo.find_by_email(request.email)
        if existing_user:
            raise ValueError("Email already exists")
        
        # Implementation ensuring postconditions
        return self._user_repo.create_user(request)
```

## 🐹 Go Development

### Core Rules
- **Package Manager**: Use Go modules (`go mod`)
- **Error Handling**: Always check errors, use `errors.Is/As`
- **Naming**: Use short, clear names; avoid stuttering
- **Concurrency**: Prefer channels over shared memory
- **Interface Design**: Accept interfaces, return concrete types
- **Contract Validation**: Explicit precondition checks

### Code Quality Tools
```bash
# Format code
go fmt ./...

# Lint comprehensively
golangci-lint run

# Run tests with coverage
go test -cover -race ./...

# Generate mocks
mockgen -source=interface.go -destination=mock_interface.go

# Vulnerability check
go install golang.org/x/vuln/cmd/govulncheck@latest
govulncheck ./...
```

### Documentation Template (Go)
```go
// FunctionName performs a specific task with the given parameters.
//
// It processes the input according to business logic and returns
// the result or an error if the operation fails.
//
// Preconditions:
//   - ctx must not be nil
//   - input must be valid according to business rules
//
// Postconditions:
//   - Returns valid result on success
//   - Error indicates specific failure reason
//
// Example:
//
//	result, err := FunctionName(ctx, "input")
//	if err != nil {
//	    return fmt.Errorf("failed to process: %w", err)
//	}
//	fmt.Println(result)
//
// Parameters:
//   - ctx: Context for cancellation and deadlines
//   - input: The data to be processed
//
// Returns:
//   - string: The processed result
//   - error: Any error that occurred during processing
func FunctionName(ctx context.Context, input string) (string, error) {
    // Implementation
}
```

### Best Practices
- **Context**: First parameter for functions that do I/O
- **Interfaces**: Accept interfaces, return concrete types
- **Defer**: Use for cleanup, but be aware of loop gotchas
- **Error Wrapping**: Use `fmt.Errorf` with `%w` verb
- **Contract Validation**: Validate inputs explicitly
- **Interface Segregation**: Small, focused interfaces

### Contract Design Pattern (Go)
```go
package user

import (
    "context"
    "errors"
    "fmt"
)

// Domain model with invariants
type User struct {
    ID    int    `json:"id"`
    Email string `json:"email"`
    Name  string `json:"name"`
}

// Validate ensures User satisfies invariants
func (u *User) Validate() error {
    if u.Email == "" {
        return errors.New("email is required")
    }
    if u.Name == "" {
        return errors.New("name is required")
    }
    return nil
}

// Repository interface with clear contracts
type Repository interface {
    // CreateUser creates a new user
    // Preconditions:
    //   - user must pass validation
    //   - user.Email must not exist
    // Postconditions:
    //   - user.ID is assigned
    //   - user is persisted
    CreateUser(ctx context.Context, user *User) error
    
    FindByEmail(ctx context.Context, email string) (*User, error)
}

// Service with contract enforcement
type Service struct {
    repo Repository
}

func NewService(repo Repository) *Service {
    return &Service{repo: repo}
}

func (s *Service) RegisterUser(ctx context.Context, email, name string) (*User, error) {
    // Precondition validation
    if email == "" {
        return nil, errors.New("email is required")
    }
    if name == "" {
        return nil, errors.New("name is required")
    }
    
    user := &User{
        Email: email,
        Name:  name,
    }
    
    // Validate domain invariants
    if err := user.Validate(); err != nil {
        return nil, fmt.Errorf("invalid user: %w", err)
    }
    
    // Check business rules
    existing, err := s.repo.FindByEmail(ctx, email)
    if err != nil {
        return nil, fmt.Errorf("failed to check existing user: %w", err)
    }
    if existing != nil {
        return nil, errors.New("email already exists")
    }
    
    // Execute with postcondition guarantee
    if err := s.repo.CreateUser(ctx, user); err != nil {
        return nil, fmt.Errorf("failed to create user: %w", err)
    }
    
    return user, nil
}
```

## 📱 Kotlin Development (Android)

### Core Rules
- **Package Manager**: Use Gradle with Kotlin DSL
- **Null Safety**: Leverage Kotlin's null safety features
- **Coroutines**: Use for asynchronous programming
- **Immutability**: Prefer `val` over `var`, use data classes
- **Contract Design**: Use sealed classes for type-safe APIs
- **Android Architecture**: Follow MVVM with Repository pattern

### Code Quality Tools
```bash
# Format code
./gradlew ktlintFormat

# Lint code  
./gradlew ktlintCheck

# Run tests with coverage
./gradlew test jacocoTestReport

# Static analysis
./gradlew detekt

# Android lint
./gradlew lint
```

### Documentation Template (Kotlin)
```kotlin
/**
 * Brief description of what the function does
 *
 * Detailed explanation of the business logic and purpose.
 *
 * Preconditions:
 * - param must not be null
 * - specific business rule conditions
 *
 * Postconditions:
 * - result guarantees
 * - state changes that occur
 *
 * @param paramName Description of the parameter and its purpose
 * @return Description of what is returned and its structure
 * @throws ExceptionType When this specific error condition occurs
 * @sample functionNameSample Example usage of this function
 * @since 1.0.0
 */
suspend fun functionName(paramName: ParamType): Result<ReturnType> {
    // Implementation
}

/**
 * Example usage for documentation
 */
private suspend fun functionNameSample() {
    val result = functionName("input")
    result.fold(
        onSuccess = { data -> println(data) },
        onFailure = { error -> println("Error: ${error.message}") }
    )
}
```

### Best Practices
- **Coroutines**: Use structured concurrency with supervisorScope
- **Extensions**: Create extension functions for domain-specific operations
- **Sealed Classes**: Use for representing restricted class hierarchies
- **Type Safety**: Leverage inline classes for type-safe APIs
- **Null Safety**: Explicit null checks, avoid `!!` operator
- **Immutable Data**: Use data classes and collections

### Contract Design Pattern (Kotlin)
```kotlin
// Sealed class for type-safe result handling
sealed class Result<out T> {
    data class Success<T>(val data: T) : Result<T>()
    data class Error(val exception: Throwable) : Result<Nothing>()
    
    inline fun <R> fold(
        onSuccess: (T) -> R,
        onFailure: (Throwable) -> R
    ): R = when (this) {
        is Success -> onSuccess(data)
        is Error -> onFailure(exception)
    }
}

// Data class with validation
data class User(
    val id: Long,
    val email: String,
    val name: String
) {
    init {
        require(email.isNotBlank()) { "Email cannot be blank" }
        require(name.isNotBlank()) { "Name cannot be blank" }
        require(email.contains("@")) { "Email must be valid" }
    }
}

// Repository interface with clear contracts
interface UserRepository {
    /**
     * Creates a new user in the system
     * 
     * Preconditions:
     * - user.email must not exist in system
     * - user must pass validation
     * 
     * Postconditions:
     * - user is persisted with assigned ID
     * - returns success with created user
     */
    suspend fun createUser(user: User): Result<User>
    
    suspend fun findByEmail(email: String): Result<User?>
}

// Use case with contract enforcement
class RegisterUserUseCase(
    private val userRepository: UserRepository
) {
    suspend fun execute(email: String, name: String): Result<User> {
        // Precondition validation
        if (email.isBlank()) {
            return Result.Error(IllegalArgumentException("Email is required"))
        }
        if (name.isBlank()) {
            return Result.Error(IllegalArgumentException("Name is required"))
        }
        
        // Check business rules
        return userRepository.findByEmail(email).fold(
            onSuccess = { existingUser ->
                if (existingUser != null) {
                    Result.Error(IllegalStateException("Email already exists"))
                } else {
                    // Create user ensuring postconditions
                    val newUser = User(id = 0, email = email, name = name)
                    userRepository.createUser(newUser)
                }
            },
            onFailure = { error ->
                Result.Error(error)
            }
        )
    }
}

// ViewModel with error handling
class UserRegistrationViewModel(
    private val registerUserUseCase: RegisterUserUseCase
) : ViewModel() {
    
    private val _uiState = MutableLiveData<UiState>()
    val uiState: LiveData<UiState> = _uiState
    
    fun registerUser(email: String, name: String) {
        viewModelScope.launch {
            _uiState.value = UiState.Loading
            
            registerUserUseCase.execute(email, name).fold(
                onSuccess = { user ->
                    _uiState.value = UiState.Success(user)
                },
                onFailure = { error ->
                    _uiState.value = UiState.Error(error.message ?: "Unknown error")
                }
            )
        }
    }
    
    sealed class UiState {
        object Loading : UiState()
        data class Success(val user: User) : UiState()
        data class Error(val message: String) : UiState()
    }
}
```

## 🐚 Bash Development

### Core Rules
- **Shebang**: Always `#!/usr/bin/env bash`
- **Set Options**: Use `set -euo pipefail`
- **Quoting**: Always quote variables `"${var}"`
- **Functions**: Use local variables
- **Contract Validation**: Explicit argument checking

### Best Practices
```bash
#!/usr/bin/env bash
set -euo pipefail

# Global variables in UPPERCASE
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"

# Function with contract documentation
# Usage: transfer_funds <from_account> <to_account> <amount>
# Preconditions:
#   - from_account must exist and have sufficient balance
#   - to_account must exist
#   - amount must be positive number
# Postconditions:
#   - from_account balance decreased by amount
#   - to_account balance increased by amount
# Returns: 0 on success, 1 on error
transfer_funds() {
    local from_account="${1:?Error: from_account required}"
    local to_account="${2:?Error: to_account required}"
    local amount="${3:?Error: amount required}"
    
    # Precondition validation
    if [[ ! -f "accounts/${from_account}" ]]; then
        echo "Error: from_account '${from_account}' does not exist" >&2
        return 1
    fi
    
    if [[ ! -f "accounts/${to_account}" ]]; then
        echo "Error: to_account '${to_account}' does not exist" >&2
        return 1
    fi
    
    if ! [[ "${amount}" =~ ^[0-9]+(\.[0-9]+)?$ ]] || (( $(echo "${amount} <= 0" | bc -l) )); then
        echo "Error: amount must be a positive number" >&2
        return 1
    fi
    
    local from_balance
    from_balance=$(cat "accounts/${from_account}")
    
    if (( $(echo "${from_balance} < ${amount}" | bc -l) )); then
        echo "Error: insufficient funds in account '${from_account}'" >&2
        return 1
    fi
    
    # Implementation ensuring postconditions
    local new_from_balance
    local to_balance
    local new_to_balance
    
    new_from_balance=$(echo "${from_balance} - ${amount}" | bc -l)
    to_balance=$(cat "accounts/${to_account}")
    new_to_balance=$(echo "${to_balance} + ${amount}" | bc -l)
    
    # Atomic update
    echo "${new_from_balance}" > "accounts/${from_account}"
    echo "${new_to_balance}" > "accounts/${to_account}"
    
    echo "Successfully transferred ${amount} from ${from_account} to ${to_account}"
    return 0
}

# Error handling
trap 'echo "Error on line $LINENO"' ERR

# Main function with argument validation
main() {
    if (( $# < 3 )); then
        echo "Usage: $0 <from_account> <to_account> <amount>" >&2
        exit 1
    fi
    
    transfer_funds "$@"
}

# Execute main if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
```

## 🚫 Security and Quality Standards

### NEVER Rules (Non-negotiable)
- **NEVER: Delete production data without explicit confirmation**
- **NEVER: Hardcode API keys, passwords, or secrets**
- **NEVER: Commit code with failing tests or linting errors**
- **NEVER: Push directly to main/master branch**
- **NEVER: Skip security reviews for authentication/authorization code**
- **NEVER: Ignore error returns in Go**
- **NEVER: Use `any` type in TypeScript production code**
- **NEVER: Use `pip install` - always use `uv`**
- **NEVER: Use `!!` operator in Kotlin without explicit null check**
- **NEVER: Skip input validation in Bash scripts**

### YOU MUST Rules (Required Standards)
- **YOU MUST: Write tests for new features and bug fixes**
- **YOU MUST: Run CI/CD checks before marking tasks complete**
- **YOU MUST: Follow semantic versioning for releases**
- **YOU MUST: Document breaking changes**
- **YOU MUST: Use feature branches for all development**
- **YOU MUST: Add comprehensive documentation to all public APIs**
- **YOU MUST: Validate preconditions explicitly**
- **YOU MUST: Define clear interfaces before implementation**
- **YOU MUST: Use type-safe error handling patterns**

## 🌳 Git Worktree Workflow

### Why Git Worktree?
Git worktree allows working on multiple branches simultaneously without stashing or switching contexts. Each worktree is an independent working directory with its own branch.

### Setting Up Worktrees
```bash
# Create worktree for feature development
git worktree add ../project-feature-auth feature/user-authentication

# Create worktree for bug fixes
git worktree add ../project-bugfix-api hotfix/api-validation

# Create worktree for experiments
git worktree add ../project-experiment-new-ui experiment/compose-migration
```

### Worktree Naming Convention
```
../project-<type>-<description>
```
Types: feature, bugfix, hotfix, experiment, refactor

### Managing Worktrees
```bash
# List all worktrees
git worktree list

# Remove worktree after merging
git worktree remove ../project-feature-auth

# Prune stale worktree information
git worktree prune
```

## ⚡ Time-Saving Automations

### Smart Code Generation
```bash
# Generate Python module with tests and contracts
uv run cookiecutter gh:your-org/python-module-template

# Generate Go service with interfaces
go run github.com/vektra/mockery/v2@latest --all

# Generate Kotlin feature module
./gradlew generateFeatureModule --name=UserProfile

# Generate Bash script with contract validation
./scripts/new-script.sh script_name.sh
```

### Multi-Language Project Setup
```bash
#!/usr/bin/env bash
# Initialize multi-language project with contracts
mkdir -p {python,go,kotlin,scripts}/{src,tests}
uv init python/
go mod init github.com/user/project
cd kotlin && gradle init --type kotlin-application
echo "Contract-driven development setup complete"
```

## 🤖 AI-Powered Code Review

### Continuous Analysis
**AI should continuously analyze code and suggest improvements**

```
🔍 Code Analysis Results:
- Interface Design: 2 modules need clearer contracts
- Modularity: Found 3 coupling opportunities to reduce
- Contract Validation: 5 functions missing precondition checks
- Test Coverage: 85% → Suggest 3 additional test cases
- Documentation: 2 functions missing contract documentation
```

### Language-Specific Contract Improvements

**Python Contract Example:**
```python
# Before: Implicit assumptions
def calculate_discount(price, percentage):
    return price * (1 - percentage / 100)

# Suggested: Explicit contract
def calculate_discount(price: Decimal, percentage: int) -> Decimal:
    """Calculate discount with explicit contract validation.
    
    Preconditions:
        - price must be positive
        - percentage must be between 0 and 100
    
    Postconditions:
        - result is less than or equal to original price
        - result is non-negative
    """
    if price <= 0:
        raise ValueError("Price must be positive")
    if not 0 <= percentage <= 100:
        raise ValueError("Percentage must be between 0 and 100")
    
    result = price * (Decimal('100') - percentage) / Decimal('100')
    assert result <= price  # Postcondition check
    assert result >= 0      # Postcondition check
    return result
```

**Go Interface Example:**
```go
// Before: Vague interface
type Service interface {
    Process(data string) string
}

// Suggested: Contract-explicit interface
type PaymentProcessor interface {
    // ProcessPayment processes a payment transaction
    // Preconditions:
    //   - request must be valid
    //   - user must be authenticated
    // Postconditions:
    //   - transaction is recorded
    //   - payment status is updated
    ProcessPayment(ctx context.Context, request PaymentRequest) (*PaymentResult, error)
}
```

## 📊 Efficiency Metrics & Tracking

### Time Savings Report
**Generate weekly efficiency reports**

```
📈 This Week's Productivity Gains:
- Contract validation generated: 48 functions (saved ~6 hours)
- Interface definitions created: 12 modules (saved ~4 hours)
- Tests auto-generated: 156 test cases (saved ~8 hours)
- Documentation created: 89 functions (saved ~5 hours)
- Bugs prevented by contracts: 15 potential issues caught
- Refactoring automated: 8 patterns extracted
Total time saved: ~23 hours
```

## 🔧 Commit Standards

### Conventional Commits
```bash
# Format: <type>(<scope>): <subject>
git commit -m "feat(auth): add JWT token refresh contract"
git commit -m "fix(api): handle null response in user repository"
git commit -m "docs(contracts): update interface documentation"
git commit -m "refactor(user): extract validation to contract layer"
git commit -m "test(payment): add contract validation tests"
```

### Commit Trailers
```bash
# For contract-related changes
git commit --trailer "Contract-Change: interface updated"

# For GitHub issues
git commit --trailer "Github-Issue: #123"
```

### PR Guidelines
- Focus on high-level problem and solution
- Highlight contract changes and interface modifications
- Include impact on modularity and coupling
- Add specific reviewers as configured
- Include performance impact if relevant

---

**Remember: Engineer time is gold** - Design clear contracts, build modular systems, define explicit interfaces. Every interaction should save time and improve code quality through better architecture.
