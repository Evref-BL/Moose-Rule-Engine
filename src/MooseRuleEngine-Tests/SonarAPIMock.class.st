Class {
	#name : 'SonarAPIMock',
	#superclass : 'Object',
	#instVars : [
		'issues'
	],
	#category : 'MooseRuleEngine-Tests',
	#package : 'MooseRuleEngine-Tests'
}

{ #category : 'initialization' }
SonarAPIMock >> initialize [ 
	issues := Object new.
]

{ #category : 'accessing' }
SonarAPIMock >> issues [

	^ issues
]
