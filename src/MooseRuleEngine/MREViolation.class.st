Class {
	#name : 'MREViolation',
	#superclass : 'Object',
	#instVars : [
		'rule',
		'entities'
	],
	#category : 'MooseRuleEngine',
	#package : 'MooseRuleEngine'
}

{ #category : 'adding' }
MREViolation >> addEntity: entity [
	entities add: entity
]

{ #category : 'accessing' }
MREViolation >> entities [

	^ entities
]

{ #category : 'initialization' }
MREViolation >> initialize [ 
	entities := OrderedCollection new.
]

{ #category : 'accessing' }
MREViolation >> rule [

	^ rule
]

{ #category : 'accessing' }
MREViolation >> rule: anObject [

	rule := anObject
]
