Class {
	#name : 'MooseRuleEngine',
	#superclass : 'Object',
	#instVars : [
		'rules',
		'files',
		'helpers',
		'model'
	],
	#category : 'MooseRuleEngine',
	#package : 'MooseRuleEngine'
}

{ #category : 'adding' }
MooseRuleEngine >> addHelper: helper [

	helpers add: helper.
]

{ #category : 'as yet unclassified' }
MooseRuleEngine >> detect [
	| violations |
	violations := rules collect: [ :rule |
		files collect: [ :file | rule analyse: file ].
	].

	^ violations flattened 
	
]

{ #category : 'as yet unclassified' }
MooseRuleEngine >> detectAndFix [

	| violations |
	violations := self detect.

	^ self fix: violations
]

{ #category : 'accessing' }
MooseRuleEngine >> files [

	^ files
]

{ #category : 'accessing' }
MooseRuleEngine >> files: anObject [

	files := anObject
]

{ #category : 'fix - static' }
MooseRuleEngine >> fix: violations [

	^violations collect: [ :violation |
		| fixes |
		fixes := violation rule fix: violation.
		violation -> fixes ]
]

{ #category : 'accessing' }
MooseRuleEngine >> helpers [

	^ helpers
]

{ #category : 'initialization' }
MooseRuleEngine >> initialize [

	rules := OrderedCollection new.
	files := OrderedCollection new.
	helpers := OrderedCollection new.
]

{ #category : 'accessing' }
MooseRuleEngine >> model [
	^model
]

{ #category : 'accessing' }
MooseRuleEngine >> model: aModel [
	model := aModel 
]

{ #category : 'accessing' }
MooseRuleEngine >> rules [

	^ rules
]

{ #category : 'accessing' }
MooseRuleEngine >> rules: anObject [

	rules := anObject
]

{ #category : 'initialization' }
MooseRuleEngine >> setFiles: mreFiles [

	files := mreFiles collect: [ :file |
		         file model ifNil:
			         [ file model: (MREParser new parse: file) ] ifNotNil: [ file ] ]
]

{ #category : 'initialization' }
MooseRuleEngine >> setHelpers: mreHelpers [

	helpers := helpers removeAll.
	mreHelpers do: [ :helper | self addHelper: helper ]
]

{ #category : 'initialization' }
MooseRuleEngine >> setModel: mooseModel [
	model := mooseModel.
	
	rules do: [ :rule | rule model: model ].
]

{ #category : 'initialization' }
MooseRuleEngine >> setRules: mreRules [

	rules := mreRules collect: [ :rule | 
		rule helpers: helpers .
		rule model: model	
	]
]
