"
I discover MRERulePreset subclasses and resolve their inheritance into an ordered, duplicate-free collection of rule classes.
"
Class {
	#name : 'MRERulePresetResolver',
	#superclass : 'Object',
	#instVars : [
		'presetsByName',
		'resolvedPresetNames',
		'resolvingPresetNames',
		'ruleNames'
	],
	#category : 'MooseRuleEngine',
	#package : 'MooseRuleEngine'
}

{ #category : 'resolving' }
MRERulePresetResolver class >> ruleClassesForPresetNames: presetNames [

	^ self new resolveRuleClassesForPresetNames: presetNames
]

{ #category : 'resolving' }
MRERulePresetResolver class >> rulesForPresetNames: presetNames [

	^ (self ruleClassesForPresetNames: presetNames) collect: [ :ruleClass | ruleClass new ]
]

{ #category : 'private - resolving' }
MRERulePresetResolver >> addRuleNamesFromPresetNamed: presetName [

	| presetClass |
	(resolvedPresetNames includes: presetName) ifTrue: [ ^ self ].
	(resolvingPresetNames includes: presetName) ifTrue: [
		self error: 'Cyclic preset inheritance: ' , (' -> ' join: resolvingPresetNames , { presetName }) ].

	presetClass := presetsByName at: presetName ifAbsent: [ self errorUnknownPresetNamed: presetName ].
	resolvingPresetNames add: presetName.
	presetClass parentPresetNames do: [ :parentPresetName | self addRuleNamesFromPresetNamed: parentPresetName ].
	ruleNames addAll: (presetClass ruleNames reject: [ :ruleName | ruleNames includes: ruleName ]).
	resolvingPresetNames removeLast.
	resolvedPresetNames add: presetName
]

{ #category : 'private - errors' }
MRERulePresetResolver >> errorUnknownPresetNamed: presetName [

	self error: 'Unknown preset ' , presetName , '. Available presets: ' , (', ' join: presetsByName keys sorted)
]

{ #category : 'initialization' }
MRERulePresetResolver >> initialize [

	super initialize.
	presetsByName := Dictionary new.
	resolvedPresetNames := Set new.
	resolvingPresetNames := OrderedCollection new.
	ruleNames := OrderedCollection new
]

{ #category : 'private - registration' }
MRERulePresetResolver >> registeredPresetsByName [

	| registeredPresets |
	registeredPresets := Dictionary new.
	MRERulePreset allSubclasses do: [ :presetClass |
			| presetName |
			presetName := presetClass presetName.
			presetName = presetName asLowercase ifFalse: [ self error: 'Preset names must be lowercase: ' , presetName ].
			registeredPresets
				at: presetName
				ifPresent: [ :registeredClass |
					self error: 'Duplicate preset name ' , presetName , ' declared by ' , registeredClass name , ' and ' , presetClass name ]
				ifAbsentPut: [ presetClass ] ].

	^ registeredPresets
]

{ #category : 'private - resolving' }
MRERulePresetResolver >> resolveRuleClassesForPresetNames: presetNames [

	^ (self ruleNamesForPresetNames: presetNames) collect: [ :ruleName | self ruleClassNamed: ruleName ] as: Array
]

{ #category : 'private - resolving' }
MRERulePresetResolver >> ruleClassNamed: ruleName [

	| ruleClass |
	ruleClass := Smalltalk at: ruleName asSymbol ifAbsent: [ self error: 'Unknown rule: ' , ruleName ].
	(ruleClass inheritsFrom: MRERule) ifFalse: [ self error: ruleName , ' is not an MRERule subclass' ].

	^ ruleClass
]

{ #category : 'private - resolving' }
MRERulePresetResolver >> ruleNamesForPresetNames: presetNames [

	presetsByName := self registeredPresetsByName.
	resolvedPresetNames := Set new.
	resolvingPresetNames := OrderedCollection new.
	ruleNames := OrderedCollection new.

	presetNames do: [ :presetName | self addRuleNamesFromPresetNamed: presetName ].

	^ ruleNames
]
