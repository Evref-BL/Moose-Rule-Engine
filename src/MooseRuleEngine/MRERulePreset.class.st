"
I define a named, reusable collection of MooseRuleEngine rule classes. Subclasses declare a stable lowercase preset name, optional parent preset names, and explicit rule class names on their class side.
"
Class {
	#name : 'MRERulePreset',
	#superclass : 'Object',
	#category : 'MooseRuleEngine',
	#package : 'MooseRuleEngine'
}

{ #category : 'accessing' }
MRERulePreset class >> parentPresets [

	self subclassResponsibility
]

{ #category : 'accessing' }
MRERulePreset class >> presetName [

	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
MRERulePreset class >> resolveRules [

	^ MRERulePresetResolver new
		  resolveWithPresets: self parentPresets
		  andRules: self rules
]

{ #category : 'accessing' }
MRERulePreset class >> rules [

	self subclassResponsibility
]
