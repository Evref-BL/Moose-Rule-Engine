"
MREEntity is a class designed to represent an entity within the Moose Rule Engine.

It encapsulates two main attributes: `file` and `model`, which can be accessed and modified
through dedicated accessor methods. The `file` attribute typically represents a file associated
with the entity, while the `model` attribute represents the underlying model or data structure
linked to the entity.

Instance Variables:
- file: Represents the file associated with this entity.
- model: Represents the model or data structure linked to this entity.

This class belongs to the MooseRuleEngine category and serves as a foundational component
for managing entities within the rule engine.
"
Class {
	#name : #MREEntity,
	#superclass : #Object,
	#instVars : [
		'file',
		'startPos',
		'endPos',
		'model'
	],
	#category : #MooseRuleEngine
}

{ #category : #accessing }
MREEntity >> endLine [

	^ file content lineNumberCorrespondingToIndex: endPos
]

{ #category : #accessing }
MREEntity >> endPos [

	^ endPos
]

{ #category : #accessing }
MREEntity >> endPos: anObject [

	endPos := anObject
]

{ #category : #accessing }
MREEntity >> file [

	^ file
]

{ #category : #accessing }
MREEntity >> file: anObject [

	file := anObject
]

{ #category : #accessing }
MREEntity >> model [

	^model
]

{ #category : #accessing }
MREEntity >> model: anObject [

	model := anObject
]

{ #category : #accessing }
MREEntity >> startLine [

	^ file content lineNumberCorrespondingToIndex: startPos
]

{ #category : #accessing }
MREEntity >> startPos [

	^ startPos
]

{ #category : #accessing }
MREEntity >> startPos: anObject [

	startPos := anObject
]

{ #category : #evaluating }
MREEntity >> value [
	^file content copyFrom: startPos to: endPos.
]
