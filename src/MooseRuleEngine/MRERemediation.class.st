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

{ #category : 'adding' }
MRERemediation >> addFix: fix [
	fixes push: fix
]

{ #category : 'accessing' }
MRERemediation >> fixes [

	^ fixes
]

{ #category : 'accessing' }
MRERemediation >> fixes: anObject [

	fixes := anObject
]

{ #category : 'initialization' }
MRERemediation >> initialize [ 
	fixes := {  }.
]

{ #category : 'accessing' }
MRERemediation >> violation [

	^ violation
]

{ #category : 'accessing' }
MRERemediation >> violation: anObject [

	violation := anObject
]
