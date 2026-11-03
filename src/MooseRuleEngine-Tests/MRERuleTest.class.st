"
A MRERuleTest is a test class for testing the behavior of MRERule
"
Class {
	#name : 'MRERuleTest',
	#superclass : 'TestCase',
	#category : 'MooseRuleEngine-Tests',
	#package : 'MooseRuleEngine-Tests'
}

{ #category : 'utilities' }
MRERuleTest >> entityFrom: start to: end [

	^ MREEntity new
		  startPos: start;
		  endPos: end
]

{ #category : 'utilities' }
MRERuleTest >> fileWith: content [

	^ MREFile new
		  path: 'test.java';
		  content: content
]

{ #category : 'tests' }
MRERuleTest >> testDoesNotApplyWithoutSupportedExtensions [

	| rule file |
	rule := MRERule new.
	file := MREFile new
		        path: 'test.java';
		        content: 'content'.

	self deny: (rule appliesToFile: file)
]

{ #category : 'tests' }
MRERuleTest >> testGetHelper [

	| rule helper |
	rule := MRERule new.

	rule helpers add: MRESonarqubeHelper new.

	helper := rule getHelper: 'sonarqube'.

	self assert: helper class equals: MRESonarqubeHelper
]

{ #category : 'tests - text' }
MRERuleTest >> testSourceOfIn [

	self assert: (MRERule new sourceOf: (self entityFrom: 2 to: 4) in: (self fileWith: 'abcdef')) equals: 'bcd'
]
