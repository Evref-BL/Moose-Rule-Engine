"
A MREViolationTest is a test class for testing the behavior of MREViolation
"
Class {
	#name : 'MREViolationTest',
	#superclass : 'TestCase',
	#category : 'MooseRuleEngine-Tests',
	#package : 'MooseRuleEngine-Tests'
}

{ #category : 'tests' }
MREViolationTest >> testAddEntity [

	| entity violation |
	entity := MooseModel new.
	
	violation := MREViolation new.
	
	violation addEntity: entity.
	
	self assertCollection: violation entities hasSameElements: { entity }  
]
