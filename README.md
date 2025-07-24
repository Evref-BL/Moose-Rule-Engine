# Moose-Rule-Engine

[![Continuous](https://github.com/Evref-BL/Moose-Rule-Engine/actions/workflows/continuous.yml/badge.svg)](https://github.com/Evref-BL/Moose-Rule-Engine/actions/workflows/continuous.yml)
[![Coverage Status](https://coveralls.io/repos/github/Evref-BL/Moose-Rule-Engine/badge.svg?branch=develop)](https://coveralls.io/github/Evref-BL/Moose-Rule-Engine?branch=develop)

Moose-Rule-Engine is a multi-language, rule-based engine designed for code analysis, automated remediation, and large-scale refactoring. 

---

## Table of Contents

1. [Features](#features)
2. [Installation](#installation)
   - [From Playground](#from-playground)
   - [Baseline Dependency](#baseline-dependency)
3. [Usage](#usage)
4. [Core Concepts](#core-concepts)
   - [Rule](#rule)
   - [Helper](#helper)
     - [SonarQube Helper](#sonarqube-helper)
     - [LLM Helper](#llm-helper)

---

## Features

- **Multi-language support**: Analyze and refactor code across multiple programming languages.
- **Rule-based engine**: Define custom rules for code analysis and remediation.
- **Automated fixes**: Automatically apply fixes to detected violations.
- **Extensible helpers**: Integrate with external systems like SonarQube or LLMs.

---

## Installation

### From Playground

To load the Moose-Rule-Engine from the Playground, run the following script:

```st
Metacello new
  githubUser: 'Evref-BL' project: 'Moose-Rule-Engine' commitish: 'main' path: 'src';
  baseline: 'MooseRuleEngine';
  onConflict: [ :ex | ex useIncoming ];
  load.
```

### Baseline Dependency

To include Moose-Rule-Engine as a dependency in your project, add the following to your baseline:

```st
spec baseline: 'MooseRuleEngine' with: [
  spec repository: 'github://Evref-BL/Moose-Rule-Engine:main'.
].
```

---

## Usage

MooseRuleEngine take files and rules and return a collection of fixes. Here is a step by step on how to use it

### 1. Initialize the Rule Engine

Start by creating an instance of the `MooseRuleEngine`:

```st
ruleEngine := MooseRuleEngine new.
```

### 2. Set Up Files

You need to provide the files you want to analyze. Create a file object and add it to the engine:

```st
file := File new path: '<path/to/your/file>'; content: '<file content>'; model: '<model moose of your file>'.

ruleEngine setFiles: { file }.
```
### Optional: Set a Project Model

You can optionally define a model that represents your project, such as a Famix model. This model will be injected into all your rules, providing additional context for analysis and fixes:

```st
ruleEngine setModel: model.
```

### 3. Define Rules

Define the rules you want to apply. Rules are objects that analyze files and suggest fixes. Add your rules to the engine:

```st
rule := MyCustomRule new.
ruleEngine setRules: { rule }.
```

### 4. Add Helpers (Optional)

Helpers can be used to enhance the functionality of your rules. For example, you can add a SonarQube helper:

```st
sonarqubeApi := SonarQubeApi new host: '<your_sonarqube_host>'; privateToken: '<your_private_token>'.
sonarHelper := MRESonarqubeHelper new 
  sonarqubeApi: sonarqubeApi;
  projectKey: 'your_project_key';
  type: 'all'.

ruleEngine addHelper: sonarHelper.
```

### 5. Run the Engine

Run the engine to detect and fix issues in the provided files:

```st
fixes := ruleEngine detectAndFix.
```

### 6. Review the Output

The engine returns a collection of fixes. Each fix contains the following attributes:
- **startPos**: Start position of the fix.
- **endPos**: End position of the fix.
- **content**: New content between start and end position
- **file**: File where the fix is applied.


## Core Concepts

### Rule

Rules are the core of the Moose-Rule-Engine. A rule has:
- **Name**: A unique identifier.
- **Description**: A brief explanation of the rule.

#### Example Initialization

```st
initialize
  super initialize.
  name := 'name'.
  description := 'description'.
```

#### Methods

- `analyse`: Takes an `MREFile` and returns a collection of `MREViolation`.
- `fix`: Takes an `MREViolation` and returns a collection of `MREFix`.

### Helper

Helpers are classes injected into rules to assist in writing them. They are useful for interacting with external systems like SonarQube or LLMs.

#### Creating a Helper

To create a helper, extend `MREHelper` and define a name.

#### Accessing a Helper in a Rule

```st
rule getHelper: 'helperName'.
```

#### SonarQube Helper

The SonarQube helper allows you to use SonarQube analysis in your rules.

##### Example Usage

```st
sonarHelper violationsOf: rule inFile: file usingRuleId: sonarRuleId.
```

##### Initialization

```st
sonarqubeApi := SonarQubeApi new host: '<your_sonarqube_host>'; privateToken: '<your_private_token>'.

sonarHelper := MRESonarqubeHelper new 
  sonarqubeApi: sonarqubeApi;
  projectKey: 'your_project_key';
  type: 'all'.
```

#### LLM Helper

The LLM helper can fix violations using a language model.

##### Example Usage

```st
llmHelper fix: code withMessage: message.
```

##### Initialization

```st
llmApi := LLMAPI chat.
llmApi host: '<llm_host>'.
llmApi apiKey: '<llm_api_key>'.
llmHelper := MRELLMHelper new llmApi: llmApi.
```