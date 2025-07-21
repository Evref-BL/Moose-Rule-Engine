# Moose-Rule-Engine

[![Continuous](https://github.com/Evref-BL/Moose-Rule-Engine/actions/workflows/continuous.yml/badge.svg)](https://github.com/Evref-BL/Moose-Rule-Engine/actions/workflows/continuous.yml)
[![Coverage Status](https://coveralls.io/repos/github/Evref-BL/Moose-Rule-Engine/badge.svg?branch=develop)](https://coveralls.io/github/Evref-BL/Moose-Rule-Engine?branch=develop)

Rule engine is a multi-language, rule-based engine for code analysis, automated remediation, and large-scale refactoring.

## Usage

### Installation

#### From playground

```st
Metacello new
  githubUser: 'Evref-BL' project: 'Moose-Rule-Engine' commitish: 'main' path: 'src';
  baseline: 'MooseRuleEngine';
  onConflict: [ :ex | ex useIncoming ];
  load
```

#### Baseline dependency

```st
spec baseline: 'MooseRuleEngine' with: [
	spec repository: 'github://Evref-BL/Moose-Rule-Engine:main' ];
```