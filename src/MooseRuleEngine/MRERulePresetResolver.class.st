"
I discover MRERulePreset subclasses and resolve their inheritance into an ordered, duplicate-free collection of rule classes.
"
Class {
	#name : 'MRERulePresetResolver',
	#superclass : 'Object',
	#instVars : [
		'resolvingPresetNames'
	],
	#category : 'MooseRuleEngine',
	#package : 'MooseRuleEngine'
}

{ #category : 'initialization' }
MRERulePresetResolver >> initialize [

	super initialize.
	resolvingPresetNames := OrderedCollection new
]

{ #category : 'as yet unclassified' }
MRERulePresetResolver >> resolveWithPresets: presets andRules: rules [

	| presetsRules |
	presetsRules := presets flatCollectAsSet: [ :preset |
			                (resolvingPresetNames includes: preset) ifTrue: [
					                self error:
						                'Cyclic preset inheritance: ' , (' -> ' join:
							                 ((resolvingPresetNames copyWith: preset)
								                  collect: [ :each | each presetName ])) ].
			                resolvingPresetNames addLast: preset.
			                [
			                self
				                resolveWithPresets: preset parentPresets
				                andRules: preset rules ] ensure: [
				                resolvingPresetNames removeLast ] ].

	presetsRules addAll: rules.

	^ presetsRules
]
