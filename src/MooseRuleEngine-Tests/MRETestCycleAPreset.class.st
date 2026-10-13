Class {
	#name : 'MRETestCycleAPreset',
	#superclass : 'MRERulePreset',
	#category : 'MooseRuleEngine-Tests',
	#package : 'MooseRuleEngine-Tests'
}

{ #category : 'accessing' }
MRETestCycleAPreset class >> parentPresets [

	^ { MRETestCycleBPreset }
]

{ #category : 'accessing' }
MRETestCycleAPreset class >> presetName [

	^ 'mre-test-cycle-a'
]

{ #category : 'accessing' }
MRETestCycleAPreset class >> rules [

	^ {  }
]
