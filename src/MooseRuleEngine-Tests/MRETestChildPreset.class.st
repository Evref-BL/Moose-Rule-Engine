Class {
	#name : 'MRETestChildPreset',
	#superclass : 'MRERulePreset',
	#category : 'MooseRuleEngine-Tests',
	#package : 'MooseRuleEngine-Tests'
}

{ #category : 'accessing' }
MRETestChildPreset class >> parentPresets [

	^ { MRETestParentPreset }
]

{ #category : 'accessing' }
MRETestChildPreset class >> presetName [

	^ 'mre-test-child'
]

{ #category : 'accessing' }
MRETestChildPreset class >> rules [

	^ {
		  MRETestRuleOne.
		  MRETestRuleTwo }
]
