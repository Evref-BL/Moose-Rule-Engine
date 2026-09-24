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
MRERulePresetResolver >> registerPreset: presetClass [

	| presetName |
	presetName := presetClass presetName.
	presetName = presetName asLowercase ifFalse: [ self error: 'Preset names must be lowercase: ' , presetName ].
	presetsByName
		at: presetName
		ifPresent: [ :registeredClass |
			self error: 'Duplicate preset name ' , presetName , ' declared by ' , registeredClass name , ' and ' , presetClass name ]
		ifAbsentPut: [ presetClass ]
]

{ #category : 'private - registration' }
MRERulePresetResolver >> registerPresets [

	MRERulePreset allSubclasses do: [ :presetClass | self registerPreset: presetClass ]
]

{ #category : 'private - resolving' }
MRERulePresetResolver >> resolvePresetNamed: presetName [

	| presetClass |
	(resolvedPresetNames includes: presetName) ifTrue: [ ^ self ].
	(resolvingPresetNames includes: presetName) ifTrue: [
		self error: 'Cyclic preset inheritance: ' , (' -> ' join: resolvingPresetNames , { presetName }) ].

	presetClass := presetsByName at: presetName ifAbsent: [ self errorUnknownPresetNamed: presetName ].
	resolvingPresetNames add: presetName.
	presetClass parentPresetNames do: [ :parentPresetName | self resolvePresetNamed: parentPresetName ].
	presetClass ruleNames do: [ :ruleName | (ruleNames includes: ruleName) ifFalse: [ ruleNames add: ruleName ] ].
	resolvingPresetNames removeLast.
	resolvedPresetNames add: presetName
]

{ #category : 'private - resolving' }
MRERulePresetResolver >> resolveRuleClassesForPresetNames: presetNames [

	self registerPresets.
	presetNames do: [ :presetName | self resolvePresetNamed: presetName ].

	^ ruleNames collect: [ :ruleName | self ruleClassNamed: ruleName ] as: Array
]

{ #category : 'private - resolving' }
MRERulePresetResolver >> ruleClassNamed: ruleName [

	| ruleClass |
	ruleClass := Smalltalk at: ruleName asSymbol ifAbsent: [ self error: 'Unknown rule: ' , ruleName ].
	(ruleClass inheritsFrom: MRERule) ifFalse: [ self error: ruleName , ' is not an MRERule subclass' ].

	^ ruleClass
]
