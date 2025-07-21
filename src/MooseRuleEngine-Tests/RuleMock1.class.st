Class {
	#name : 'RuleMock1',
	#superclass : 'MRERule',
	#category : 'MooseRuleEngine-Tests',
	#package : 'MooseRuleEngine-Tests'
}

{ #category : 'running' }
RuleMock1 >> analyse: file [
	"take a MREFile and return an Collection of MREViolation"

	^ MREViolation new rule: self
]

{ #category : 'running' }
RuleMock1 >> fix: violation [
	"take a MREViolation and return a collection of MREFix"

	| fix |
	fix := MREFix new.
	^ { fix }
]
