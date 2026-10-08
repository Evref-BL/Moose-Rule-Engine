Class {
	#name : 'MRETestCycleBPreset',
	#superclass : 'MRERulePreset',
	#category : 'MooseRuleEngine-Tests',
	#package : 'MooseRuleEngine-Tests'
}

{ #category : 'accessing' }
MRETestCycleBPreset class >> parentPresets [

	^ { MRETestCycleAPreset }
]

{ #category : 'accessing' }
MRETestCycleBPreset class >> presetName [

	^ 'mre-test-cycle-b'
]

{ #category : 'accessing' }
MRETestCycleBPreset class >> rules [

	^ {  }
]
