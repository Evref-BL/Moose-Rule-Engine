Class {
	#name : 'MRERemediation',
	#superclass : 'Object',
	#instVars : [
		'violation',
		'fixes'
	],
	#category : 'MooseRuleEngine',
	#package : 'MooseRuleEngine'
}

{ #category : 'accessing' }
MRERemediation >> fixes [

	^ fixes
]

{ #category : 'accessing' }
MRERemediation >> fixes: anObject [

	fixes := anObject
]

{ #category : 'accessing' }
MRERemediation >> violation [

	^ violation
]

{ #category : 'accessing' }
MRERemediation >> violation: anObject [

	violation := anObject
]
