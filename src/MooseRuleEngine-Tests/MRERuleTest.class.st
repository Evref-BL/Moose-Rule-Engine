"
A MRERuleTest is a test class for testing the behavior of MRERule
"
Class {
	#name : #MRERuleTest,
	#superclass : #TestCase,
	#category : #'MooseRuleEngine-Tests'
}

{ #category : #tests }
MRERuleTest >> testGetHelper [

	| rule helper |
	rule := MRERule new.

	rule helpers add: MRESonarqubeHelper new.

	helper := rule getHelper: 'sonarqube'.

	self assert: helper class equals: MRESonarqubeHelper
]
