"
A MooseRuleEngineTest is a test class for testing the behavior of MooseRuleEngine
"
Class {
	#name : 'MooseRuleEngineTest',
	#superclass : 'TestCase',
	#instVars : [
		'rule1',
		'ruleEngine',
		'file1',
		'file2'
	],
	#category : 'MooseRuleEngine-Tests',
	#package : 'MooseRuleEngine-Tests'
}

{ #category : 'running' }
MooseRuleEngineTest >> setUp [

	super setUp.

	rule1 := RuleMock1 new.
	ruleEngine := MooseRuleEngine new.

	file1 := MREFile new
		         path: 'test.ts';
		         content: 'content'.
	file2 := MREFile new
		         path: 'test.java';
		         content: 'class Java {}'
]

{ #category : 'tests' }
MooseRuleEngineTest >> testAddHelper [

	| helper |
	helper := MREHelper new.

	ruleEngine setRules: { rule1 }.
	ruleEngine addHelper: helper.

	self
		assertCollection: ruleEngine rules first helpers
		hasSameElements: { helper }
]

{ #category : 'tests' }
MooseRuleEngineTest >> testDetect [

	| violations |
	file1 := MREFile new
		         path: 'test.ts';
		         content: 'content'.

	ruleEngine rules: { rule1 }.
	ruleEngine files: { file1 }.

	violations := ruleEngine detect.
	self assert: violations size equals: 1
]

{ #category : 'tests' }
MooseRuleEngineTest >> testDetectAndFix [

	| result |
	ruleEngine rules: { rule1 }.
	ruleEngine files: { file1 }.
	
	result := ruleEngine detectAndFix.
	
	self assert: result size equals: 1
]

{ #category : 'tests' }
MooseRuleEngineTest >> testDetectWithoutFiles [

	| violations |
	ruleEngine rules: { rule1 }.

	violations := ruleEngine detect.

	self assert: violations isEmpty
]

{ #category : 'tests' }
MooseRuleEngineTest >> testDetectWithoutRulesOrFiles [

	| violations |
	violations := ruleEngine detect.

	self assert: violations isEmpty
]

{ #category : 'tests' }
MooseRuleEngineTest >> testFix [

	| violation1 result |
	violation1 := MREViolation new rule: rule1.
	
	result := ruleEngine fix: { violation1 }.
	
	self assert: result size equals: 1.
]

{ #category : 'tests' }
MooseRuleEngineTest >> testSetFiles [

	ruleEngine setFiles: {
			file1.
			file2 }.

	self assertCollection: ruleEngine files hasSameElements: {
			file1.
			file2 }.

]

{ #category : 'tests' }
MooseRuleEngineTest >> testSetHelpers [

	| helper1 helper2 helper3 rule |
	helper1 := MREHelper new.
	helper2 := MREHelper new.

	helper3 := MREHelper new.
	
	rule := MRERule new.
	
	ruleEngine setRules: { rule }.
	ruleEngine addHelper: helper1.
	ruleEngine setHelpers: {
			helper2.
			helper3 }.

	self assertCollection: ruleEngine helpers hasSameElements: {
			helper2.
			helper3 }.
	
	self assertCollection: rule helpers hasSameElements: {
			helper2.
			helper3 }
]

{ #category : 'tests' }
MooseRuleEngineTest >> testSetModel [

	| model |
	model := MooseModel new.
	
	ruleEngine setRules: { rule1 }.
	ruleEngine setModel: model.
	
	self assert: ruleEngine model equals: model.
	self assert: rule1 model equals: model.
]

{ #category : 'tests' }
MooseRuleEngineTest >> testSetModelSetRuleAfter [

	| model |
	model := MooseModel new.

	ruleEngine setModel: model.	
	ruleEngine setRules: { rule1 }.
	
	self assert: ruleEngine model equals: model.
	self assert: rule1 model equals: model.
]

{ #category : 'tests' }
MooseRuleEngineTest >> testSetRules [

	| helper |
	helper := MREHelper new.
	ruleEngine setRules: {rule1}.
	ruleEngine addHelper: helper.

	self assertCollection: ruleEngine rules equals: { rule1 }.

	self assertCollection: ruleEngine rules first helpers hasSameElements: { helper }
]
