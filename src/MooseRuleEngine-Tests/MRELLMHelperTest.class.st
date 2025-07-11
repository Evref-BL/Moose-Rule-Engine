"
A MRELLMHelperTest is a test class for testing the behavior of MRELLMHelper
"
Class {
	#name : #MRELLMHelperTest,
	#superclass : #TestCase,
	#instVars : [
		'llmApi',
		'helper'
	],
	#category : #'MooseRuleEngine-Tests'
}

{ #category : #running }
MRELLMHelperTest >> setUp [

	super setUp.

	llmApi := LLMAPI chat.
	helper := MRELLMHelper new llmApi: llmApi
]

{ #category : #tests }
MRELLMHelperTest >> testCleanLLMOutput [

	| output cleanedOutput |
	"Given"
	output := ' test '.

	"When"
	cleanedOutput := helper cleanLLMOutput: output.

	"Then"
	self assert: cleanedOutput equals: 'test'
]

{ #category : #tests }
MRELLMHelperTest >> testCleanLLMOutputOnCodeBlock [

	| output cleanedOutput |
	"Given"
	output := '``` test ```'.

	"When"
	cleanedOutput := helper cleanLLMOutput: output.

	"Then"
	self assert: cleanedOutput equals: 'test'
]

{ #category : #tests }
MRELLMHelperTest >> testCleanLLMOutputOnSingleBackTick [

	| output cleanedOutput |
	"Given"
	output := '`test `'.

	"When"
	cleanedOutput := helper cleanLLMOutput: output.

	"Then"
	self assert: cleanedOutput equals: 'test'
]

{ #category : #tests }
MRELLMHelperTest >> testCleanLLMOutputStartWithBacktickJava [

	| output cleanedOutput |
	"Given"
	output := '```java
class HelloWorld { }
```'.

	"When"
	cleanedOutput := helper cleanLLMOutput: output.

	"Then"
	self assert: cleanedOutput equals: 'class HelloWorld { }'
]

{ #category : #tests }
MRELLMHelperTest >> testCleanLLMOutputStartWithJava [

	| output cleanedOutput |
	"Given"
	output := 'java
class HelloWorld { }'.

	"When"
	cleanedOutput := helper cleanLLMOutput: output.

	"Then"
	self assert: cleanedOutput equals: 'class HelloWorld { }'
]

{ #category : #tests }
MRELLMHelperTest >> testFix [

	| rule file entity violation fixes |
	rule := MRERule new description: 'test'.
	file := MREFile new
		        path: 'test.ts';
		        content: 'aaaaaaa'.
	entity := MREEntity new
		          file: file;
		          startPos: 1;
		          endPos: 4.

	violation := MREViolation new
		             rule: rule;
		             addEntity: entity.
		
	(llmApi stub performRequest) willReturn: '``` test ```'.
	fixes := helper fix: violation.

	self assert: fixes size equals: 1.
	self assert: fixes first content equals: 'test'
]
