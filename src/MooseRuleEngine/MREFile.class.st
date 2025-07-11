"
MREFile represents a file within the Moose Rule Engine.
It encapsulates attributes such as `path`, `content`, and `model`,
providing accessor methods for managing these properties.

Instance Variables:
- path: The file's location.
- content: The file's data.
- model: The associated model or structure.
"
Class {
	#name : #MREFile,
	#superclass : #Object,
	#instVars : [
		'path',
		'content',
		'model'
	],
	#category : #MooseRuleEngine
}

{ #category : #accessing }
MREFile >> content [

	^ content
]

{ #category : #accessing }
MREFile >> content: anObject [

	content := anObject
]

{ #category : #accessing }
MREFile >> model [

	^ model
]

{ #category : #accessing }
MREFile >> model: anObject [

	model := anObject
]

{ #category : #accessing }
MREFile >> path [

	^ path
]

{ #category : #accessing }
MREFile >> path: anObject [

	path := anObject
]
