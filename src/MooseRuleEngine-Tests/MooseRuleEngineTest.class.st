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

	rule1 := RuleMock1.
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

	self assertCollection: ruleEngine rules hasSameElements: { rule1 }
]

{ #category : 'tests' }
MooseRuleEngineTest >> testAddPreset [

	| preset |
	preset := MRERulePreset new.

	ruleEngine addPreset: preset.

	self assertCollection: ruleEngine presets hasSameElements: { preset }
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
MooseRuleEngineTest >> testDetectAndFixKeepsTheOtherRemediationsWhenAFixRaises [

	| remediations |
	ruleEngine rules: {
			rule1.
			RuleMockFixError }.
	ruleEngine files: { file1 }.

	remediations := ruleEngine detectAndFix.

	self assert: remediations size equals: 1.
	self assert: remediations first violation rule class equals: rule1.
	self assert: ruleEngine fixErrors size equals: 1
]

{ #category : 'tests' }
MooseRuleEngineTest >> testDetectIgnoresUnsupportedFiles [

	| violations |
	ruleEngine rules: { rule1 }.
	ruleEngine files: {
			file1.
			file2 }.

	violations := ruleEngine detect.

	self assert: violations size equals: 1.
	self
		assert: violations first rule class className
		equals: rule1 className
]

{ #category : 'tests' }
MooseRuleEngineTest >> testDetectMixedRuleTypes [

	| javaRule violations rules |
	javaRule := RuleMockJava.
	ruleEngine rules: {
			rule1.
			javaRule }.
	ruleEngine files: {
			file1.
			file2 }.

	violations := ruleEngine detect.

	self assert: violations size equals: 2.

	rules := violations collect: [ :violation | violation rule ].

	self
		assert: (rules collect: [ :rule | rule class className ]) asBag
		equals: {
				rule1 className.
				javaRule className } asBag
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
	violation1 := MREViolation new rule: rule1 new.

	result := ruleEngine fix: { violation1 }.

	self assert: result size equals: 1.
	self assert: result first class equals: MRERemediation
]

{ #category : 'tests' }
MooseRuleEngineTest >> testFixKeepsTheStackOfAFixThatRaises [

	| violation failure |
	violation := RuleMockFixError new analyse: file1.

	self assert: (ruleEngine fix: { violation }) isEmpty.

	failure := ruleEngine fixErrors first.
	self assert: failure violation equals: violation.
	self assert: failure stack sender method equals: RuleMockFixError >> #fix:.
	self assert: failure stack sender sender isNil.
	self
		assert: failure description
		equals: 'RuleMockFixError fix: failed on test.ts at 1: Error: no node at this position'
]

{ #category : 'tests' }
MooseRuleEngineTest >> testFuelOutAFixFailureWithoutItsSecrets [

	| violation file stack |
	violation := RuleMockFixError new analyse: file1.
	violation rule name: 'secret-token'.
	ruleEngine fix: { violation }.
	file := FileLocator temp / 'MooseRuleEngineTest.fuel'.

	[
	ruleEngine fixErrors first
		fuelOutTo: file
		redacting: { 'secret-token' }.
	stack := [
	         FLMaterializer materializeFromFileNamed: file fullName.
	         nil ]
		         on: FLDebuggerStackMaterialization
		         do: [ :materialization |
		         materialization instVarNamed: #interruptedContext ] ]
		ensure: [ file ensureDelete ].

	self assert: stack sender method equals: RuleMockFixError >> #fix:.
	self deny: stack sender receiver identicalTo: violation rule.
	self assert: stack sender receiver name equals: '<redacted>'
]

{ #category : 'tests' }
MooseRuleEngineTest >> testSetFiles [

	ruleEngine setFiles: {
			file1.
			file2 }.

	self assertCollection: ruleEngine files hasSameElements: {
			file1.
			file2 }
]

{ #category : 'tests' }
MooseRuleEngineTest >> testSetHelpers [

	| helper1 helper2 helper3 |
	helper1 := MREHelper new.
	helper2 := MREHelper new.

	helper3 := MREHelper new.

	ruleEngine addHelper: helper1.
	ruleEngine setHelpers: {
			helper2.
			helper3 }.

	self assertCollection: ruleEngine helpers hasSameElements: {
			helper2.
			helper3 }
]

{ #category : 'tests' }
MooseRuleEngineTest >> testSetModel [

	| model |
	model := MooseModel new.
	ruleEngine setModel: model.

	self assert: ruleEngine model equals: model
]

{ #category : 'tests' }
MooseRuleEngineTest >> testSetPresets [

	| testPresets |
	testPresets := #( MRETestChildPreset ).
	ruleEngine setPresets: testPresets.

	self
		assertCollection: ruleEngine presets
		hasSameElements: testPresets
]

{ #category : 'tests' }
MooseRuleEngineTest >> testSetRules [

	ruleEngine setRules: { rule1 }.

	self assertCollection: ruleEngine rules equals: { rule1 }
]
