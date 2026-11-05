Class {
	#name : 'MooseRuleEngine',
	#superclass : 'Object',
	#instVars : [
		'rules',
		'files',
		'helpers',
		'model',
		'presets',
		'fixErrors'
	],
	#category : 'MooseRuleEngine',
	#package : 'MooseRuleEngine'
}

{ #category : 'adding' }
MooseRuleEngine >> addHelper: helper [

	helpers add: helper
]

{ #category : 'adding' }
MooseRuleEngine >> addPreset: preset [

	presets add: preset
]

{ #category : 'as yet unclassified' }
MooseRuleEngine >> detect [

	| violations allRules allRulesClasses |
	allRulesClasses := MRERulePresetResolver new
		                   resolveWithPresets: presets
		                   andRules: rules.
	allRules := allRulesClasses collect: [ :ruleClass |
			            | rule |
			            rule := ruleClass new.
			            rule helpers: helpers ].

	violations := allRules collect: [ :rule |
			              (files select: [ :file | rule appliesToFile: file ])
				              collect: [ :file | rule analyse: file ] ].

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
	"A rule that raises in fix: loses its violation, not the run: the error is kept in fixErrors"

	^ violations
		  collect: [ :violation |
				  [
				  MRERemediation new
					  violation: violation;
					  fixes: (violation rule fix: violation) ]
					  on: Error
					  do: [ :error |
							  fixErrors add:
								  (MREFixFailure violation: violation error: error).
							  nil ] ]
		  thenReject: [ :remediation | remediation isNil ]
]

{ #category : 'accessing' }
MooseRuleEngine >> fixErrors [
	"The MREFixFailure of each violation whose rule raised in fix:, left out of the remediations"

	^ fixErrors
]

{ #category : 'accessing' }
MooseRuleEngine >> helpers [

	^ helpers
]

{ #category : 'initialization' }
MooseRuleEngine >> initialize [

	super initialize.
	rules := OrderedCollection new.
	presets := OrderedCollection new.
	files := OrderedCollection new.
	helpers := OrderedCollection new.
	fixErrors := OrderedCollection new
]

{ #category : 'accessing' }
MooseRuleEngine >> model [

	^ model
]

{ #category : 'accessing' }
MooseRuleEngine >> model: aModel [

	model := aModel
]

{ #category : 'accessing' }
MooseRuleEngine >> presets [

	^ presets
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

	files := mreFiles
]

{ #category : 'initialization' }
MooseRuleEngine >> setHelpers: mreHelpers [

	helpers := helpers removeAll.
	mreHelpers do: [ :helper | self addHelper: helper ]
]

{ #category : 'initialization' }
MooseRuleEngine >> setModel: mooseModel [

	model := mooseModel
]

{ #category : 'initialization' }
MooseRuleEngine >> setPresets: presetClasses [

	presets := presetClasses
]

{ #category : 'initialization' }
MooseRuleEngine >> setRules: mreRules [

	rules := mreRules
]
