Class {
	#name : #MRERule,
	#superclass : #Object,
	#instVars : [
		'name',
		'description',
		'helpers',
		'model'
	],
	#category : #MooseRuleEngine
}

{ #category : #running }
MRERule >> analyse: file [
	"take a MREFile and return an Collection of MREViolation"
	
	^self subclassResponsibility 
]

{ #category : #accessing }
MRERule >> description [

	^ description
]

{ #category : #accessing }
MRERule >> description: anObject [

	description := anObject
]

{ #category : #running }
MRERule >> fix: violation [
	"take a MREViolation and return a collection of MREFix"
	
	^self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
MRERule >> getHelper: helperName [

	^ helpers
		  detect: [ :helper |
			  helper name = helperName ]
		  ifFound: [ :helper | helper ]
		  ifNone: [ nil ]
]

{ #category : #accessing }
MRERule >> helpers [

	^ helpers
]

{ #category : #accessing }
MRERule >> helpers: anObject [

	helpers := anObject
]

{ #category : #initialization }
MRERule >> initialize [ 
helpers := OrderedCollection new.
]

{ #category : #accessing }
MRERule >> model [

	^ model
]

{ #category : #accessing }
MRERule >> model: anObject [

	model := anObject
]

{ #category : #accessing }
MRERule >> name [

	^ name
]

{ #category : #accessing }
MRERule >> name: anObject [

	name := anObject
]
